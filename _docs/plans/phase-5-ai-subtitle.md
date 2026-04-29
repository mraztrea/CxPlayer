# Phase 5: AI Subtitle Generation (Soniox)

**Thời gian ước tính**: 2 tuần
**Phụ thuộc**: Phase 1 (core player), Phase 3 (subtitle system)
**Mục tiêu**: Tự động tạo subtitle từ audio video bằng Soniox API, hỗ trợ dịch real-time.
**Tham chiếu**: Port từ dự án [my-translator](../../my-translator) — file `src/js/soniox.js`

---

## Checklist

- [ ] 5.1 CxAudioProcessor (trích xuất PCM từ ExoPlayer)
- [ ] 5.2 Audio resampler (input format → 16kHz mono PCM)
- [ ] 5.3 SonioxClient WebSocket (connect, sendAudio, parseResponse)
- [ ] 5.4 SonioxClient: session timer + seamless reset (mỗi 3 phút)
- [ ] 5.5 SonioxClient: keepalive (mỗi 15s)
- [ ] 5.6 SonioxClient: context builder (terms, translation_terms)
- [ ] 5.7 AiSubtitleManager (orchestrate audio → STT → display)
- [ ] 5.8 SubtitleEvent flow → subtitle overlay rendering
- [ ] 5.9 SRT exporter (xuất file SRT khi xem xong)
- [ ] 5.10 Subtitle cache (Room DB, tránh gọi API lại)
- [ ] 5.11 UI: AI subtitle toggle button [🤖]
- [ ] 5.12 Error handling (API key invalid, rate limit, reconnect)

---

## Dependencies bổ sung

```groovy
// OkHttp đã có từ Phase 4 — dùng cho WebSocket
// Room DB đã có từ Phase 6 (hoặc thêm ở đây nếu Phase 5 trước)
```

## Cấu trúc files

```
app/src/main/java/com/cxplayer/
├── player/
│   └── CxAudioProcessor.kt        # Extract PCM from playback
├── subtitle/
│   ├── SonioxClient.kt             # WebSocket to Soniox STT
│   ├── AiSubtitleManager.kt        # Orchestrator
│   ├── SrtExporter.kt              # Export to .srt file
│   └── SubtitleCacheManager.kt     # Cache in Room DB
└── domain/model/
    ├── SubtitleEvent.kt
    └── SrtEntry.kt
```

---

## Specs chi tiết

### 5.1 Luồng hoạt động

```
Video Playback
    → ExoPlayer AudioProcessor (CxAudioProcessor)
    → Resample to 16kHz mono PCM
    → WebSocket (wss://stt-rt.soniox.com/transcribe-websocket)
    → Soniox STT + Translation
    → SubtitleEvent (Original / Translation / Provisional)
    → Subtitle Overlay
    → (optional) Export SRT
```

### 5.2 CxAudioProcessor

```kotlin
class CxAudioProcessor : BaseAudioProcessor() {
    var onPcmData: ((ByteArray) -> Unit)? = null

    override fun queueInput(inputBuffer: ByteBuffer) {
        // Resample to 16kHz mono for Soniox
        val pcm = resampleTo16kMono(inputBuffer, inputFormat)
        onPcmData?.invoke(pcm)
        // Pass through unchanged to speakers
        replaceOutputBuffer(inputBuffer.remaining()).put(inputBuffer).flip()
    }
}
```

**Lưu ý**: AudioProcessor được inject vào ExoPlayer qua RenderersFactory.
Audio output không bị ảnh hưởng — chỉ copy thêm PCM ra ngoài.

### 5.3 SonioxClient

Port từ `my-translator/src/js/soniox.js`. Các key points:

```kotlin
class SonioxClient(private val scope: CoroutineScope) {
    private var ws: WebSocket? = null
    private val _subtitleFlow = MutableSharedFlow<SubtitleEvent>()
    val subtitleFlow: SharedFlow<SubtitleEvent> = _subtitleFlow

    data class Config(
        val apiKey: String,
        val sourceLanguage: String = "auto",     // hoặc "en", "ja", ...
        val targetLanguage: String = "vi",
        val translationTerms: List<TranslationTerm> = emptyList()
    )

    fun connect(config: Config) { /* WebSocket connect + send config */ }
    fun sendAudio(pcmData: ByteArray) { ws?.send(pcmData.toByteString()) }
    fun disconnect() { ws?.close(1000, "stopped") }
}
```

