# Implementation Plan: Playback Gesture Controller

**Branch**: `[004-gesture-controller]` | **Date**: 2026-04-30 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/004-gesture-controller/spec.md`

## Summary

Thêm `GestureController` làm touch coordinator tập trung cho `PlayerView`, chịu trách nhiệm diễn giải đầy đủ bộ gesture playback với mapping định lượng đã chốt ở spec: vuốt dọc bên phải đổi âm lượng theo nhịp `1 bước / 150px`, vuốt dọc bên trái đổi độ sáng `0,05 / 150px`, vuốt ngang tạo `seek delta = distance * 100ms`, double tap giữa để play/pause, double tap hai bên để seek `±10s`, long press kích hoạt `2x`, và pinch zoom trong dải `1,0x -> 3,0x`. `PlayerActivity` tiếp tục là integration point duy nhất với `CxPlayerManager`, `AudioManager` và `Window` brightness để giữ `GestureController` ở mức phát ý định điều khiển.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Android SDK touch APIs, Android bytecode Java 11  
**Primary Dependencies**: AndroidX Media3 1.10.0 `PlayerView`, AppCompat 1.7.0, Android framework `GestureDetector`/`ScaleGestureDetector`, ViewBinding, AndroidX Test  
**Storage**: N/A; feature chỉ quản lý runtime touch state và callback intent  
**Testing**: JUnit4 host-side cho zone math, axis lock, threshold math và callback sequencing; instrumentation tests trong `CxPlayer/app/src/androidTest` cho `PlayerView` touch dispatch và lifecycle wiring; manual verification trên thiết bị cảm ứng cho toàn bộ gesture mapping  
**Target Platform**: Ứng dụng Android điện thoại, minSdk 24, target/compile SDK 36  
**Project Type**: Android mobile app một module, UI player dùng XML `PlayerView` + `AppCompatActivity`  
**Performance Goals**: Gesture feedback phải đủ tức thời để người dùng không cảm nhận trễ trên màn hình 60Hz; không phát ra outcome mâu thuẫn trong cùng một gesture session; quantized mapping phải ổn định khi lặp lại cùng thao tác  
**Constraints**: Giữ `PlayerView` làm video surface chính với `app:use_controller="false"`; `GestureController` chỉ phát callback intent chứ không tự tạo side effect hệ thống; overlay UI, speed selector, aspect ratio và repeat mode nằm ngoài phạm vi feature này; validation trong môi trường Windows phải dùng PowerShell và có thể cần chấp nhận prompt cài test app trên thiết bị thật  
**Scale/Scope**: Một gesture coordinator runtime, một điểm tích hợp trong `PlayerActivity`, một contract touch surface, cùng bộ test host-side + instrumentation bao phủ 8 mapping gesture chính

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` vẫn là template placeholder, nên gate thực tế được suy ra từ quy ước repo và spec hiện hành.

- **Gate 1 - Scope containment**: PASS. Planning chỉ bao phủ gesture mapping cho playback surface; các phần overlay UI, speed selector, aspect ratio và repeat mode vẫn bị chặn ngoài scope.
- **Gate 2 - Simplicity first**: PASS. Giữ nguyên kiến trúc một module, không thêm service/module mới, không đổi sang Compose và không đẩy side effect vào `GestureController`.
- **Gate 3 - Existing stack reuse**: PASS. Tái sử dụng `PlayerView`, `PlayerActivity`, `CxPlayerManager`, detector API của Android và hạ tầng test hiện có.
- **Gate 4 - Validation before completion**: PASS. Pha design chốt rõ unit test cho threshold math và instrumentation/manual verification cho touch integration trên `PlayerView`.

**Post-design re-check**: PASS. `research.md`, `data-model.md`, `quickstart.md` và contract đã phản ánh cùng một mapping định lượng, không còn `NEEDS CLARIFICATION`, và không phát sinh complexity cần justification.

## Project Structure

### Documentation (this feature)

```text
specs/004-gesture-controller/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── gesture-controller-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
└── app/
    ├── src/main/java/com/cxplayer/
    │   ├── player/
    │   │   └── CxPlayerManager.kt
    │   └── ui/player/
    │       ├── GestureController.kt
    │       └── PlayerActivity.kt
    ├── src/main/res/layout/
    │   └── activity_player.xml
    ├── src/test/java/com/cxplayer/ui/player/
    │   └── GestureControllerTest.kt
    └── src/androidTest/java/com/cxplayer/ui/player/
        └── PlayerActivityPlaybackTest.kt
```

**Structure Decision**: Giữ feature hoàn toàn trong `CxPlayer/app`. `GestureController.kt` nằm cùng package với `PlayerActivity.kt` để bám sát màn hình phát hiện có; `CxPlayerManager.kt` chỉ tham gia ở boundary playback state như long-press 2x; test tách thành host-side cho gesture math và instrumentation cho `PlayerView` integration.

## Complexity Tracking

Không có vi phạm gate nào cần justification ở pha planning này.
