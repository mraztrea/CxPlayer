# Implementation Plan: Track Selector UI

**Branch**: `[009-track-selector-ui]` | **Date**: 2026-05-01 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/008-track-selector-ui/spec.md`

## Summary

Thêm một `PopupWindow` chọn track bám vào playback screen hiện có để người dùng đổi audio track, chọn phụ đề nhúng hoặc phụ đề ngoài đã được nạp trước đó, và tắt phụ đề ngay trong lúc xem. Thiết kế giữ `CxPlayerManager` tiếp tục làm owner của player session, giữ `SubtitleManager` làm owner cho subtitle source/style runtime state, và thêm một seam selector nhỏ đọc `player.currentTracks.groups` cho audio rồi hợp nhất với danh sách subtitle từ `SubtitleManager` để dựng UI mỗi lần popup mở ra.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Gradle Kotlin DSL, Android bytecode Java 11  
**Primary Dependencies**: AndroidX Media3 1.10.0 (`media3-exoplayer`, `media3-common`, `media3-ui`, `media3-session`), AppCompat 1.7.0, Material 1.12.0, Android framework `PopupWindow`/`LayoutInflater`/view binding APIs  
**Storage**: N/A; selector chỉ dùng runtime state của audio/subtitle cho phiên phát hiện tại  
**Testing**: JUnit4 host-side cho mapping audio/text tracks và selector state; `PlayerActivityPlaybackTest` cho popup wiring/smoke; `assembleDebug` và `compileDebugAndroidTestKotlin` để xác nhận compile của UI playback  
**Target Platform**: Ứng dụng Android điện thoại/tablet, minSdk 24, target/compile SDK 36  
**Project Type**: Android mobile app một module ứng dụng chính với playback stack Media3 nội bộ  
**Performance Goals**: Popup selector phải mở với trạng thái track hiện tại ngay trong lần tap đầu; thay đổi audio track hoặc subtitle track phải phản ánh trong vòng 2 giây; selector không được làm gián đoạn playback hoặc làm mất session state  
**Constraints**: UI selector phải dùng `PopupWindow` theo feature scope; selector content phải được rebuild từ state hiện tại mỗi lần mở để tránh cache stale; audio track selection đi qua `TrackSelectionParameters`/`TrackSelectionOverride`; subtitle selection phải tiếp tục tương thích với `SubtitleManager`; không mở rộng sang subtitle styling dialog, playlist, shuffle hoặc next/previous  
**Scale/Scope**: Một module `CxPlayer/app`, thêm một lớp UI controls mới, một seam controller nhỏ cho audio track state, một vài layout/string resource cho popup, cùng lát test host-side + androidTest trên playback screen hiện tại

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` vẫn là template placeholder, nên gate được suy ra từ repo rules trong `AGENTS.md`, spec hiện hành và seam code đã có.

- **Gate 1 - Scope containment**: PASS. Plan chỉ bao phủ audio/subtitle track selector cho một video đang mở. Không kéo thêm playlist, shuffle, next/previous hoặc dialog styling hoàn chỉnh.
- **Gate 2 - Simplicity first**: PASS. Thiết kế dùng `PopupWindow`, state runtime hiện có từ `SubtitleManager`, và `TrackSelectionParameters` của Media3 thay vì thêm state store riêng hoặc một màn hình settings mới.
- **Gate 3 - Existing seam reuse**: PASS. `PlayerActivity` đã giữ `settingsButton`, `overflowButton`, lifecycle và testing helpers; `CxPlayerManager` đã lộ player session ở mức internal; plan chỉ thêm collaborator selector nhỏ thay vì đổi ownership của playback stack.
- **Gate 4 - Validation before completion**: PASS. Plan khóa validation bằng host-side tests cho audio/text mapping và instrumentation smoke cho playback screen mở selector, đổi lựa chọn và giữ playback active.

**Post-design re-check**: PASS. `research.md`, `data-model.md`, `quickstart.md` và contract đều giữ cùng một hướng: selector chỉ là UI lớp mỏng trên player state hiện có, audio selection đi qua Media3 overrides, subtitle selection vẫn đi qua `SubtitleManager`, và luồng nạp phụ đề ngoài hiện hữu không bị loại bỏ.

## Project Structure

### Documentation (this feature)

```text
specs/008-track-selector-ui/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── track-selector-ui-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
└── app/
    ├── src/main/java/com/cxplayer/player/
    │   ├── CxPlayerManager.kt
    │   ├── SubtitleManager.kt
    │   └── TrackSelectorSessionController.kt
    ├── src/main/java/com/cxplayer/ui/controls/
    │   └── TrackSelector.kt
    ├── src/main/java/com/cxplayer/ui/player/
    │   └── PlayerActivity.kt
    ├── src/main/res/layout/
    │   ├── activity_player.xml
    │   ├── popup_track_selector.xml
    │   └── item_track_selector_option.xml
    ├── src/main/res/values/
    │   └── strings.xml
    ├── src/test/java/com/cxplayer/player/
    │   ├── SubtitleManagerTest.kt
    │   └── TrackSelectorSessionControllerTest.kt
    └── src/androidTest/java/com/cxplayer/ui/player/
        └── PlayerActivityPlaybackTest.kt
```

**Structure Decision**: Giữ toàn bộ thay đổi trong `CxPlayer/app`. `TrackSelector.kt` nằm ở `ui.controls` vì đây là UI component dùng `PopupWindow` và biết cách render section audio/subtitle. `TrackSelectorSessionController.kt` nằm ở `player` vì nó đọc `Player.currentTracks.groups` và áp audio override về đúng Media3 seam mà không làm `SubtitleManager` phình ra khỏi trách nhiệm subtitle. `PlayerActivity.kt` tiếp tục là orchestration point để mở selector từ `settingsButton`, giữ đường vào nạp phụ đề ngoài hiện có qua `overflowButton`, và nối feedback user-facing.

## Complexity Tracking

Không có vi phạm gate nào cần justification ở pha planning này.
