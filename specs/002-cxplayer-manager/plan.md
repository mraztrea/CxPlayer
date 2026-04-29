# Implementation Plan: Playback Session Manager

**Branch**: `[002-cxplayer-manager]` | **Date**: 2026-04-29 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/002-cxplayer-manager/spec.md`

## Summary

Tách quyền sở hữu phiên phát khỏi `PlayerActivity` bằng một `CxPlayerManager` chuyên trách để quản lý vòng đời `ExoPlayer`, gắn `PlayerView`, thiết lập playlist đã được chuẩn hóa và tạo snapshot trạng thái đủ cho restore sau vòng đời. Kế hoạch giữ toàn bộ thay đổi bên trong `CxPlayer/app`, tái sử dụng parser hiện có cho launch contract, và mở rộng test surface hiện hữu bằng unit test cho normalize/lifecycle logic cùng một smoke test trên thiết bị cho wiring Activity.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Android bytecode Java 11  
**Primary Dependencies**: AndroidX Media3 1.10.0, AppCompat 1.7.0, Material 1.12.0, Lifecycle ViewModel KTX 2.8.7, Hilt 2.59.2, JUnit4, AndroidX Test/Espresso  
**Storage**: Bộ nhớ trong tiến trình và `savedInstanceState` cho playback snapshot; không có database hoặc file persistence trong scope  
**Testing**: JUnit4 host-side trong `CxPlayer/app/src/test` và instrumentation smoke test trong `CxPlayer/app/src/androidTest`  
**Target Platform**: Ứng dụng Android điện thoại/máy tính bảng, minSdk 24, target/compile SDK 36  
**Project Type**: Android mobile app một module với XML `PlayerView` và Compose launcher hiện có  
**Performance Goals**: Đáp ứng spec: local ready <= 3 giây trong 95% trường hợp, network ready <= 5 giây trong 95% trường hợp, restore drift <= 1 giây trong 95% trường hợp  
**Constraints**: Chỉ một foreground playback session cho mỗi `PlayerActivity`; không mở rộng sang background service hoặc `MediaSession`; giữ nguyên stack Media3/XML hiện tại; `startIndex` ngoài phạm vi phải clamp về phần tử hợp lệ gần nhất và `startPosition` không hợp lệ phải reset về `0` khi vẫn còn nguồn phát hợp lệ  
**Scale/Scope**: Một màn hình player, một manager abstraction, một playlist cho mỗi activity instance, nguồn phát giới hạn ở `http`, `https`, `content`, `file` và các định dạng video Phase 1

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` hiện vẫn là template placeholder nên không có gate dự án nào đủ cụ thể để fail theo văn bản này. Để tránh planning mơ hồ, kế hoạch dùng các rule thực tế của repo làm gate tạm thời:

- **Gate 1 - Scope containment**: PASS. Tất cả thay đổi nằm trong `CxPlayer/app` và luồng player hiện có.
- **Gate 2 - Simplicity first**: PASS. Chỉ thêm một abstraction mới là `CxPlayerManager`; không thêm module, repository, background service hay persistence layer.
- **Gate 3 - Existing stack reuse**: PASS. Kế hoạch bám theo Kotlin + Media3 + AndroidX test toolchain hiện có; không thêm dependency mới.
- **Gate 4 - Validation before completion**: PASS. Có đường kiểm thử host-side cho normalization/lifecycle logic và một device-side smoke test cho wiring Activity.

**Post-design re-check**: PASS. Các artifact Phase 0 và Phase 1 vẫn giữ kiến trúc một module, không phát sinh unknown mới và không tạo vi phạm cần justification.

## Project Structure

### Documentation (this feature)

```text
specs/002-cxplayer-manager/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── player-launch-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
└── app/
    ├── src/main/
    │   ├── AndroidManifest.xml
    │   ├── java/com/cxplayer/
    │   │   ├── MainActivity.kt
    │   │   ├── player/
    │   │   │   └── CxPlayerManager.kt
    │   │   └── ui/player/
    │   │       └── PlayerActivity.kt
    │   └── res/layout/activity_player.xml
    ├── src/test/java/com/cxplayer/
    │   ├── player/
    │   │   └── CxPlayerManagerTest.kt
    │   └── ui/player/
    │       └── PlayerActivityLaunchParserTest.kt
    └── src/androidTest/java/com/cxplayer/ui/player/
        └── PlayerActivityPlaybackTest.kt
```

**Structure Decision**: Giữ feature trong Android app module hiện hữu thay vì tạo module mới. `PlayerActivity` tiếp tục là ranh giới intent/UI, còn `CxPlayerManager` sở hữu `ExoPlayer`, attach/detach `PlayerView`, cấu hình seek increments, thiết lập playlist đã normalize, xuất snapshot và release tài nguyên. Parser launch hiện tại giữ trong `ui/player` trừ khi việc tách riêng là cần thiết để đơn giản hóa test của manager.

## Complexity Tracking

Không có vi phạm constitution/gate nào cần justification ở pha planning này.
