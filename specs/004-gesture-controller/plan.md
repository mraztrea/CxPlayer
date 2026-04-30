# Implementation Plan: Playback Gesture Controller

**Branch**: `[005-gesture-controller]` | **Date**: 2026-04-30 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/004-gesture-controller/spec.md`

## Summary

Thêm `GestureController` làm touch coordinator tập trung cho `PlayerView`, chịu trách nhiệm phân loại swipe dọc, swipe ngang, double tap, long press và pinch thành callback intent theo mapping của Phase 2. Implementation giữ `PlayerActivity` là integration point duy nhất với `CxPlayerManager`, `AudioManager` và `window` brightness, nhờ đó task 2.1 hoàn thành mà không kéo theo overlay UI hay thay đổi controller mặc định của Media3.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Android SDK touch APIs, Android bytecode Java 11  
**Primary Dependencies**: AndroidX Media3 1.10.0 `PlayerView`, AppCompat 1.7.0, Android framework `GestureDetector`/`ScaleGestureDetector`, ViewBinding, AndroidX Test/ActivityScenario  
**Storage**: N/A; feature chỉ xử lý runtime touch state và phát callback intent  
**Testing**: JUnit4 host-side cho gesture math/callback sequencing, instrumentation tests trong `CxPlayer/app/src/androidTest` cho `PlayerActivity` + `PlayerView` integration  
**Target Platform**: Ứng dụng Android điện thoại, minSdk 24, target/compile SDK 36, chế độ cảm ứng portrait và landscape  
**Project Type**: Android mobile app một module, màn hình player dùng XML `PlayerView` + `AppCompatActivity`  
**Performance Goals**: Gesture parsing phải phản hồi đủ tức thời để người dùng không cảm nhận trễ khi điều chỉnh playback trên màn hình 60Hz; không được tạo outcome mâu thuẫn trong cùng một gesture session  
**Constraints**: Giữ `PlayerView` làm video surface chính với `app:use_controller="false"`; không thêm overlay UI ở task 2.1; không nhúng side effect hệ thống trực tiếp vào `GestureController`; không mở rộng sang speed selector/aspect ratio/repeat mode  
**Scale/Scope**: Một class `GestureController`, một điểm tích hợp trong `PlayerActivity`, callback wiring cho 7 loại intent gesture, test unit + instrumentation cho một màn hình player hiện có

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` vẫn đang là template placeholder nên chưa có gate mang tính hiến pháp thực thụ để suy diễn tự động. Vì vậy feature này dùng các rule thực tế của repo làm gate tạm thời:

- **Gate 1 - Scope containment**: PASS. Planning chỉ bao phủ `GestureController`, wiring tại `PlayerActivity`, và test cho touch integration của player.
- **Gate 2 - Simplicity first**: PASS. Giữ nguyên kiến trúc một module, không thêm service/module mới, không chuyển sang Compose, không đưa overlay UI vào cùng feature.
- **Gate 3 - Existing stack reuse**: PASS. Tái sử dụng `PlayerView`, `PlayerActivity`, `CxPlayerManager`, ActivityScenario và hạ tầng instrumentation hiện có.
- **Gate 4 - Validation before completion**: PASS. Pha design đã xác định rõ cả unit test cho threshold math lẫn instrumentation test cho dispatch touch và session safety.

**Post-design re-check**: PASS. `research.md`, `data-model.md`, `quickstart.md` và contract không để lại `NEEDS CLARIFICATION`, không phát sinh complexity cần justification, và vẫn giữ feature trong biên của task 2.1.

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
    ├── src/main/java/com/cxplayer/ui/player/
    │   ├── PlayerActivity.kt
    │   └── GestureController.kt
    ├── src/main/res/layout/
    │   └── activity_player.xml
    ├── src/androidTest/java/com/cxplayer/ui/player/
    │   └── PlayerActivityPlaybackTest.kt
    └── src/test/java/com/cxplayer/ui/player/
        ├── PlayerActivityLaunchParserTest.kt
        └── GestureControllerTest.kt
```

**Structure Decision**: Giữ feature hoàn toàn trong `CxPlayer/app`, thêm `GestureController.kt` dưới `ui/player` để bám đúng package của màn hình player hiện hữu. `PlayerActivity.kt` là điểm tích hợp duy nhất với playback actions và side effect hệ thống; test được chia thành host-side cho logic gesture thuần và instrumentation cho touch dispatch trên `PlayerView`.

## Complexity Tracking

Không có vi phạm gate nào cần justification ở pha planning này.
