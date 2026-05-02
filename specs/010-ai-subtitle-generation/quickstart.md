# Quickstart: AI Subtitle Generation

## Tổng quan

Feature này thêm khả năng tạo phụ đề tự động từ audio video sử dụng Soniox STT API, bao gồm dịch real-time và xuất file SRT.

## Luồng hoạt động chính

```
User nhấn 🤖 → AiSubtitleManager.start()
  → CxAudioProcessor bắt đầu capture PCM
  → SonioxClient.connect() mở WebSocket
  → PCM data stream → WebSocket → Soniox STT
  → SubtitleEvent flow → Subtitle overlay rendering
  
User nhấn 🤖 lần nữa → AiSubtitleManager.stop()
  → Hỏi export SRT? → SrtExporter.write()
  → SonioxClient.disconnect()
  → SubtitleCacheManager.save()
```

## Dependencies cần thêm

```kotlin
// Room DB (cho subtitle cache)
implementation(libs.androidx.room.runtime)
implementation(libs.androidx.room.ktx)
ksp(libs.androidx.room.compiler)

// OkHttp đã có - dùng cho WebSocket
// Không cần thêm dependency mới cho WebSocket
```

## Files cần tạo mới

```
CxPlayer/app/src/main/java/com/cxplayer/
├── player/
│   └── CxAudioProcessor.kt         # Extract + resample PCM
├── subtitle/
│   ├── SonioxClient.kt              # WebSocket → Soniox STT  
│   ├── AiSubtitleManager.kt         # Orchestrator
│   ├── SrtExporter.kt               # Export .srt file
│   └── SubtitleCacheManager.kt      # Room DB cache
├── data/
│   ├── db/
│   │   ├── AppDatabase.kt           # Room database
│   │   ├── CachedSubtitleEntity.kt  # Room entity
│   │   └── SubtitleDao.kt           # Room DAO
│   └── model/
│       ├── SubtitleEvent.kt         # Sealed class
│       ├── SrtEntry.kt              # SRT entry data class
│       └── SonioxConfig.kt          # Config data class
```

## Files cần sửa

```
├── player/CxRenderersFactory.kt     # Inject CxAudioProcessor
├── ui/player/PlayerActivity.kt      # Thêm nút 🤖, xử lý toggle
├── res/layout/activity_player.xml   # Thêm UI elements cho AI subtitle
└── app/build.gradle.kts             # Thêm Room dependencies
```

## Cách test nhanh

1. Cấu hình API key Soniox
2. Mở video có tiếng nói
3. Nhấn nút 🤖 → phụ đề xuất hiện real-time
4. Chờ ~30s → nhấn 🤖 tắt → chọn Export SRT
5. Kiểm tra file SRT được tạo
