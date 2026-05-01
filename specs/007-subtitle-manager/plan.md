# Implementation Plan: Subtitle Manager

**Branch**: `[008-subtitle-manager]` | **Date**: 2026-04-30 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/007-subtitle-manager/spec.md`

## Summary

Bổ sung một `SubtitleManager` nhỏ bám vào playback stack Media3 hiện có để xử lý bốn việc trong cùng một seam: tự dò phụ đề ngoài cho file local cùng tên, nạp phụ đề ngoài vào `MediaItem` đang phát, quản lý chọn/tắt text track nhúng qua `TrackSelectionParameters`, và áp style hiển thị trực tiếp lên `PlayerView.subtitleView`. Thiết kế giữ `CxPlayerManager` tiếp tục là owner của player session, dùng `PlayerActivity` làm orchestration point cho hành động UI hiện có, và giới hạn scope ở một video đang mở thay vì mở thêm popup track selector, playlist hay persistence cài đặt.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Gradle Kotlin DSL, Android bytecode Java 11  
**Primary Dependencies**: AndroidX Media3 1.10.0 (`media3-exoplayer`, `media3-common`, `media3-ui`, `media3-session`, `media3-extractor`, `media3-datasource`), AppCompat 1.7.0, Material 1.12.0, Android `ContentResolver`/`Uri`/`File` APIs  
**Storage**: N/A; feature chỉ giữ subtitle source state và style state trong runtime của phiên phát hiện tại  
**Testing**: JUnit4 host-side cho `SubtitleManager` và mapping runtime state; smoke/regression qua `PlayerActivityPlaybackTest`; `assembleDebug` và `compileDebugAndroidTestKotlin` để xác nhận wiring UI + Media3 compile đúng  
**Target Platform**: Ứng dụng Android điện thoại/tablet, minSdk 24, target/compile SDK 36  
**Project Type**: Android mobile app một module ứng dụng chính, dùng local playback stack Media3 hiện có  
**Performance Goals**: Phụ đề auto-detect hoặc phụ đề được người dùng chọn phải hiển thị trong vòng 2 giây kể từ khi video sẵn sàng hoặc thao tác chọn hoàn tất; thay đổi style phải thấy hiệu lực ngay trong phiên xem hiện tại; lỗi phụ đề ngoài không được làm gián đoạn playback  
**Constraints**: Chỉ một nguồn subtitle hoạt động tại một thời điểm; giữ nguyên vị trí phát và `playWhenReady` khi phải rebuild `MediaItem`; auto-detect mặc định chỉ áp dụng cho `file://` hoặc đường dẫn cục bộ có cùng tên cơ bản với video; không mở rộng sang audio track, popup selector riêng, playlist hoặc persistence đa phiên; tận dụng `PlayerView.subtitleView` thay vì tạo lớp render subtitle mới  
**Scale/Scope**: Một module `CxPlayer/app`, một manager runtime mới dưới `com.cxplayer.player`, chỉnh sửa `PlayerActivity` và có thể chạm `activity_player.xml`/resource strings nếu cần expose action subtitle, cùng một lát test host-side và androidTest cho playback screen

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` hiện vẫn là template placeholder, nên gate được suy ra từ repo rules trong `AGENTS.md`, feature spec hiện hành và seam code đã có.

- **Gate 1 - Scope containment**: PASS. Plan chỉ bao phủ subtitle management cho một video đang mở. Popup track selector riêng, audio track selection, playlist và shuffle tiếp tục là feature sau.
- **Gate 2 - Simplicity first**: PASS. Giải pháp dùng đúng primitive sẵn có của Media3 là `MediaItem.SubtitleConfiguration`, `TrackSelectionParameters` và `PlayerView.subtitleView`, tránh dựng subtitle pipeline tùy biến hoặc state store mới.
- **Gate 3 - Existing seam reuse**: PASS. `PlayerActivity` đã giữ `PlaybackRequest`, lifecycle và settings action placeholder; `CxPlayerManager` đã là owner của player session; plan chỉ thêm một collaborator `SubtitleManager` thay vì thay public contract của manager.
- **Gate 4 - Validation before completion**: PASS. Plan khóa validation bằng unit tests cho detection/selection/style state, compile checks cho wiring Android, và manual verification trên sample `.srt`, `.ass`, `.vtt`, embedded subtitle và bad subtitle.

**Post-design re-check**: PASS. `research.md`, `data-model.md`, `quickstart.md` và contract đều giữ cùng một hướng: subtitle source state là runtime-only, Media3 primitives là đường tích hợp chính, và orchestration tiếp tục nằm trong activity/player seams hiện có.

## Project Structure

### Documentation (this feature)

```text
specs/007-subtitle-manager/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── subtitle-manager-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
└── app/
    ├── src/main/java/com/cxplayer/player/
    │   ├── CxPlayerManager.kt
    │   ├── CxRenderersFactory.kt
    │   └── SubtitleManager.kt
    ├── src/main/java/com/cxplayer/ui/player/
    │   └── PlayerActivity.kt
    ├── src/main/res/layout/
    │   └── activity_player.xml
    ├── src/test/java/com/cxplayer/player/
    │   ├── CxPlayerManagerTest.kt
    │   └── SubtitleManagerTest.kt
    ├── src/test/java/com/cxplayer/ui/player/
    │   └── PlayerActivityLaunchParserTest.kt
    └── src/androidTest/java/com/cxplayer/ui/player/
        └── PlayerActivityPlaybackTest.kt
```

**Structure Decision**: Giữ toàn bộ thay đổi trong `CxPlayer/app` và hai package đã tồn tại là `com.cxplayer.player` và `com.cxplayer.ui.player`. `SubtitleManager.kt` là runtime service gần player nhất vì nó thao tác trực tiếp với `ExoPlayer`/`PlayerView`; `PlayerActivity.kt` giữ phần orchestration do đã có `PlaybackRequest`, `settingsButton` placeholder và lifecycle attach/release; test vẫn ưu tiên host-side quanh mapping logic, còn `PlayerActivityPlaybackTest` chỉ làm smoke/regression cho màn hình phát.

## Complexity Tracking

Không có vi phạm gate nào cần justification ở pha planning này.