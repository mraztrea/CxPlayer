# Phase 3: Advanced Media

**Thời gian ước tính**: 2 tuần
**Phụ thuộc**: Phase 1 hoàn thành
**Mục tiêu**: FFmpeg decoder, subtitle system, audio/subtitle track selection, playlist.

---

## Checklist

- [ ] 3.1 FFmpeg integration (media3-decoder-ffmpeg)
- [ ] 3.2 CxRenderersFactory (prefer FFmpeg over MediaCodec)
- [ ] 3.3 SubtitleManager: load external subtitle (SRT, ASS, VTT)
- [ ] 3.4 SubtitleManager: auto-detect subtitle file next to video
- [ ] 3.5 SubtitleManager: embedded subtitle track selection
- [ ] 3.6 Subtitle styling (font size, bold, color, edge)
- [ ] 3.7 Audio track selection
- [ ] 3.8 Track Selector UI (PopupWindow)
- [ ] 3.9 Playlist / queue support (multiple videos)
- [ ] 3.10 Shuffle mode + Next/Previous controls

---

## Dependencies bổ sung

```groovy
implementation "androidx.media3:media3-decoder-ffmpeg:$media3"
implementation "androidx.media3:media3-exoplayer-hls:$media3"
implementation "androidx.media3:media3-exoplayer-dash:$media3"
```

## Cấu trúc files

```
app/src/main/java/com/cxplayer/
├── player/
│   ├── CxRenderersFactory.kt      # FFmpeg-enabled renderers
│   └── SubtitleManager.kt         # External + embedded subtitles
├── ui/controls/
│   ├── TrackSelector.kt           # Audio/subtitle picker popup
│   └── SubtitleDialog.kt          # Subtitle style settings
└── domain/model/
    ├── TrackInfo.kt
    └── SubtitleTrack.kt
```

---

## Specs chi tiết

### 3.1 FFmpeg Integration

```kotlin
class CxRenderersFactory(context: Context) : DefaultRenderersFactory(context) {
    init {
        setExtensionRendererMode(EXTENSION_RENDERER_MODE_PREFER)
    }
}
```

**Codec support:**

| Codec | Hardware | FFmpeg | Notes |
|-------|----------|--------|-------|
| H.264 | ✅ | fallback | Most common |
| H.265/HEVC | ✅ | fallback | 4K content |
| AC3/EAC3 | ❌ | ✅ | Movie audio |
| DTS/DTS-HD | ❌ | ✅ | Blu-ray audio |
| FLAC | ✅ | ✅ | |
| TrueHD | ❌ | ✅ | Lossless |

### 3.2 SubtitleManager

```kotlin
class SubtitleManager(private val player: ExoPlayer) {
    fun loadExternalSubtitle(uri: Uri, mimeType: String = MimeTypes.APPLICATION_SUBRIP) {
        val subtitle = MediaItem.SubtitleConfiguration.Builder(uri)
            .setMimeType(mimeType)
            .setLanguage("vi")
            .setSelectionFlags(C.SELECTION_FLAG_DEFAULT)
            .build()
        val current = player.currentMediaItem ?: return
        val updated = current.buildUpon()
            .setSubtitleConfigurations(listOf(subtitle))
            .build()
        val pos = player.currentPosition
        player.setMediaItem(updated, pos)
        player.prepare()
    }

    fun autoDetectSubtitle(videoUri: Uri): Uri? {
        val videoPath = videoUri.path ?: return null
        val baseName = videoPath.substringBeforeLast(".")
        val extensions = listOf(".srt", ".ass", ".ssa", ".vtt")
        for (ext in extensions) {
            val subFile = File(baseName + ext)
            if (subFile.exists()) return Uri.fromFile(subFile)
        }
        return null
    }

    fun setSubtitleStyle(fontSize: Int, bold: Boolean) {
        val typeface = if (bold) Typeface.DEFAULT_BOLD else Typeface.DEFAULT
        playerView.subtitleView?.setStyle(
            CaptionStyleCompat(Color.WHITE, Color.TRANSPARENT, Color.TRANSPARENT,
                CaptionStyleCompat.EDGE_TYPE_OUTLINE, Color.BLACK, typeface)
        )
        playerView.subtitleView?.setFixedTextSize(TypedValue.COMPLEX_UNIT_SP, fontSize.toFloat())
    }
}
```

**Supported formats:** `.srt`, `.ass`/`.ssa`, `.vtt`, embedded MKV/MP4

### 3.3 Track Selector UI

```kotlin
data class TrackInfo(
    val groupIndex: Int,
    val trackIndex: Int,
    val label: String,      // "English", "5.1 AC3"
    val isSelected: Boolean,
    val type: Int            // C.TRACK_TYPE_AUDIO or C.TRACK_TYPE_TEXT
)
```

```
┌─────────────────────┐
│ 🔊 Audio Tracks     │
│ ● English 5.1 (AC3) │
│ ○ Vietnamese Stereo  │
├─────────────────────┤
│ 💬 Subtitles        │
│ ● Vietnamese (SRT)   │
│ ○ English (embedded) │
│ ○ Off                │
└─────────────────────┘
```

---

## Verification

1. Play MKV with DTS audio → FFmpeg decoder kicks in, audio plays
2. Place `video.srt` next to `video.mp4` → auto-detected, subtitle shows
3. Load external ASS subtitle → hiển thị đúng
4. Open track selector → chọn audio track khác → switch OK
5. Subtitle styling → đổi font size → thay đổi ngay
6. Playlist: mở nhiều video → Next/Previous hoạt động
7. Shuffle mode → random order
