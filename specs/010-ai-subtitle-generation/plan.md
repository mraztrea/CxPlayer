# Implementation Plan: AI Subtitle Generation

**Branch**: `011-ai-subtitle-generation` | **Date**: 2026-05-01 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/010-ai-subtitle-generation/spec.md`

## Summary

Tự động tạo phụ đề từ audio video bằng Soniox STT API qua WebSocket. Trích xuất PCM từ ExoPlayer AudioProcessor, stream tới Soniox để nhận dạng giọng nói + dịch real-time, hiển thị phụ đề lên overlay, hỗ trợ xuất SRT và cache phụ đề trong Room DB.

## Technical Context

**Language/Version**: Kotlin 2.x, Java 11 (compatibility)
**Primary Dependencies**: Media3 ExoPlayer (AudioProcessor), OkHttp (WebSocket), Room DB (cache), Hilt (DI)
**Storage**: Room Database (subtitle cache), File system (SRT export)
**Testing**: JUnit (unit tests), AndroidJUnitRunner (instrumented tests)
**Target Platform**: Android API 24+
**Project Type**: Mobile App (Android)
**Performance Goals**: Phụ đề hiển thị trong ≤3s từ lúc phát âm, audio passthrough không bị delay/méo
**Constraints**: Cần kết nối internet cho lần đầu, session reset mỗi 3 phút, auto-reconnect tối đa 3 lần
**Scale/Scope**: Đơn thiết bị, 1 video tại 1 thời điểm, cache không giới hạn số video

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

Constitution chưa được cấu hình (chỉ có template placeholder). Không có gates cụ thể cần kiểm tra. ✅ PASS — tiếp tục.

## Project Structure

### Documentation (this feature)

```text
specs/010-ai-subtitle-generation/
├── plan.md              # This file
├── spec.md              # Feature specification
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/
│   ├── soniox-websocket.md    # External API contract
│   └── internal-interfaces.md # Internal component contracts
├── checklists/
│   └── requirements.md # Spec quality checklist
└── tasks.md             # Phase 2 output (NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
CxPlayer/app/src/main/java/com/cxplayer/
├── MainActivity.kt
├── data/
│   ├── datasource/
│   │   ├── CxDataSourceFactory.kt
│   │   └── SmbDataSource.kt
│   ├── db/                              # NEW: Room database
│   │   ├── AppDatabase.kt
│   │   ├── CachedSubtitleEntity.kt
│   │   └── SubtitleDao.kt
│   └── model/                           # NEW: Data models
│       ├── SubtitleEvent.kt
│       ├── SrtEntry.kt
│       └── SonioxConfig.kt
├── network/
│   └── SmbBrowser.kt
├── player/
│   ├── CxAudioProcessor.kt             # NEW: PCM extraction
│   ├── CxLoadControl.kt
│   ├── CxMediaSourceFactory.kt
│   ├── CxPlayerManager.kt
│   ├── CxRenderersFactory.kt           # MODIFY: inject AudioProcessor
│   ├── SubtitleManager.kt
│   └── TrackSelectorSessionController.kt
├── subtitle/                            # NEW: AI subtitle package
│   ├── SonioxClient.kt
│   ├── AiSubtitleManager.kt
│   ├── SrtExporter.kt
│   └── SubtitleCacheManager.kt
└── ui/
    ├── controls/
    │   ├── NetworkBrowserDialog.kt
    │   └── TrackSelector.kt
    └── player/
        ├── GestureController.kt
        ├── GestureOverlayState.kt
        └── PlayerActivity.kt           # MODIFY: AI subtitle toggle UI

CxPlayer/app/src/main/res/
└── layout/
    └── activity_player.xml              # MODIFY: AI subtitle button + overlay

CxPlayer/app/
└── build.gradle.kts                     # MODIFY: Room dependencies
```

**Structure Decision**: Sử dụng cấu trúc Android app đã có. Thêm package `subtitle/` cho logic AI subtitle, `data/db/` cho Room database, `data/model/` cho data classes. Giữ `CxAudioProcessor` trong `player/` vì nó là phần mở rộng của ExoPlayer pipeline.

## Complexity Tracking

Không có violations cần justify — constitution chưa được cấu hình.
