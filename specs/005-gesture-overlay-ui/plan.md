# Implementation Plan: Gesture Overlay UI

**Branch**: `[006-gesture-overlay-ui]` | **Date**: 2026-04-30 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/005-gesture-overlay-ui/spec.md`

## Summary

Thêm một lớp overlay phản hồi cử chỉ trực tiếp trên màn hình phát để hiển thị trạng thái âm lượng, độ sáng, seek delta và fast-forward 2x trong lúc gesture đang diễn ra. Thiết kế giữ nguyên `GestureController` là nguồn phát callback gesture hiện có; `PlayerActivity` sẽ chịu trách nhiệm suy ra dữ liệu hiển thị cuối cùng, điều phối vòng đời xuất hiện hoặc tự ẩn, và bind overlay vào `activity_player.xml` mà không phá chrome hiện tại hoặc playback session.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Android XML layouts, Android bytecode Java 11  
**Primary Dependencies**: Android framework views and drawables, AppCompat 1.7.0, AndroidX Core KTX, Media3 `PlayerView`, ViewBinding  
**Storage**: N/A; chỉ có runtime UI state cho overlay gesture  
**Testing**: JUnit4 host-side cho formatter hoặc overlay-state mapping; AndroidX instrumentation cho hiển thị overlay trong `PlayerActivityPlaybackTest`; manual verification trên thiết bị cảm ứng  
**Target Platform**: Ứng dụng Android điện thoại, minSdk 24, target/compile SDK 36  
**Project Type**: Android mobile app một module  
**Performance Goals**: Overlay xuất hiện trong vòng 0,2 giây sau khi gesture được nhận diện, cập nhật mượt theo gesture đang hoạt động, và tự ẩn trong vòng 1 giây sau khi gesture kết thúc  
**Constraints**: Giữ `PlayerView` là video surface chính với `app:use_controller="false"`; không thêm dependency UI mới; overlay không được chặn thao tác gesture tiếp theo; phạm vi chỉ bao gồm volume, brightness, seek delta và fast-forward 2x  
**Scale/Scope**: Một màn hình `PlayerActivity`, một layout XML, một dòng state overlay runtime, một lớp contract UI, và regression test cho feedback overlay của 4 loại gesture

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` hiện vẫn là template placeholder, nên gate thực tế được suy ra từ repo rules và spec hiện hành.

- **Gate 1 - Scope containment**: PASS. Planning chỉ bao phủ gesture overlay UI của task 2.8; speed selector, aspect ratio, repeat mode, double-tap feedback riêng và pinch overlay đều nằm ngoài scope.
- **Gate 2 - Simplicity first**: PASS. Giữ overlay trong `PlayerActivity` và `activity_player.xml`, tránh tạo module UI mới hoặc state management framework riêng.
- **Gate 3 - Existing stack reuse**: PASS. Tái sử dụng `PlayerView`, `ViewBinding`, resource XML và callback gesture đang có; không thay đổi media stack hay thêm thư viện third-party.
- **Gate 4 - Validation before completion**: PASS. Plan chốt rõ host-side mapping tests cho nội dung overlay và instrumentation/manual verification cho hiển thị thật trên `PlayerActivity`.

**Post-design re-check**: PASS. `research.md`, `data-model.md`, `quickstart.md` và contract đều giữ cùng quyết định: overlay được điều phối từ `PlayerActivity`, có vòng đời tự ẩn ngắn, và không mở rộng phạm vi sang feature Phase 2 khác.

## Project Structure

### Documentation (this feature)

```text
specs/005-gesture-overlay-ui/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── gesture-overlay-ui-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
└── app/
    ├── src/main/java/com/cxplayer/ui/player/
    │   ├── GestureController.kt
    │   └── PlayerActivity.kt
    ├── src/main/res/layout/
    │   └── activity_player.xml
    ├── src/main/res/drawable/
    │   └── bg_player_gesture_overlay.xml
    ├── src/main/res/values/
    │   ├── strings.xml
    │   └── dimens.xml
    ├── src/test/java/com/cxplayer/ui/player/
    │   └── PlayerActivityGestureOverlayTest.kt
    └── src/androidTest/java/com/cxplayer/ui/player/
        └── PlayerActivityPlaybackTest.kt
```

**Structure Decision**: Giữ feature hoàn toàn trong `CxPlayer/app` và bám vào màn hình phát hiện có. `PlayerActivity.kt` sẽ sở hữu runtime overlay state và lifecycle tự ẩn; `activity_player.xml` thêm layer hiển thị nổi phía trên `PlayerView` nhưng dưới các thành phần chrome theo chiến lược layout đã nghiên cứu; tests tiếp tục đi vào hai hướng: host-side cho mapping dữ liệu hiển thị và instrumentation cho visibility/lifecycle của overlay trên activity thật.

## Complexity Tracking

Không có vi phạm gate nào cần justification ở pha planning này.