**Config JSON gửi khi connect** (tham chiếu soniox.js line 95-131):
```json
{
    "api_key": "...",
    "model": "stt-rt-v4",
    "audio_format": "pcm_s16le",
    "sample_rate": 16000,
    "num_channels": 1,
    "enable_endpoint_detection": true,
    "max_endpoint_delay_ms": 3000,
    "enable_speaker_diarization": true,
    "enable_language_identification": true,
    "translation": {
        "type": "one_way",
        "target_language": "vi"
    }
}
```

**Response parsing** (tham chiếu soniox.js `_handleResponse`):
- Token có `translation_status`: `"original"`, `"translation"`, `"none"`
- Token có `is_final`: true/false (provisional vs finalized)
- Emit `SubtitleEvent.Original`, `.Translation`, `.Provisional` tương ứng

### 5.4 Session management (từ my-translator)

- **Session reset**: mỗi 3 phút, mở WebSocket mới trước khi đóng cũ (make-before-break)
- **Context carryover**: giữ 500 ký tự dịch gần nhất, truyền vào `context.text`
- **Keepalive**: gửi `{"type": "keepalive"}` mỗi 15s khi không có audio
- **Auto-reconnect**: tối đa 3 lần, delay tăng dần (2s, 4s, 6s)

### 5.5 SubtitleEvent

```kotlin
sealed class SubtitleEvent {
    data class Original(val text: String, val lang: String?) : SubtitleEvent()
    data class Translation(val text: String) : SubtitleEvent()
    data class Provisional(val text: String) : SubtitleEvent()
}
```

### 5.6 SRT Export

```kotlin
data class SrtEntry(
    val index: Int,
    val startMs: Long,
    val endMs: Long,
    val text: String
)

object SrtExporter {
    fun write(entries: List<SrtEntry>, file: File) {
        file.bufferedWriter().use { writer ->
            entries.forEach { entry ->
                writer.appendLine("${entry.index}")
                writer.appendLine("${formatTime(entry.startMs)} --> ${formatTime(entry.endMs)}")
                writer.appendLine(entry.text)
                writer.appendLine()
            }
        }
    }
}
```

### 5.7 UI

```
┌──────────────────────────────────────────┐
│ [← Back]  Video Title     [🤖 AI] [⚙️] │  ← 🤖 toggle AI subtitle
│                                          │
│              PlayerView                  │
│   ┌────────────────────────────────┐     │
│   │ 🤖 Xin chào, hôm nay...      │     │  ← AI-generated subtitle
│   │    Hello, today...             │     │  ← Translation (nếu bật)
│   └────────────────────────────────┘     │
│  00:12:34 ═══════●═══════════ 01:45:00   │
│       [⏪]    [⏯️]    [⏩]    [🔊] [⚙️]  │
└──────────────────────────────────────────┘
```

- Nút 🤖 trên toolbar: toggle bật/tắt AI subtitle
- Khi bật: hiện connecting indicator → text xuất hiện
- Khi tắt: hỏi "Export SRT?" nếu có subtitle data

---

## Soniox API Notes

- **Endpoint**: `wss://stt-rt.soniox.com/transcribe-websocket`
- **Cost**: ~$0.12/giờ
- **Latency**: ~2-3 giây
- **Languages**: 70+ nguồn, dịch sang bất kỳ
- **API Key**: Đăng ký tại https://console.soniox.com/signup/

---

## Verification

1. Bật AI subtitle → video có tiếng nói → transcript xuất hiện real-time
2. Chọn target language "vi" → translation hiện dưới original
3. Pause video → subtitle dừng, resume → tiếp tục
4. Tắt AI subtitle → hỏi export → save .srt → mở bằng text editor verify
5. Xem lại video đã tạo subtitle → load từ cache, không gọi API
6. Sai API key → hiện error toast "Invalid API key"
7. Mất mạng → auto reconnect → tiếp tục
