# Contract: Internal Component Interfaces

**Type**: Internal Kotlin interfaces
**Date**: 2026-05-01

## CxAudioProcessor

Trích xuất PCM data từ luồng audio ExoPlayer.

```kotlin
// Input: ByteBuffer từ ExoPlayer audio pipeline
// Output: ByteArray PCM 16kHz mono qua callback
interface AudioDataListener {
    fun onPcmData(data: ByteArray)
}
```

**Behavior**:
- Nhận audio ở bất kỳ format nào từ ExoPlayer
- Resample sang 16kHz mono PCM (pcm_s16le)
- Gọi callback với PCM data
- Pass-through audio nguyên bản cho output (không ảnh hưởng playback)

## SonioxClient

WebSocket client kết nối Soniox STT API.

```kotlin
// Input: SonioxConfig + PCM ByteArray stream
// Output: SharedFlow<SubtitleEvent>
interface SonioxClientContract {
    val subtitleFlow: SharedFlow<SubtitleEvent>
    val connectionState: StateFlow<ConnectionState>
    
    fun connect(config: SonioxConfig)
    fun sendAudio(pcmData: ByteArray)
    fun disconnect()
}

enum class ConnectionState {
    IDLE, CONNECTING, ACTIVE, ERROR, RECONNECTING, FAILED
}
```

## AiSubtitleManager

Orchestrator điều phối toàn bộ luồng AI subtitle.

```kotlin
// Input: Video playback state + user toggle
// Output: Subtitle events cho overlay rendering
interface AiSubtitleManagerContract {
    val isActive: StateFlow<Boolean>
    val subtitleEvents: SharedFlow<SubtitleEvent>
    val connectionState: StateFlow<ConnectionState>
    
    fun start(config: SonioxConfig)
    fun stop(): List<SrtEntry>  // Returns collected entries for SRT export
    fun onAudioData(pcmData: ByteArray)
}
```

## SrtExporter

Xuất danh sách SrtEntry ra file SRT.

```kotlin
// Input: List<SrtEntry> + File destination
// Output: File SRT chuẩn
interface SrtExporterContract {
    fun write(entries: List<SrtEntry>, file: File)
    fun formatTime(ms: Long): String  // "HH:MM:SS,mmm"
}
```

## SubtitleCacheManager

Quản lý cache phụ đề trong Room DB.

```kotlin
// Input: Video URI + List<SrtEntry>
// Output: Cached subtitle data
interface SubtitleCacheContract {
    suspend fun getCachedSubtitle(videoUri: String): CachedSubtitle?
    suspend fun saveSubtitle(videoUri: String, entries: List<SrtEntry>, language: String, targetLanguage: String)
    suspend fun deleteCache(videoUri: String)
    suspend fun hasCache(videoUri: String): Boolean
}
```
