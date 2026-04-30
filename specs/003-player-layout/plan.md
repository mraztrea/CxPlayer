# Implementation Plan: Playback Screen Layout

**Branch**: `[003-player-layout]` | **Date**: 2026-04-30 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/003-player-layout/spec.md`

## Summary

Thay layout `activity_player.xml` từ một `PlayerView` trần thành màn hình fullscreen có chrome tùy biến gồm thanh trên, vùng timeline và hàng điều khiển chính, đồng thời giữ `PlayerView` làm mặt render video duy nhất và tiếp tục tắt controller mặc định của Media3. Kế hoạch bám vào XML/View system hiện có của `PlayerActivity`, áp dụng insets cho các lớp overlay thay vì cho vùng video, và thiết lập sẵn contract view-id để các task 1.5-1.6 có thể nối hành vi điều khiển mà không phải sắp lại bố cục.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Android XML layouts, Android bytecode Java 11  
**Primary Dependencies**: AndroidX Media3 1.10.0, AppCompat 1.7.0, Material 1.12.0, ViewBinding, AndroidX Test/Espresso  
**Storage**: N/A cho feature layout; chỉ tiêu thụ playback state đang có trong bộ nhớ tiến trình  
**Testing**: JUnit4 host-side cho parser/wiring hiện có và instrumentation test trong `CxPlayer/app/src/androidTest` cho layout + playback smoke path  
**Target Platform**: Ứng dụng Android điện thoại, minSdk 24, target/compile SDK 36, hỗ trợ portrait và landscape  
**Project Type**: Android mobile app một module, màn hình player dùng XML `PlayerView` + `AppCompatActivity`  
**Performance Goals**: First render của màn hình player phải giữ đầy đủ vùng video và mọi control region trong viewport; đổi orientation không làm control bị cắt, chồng lấn hoặc rơi xuống dưới system bars  
**Constraints**: Giữ `PlayerView` làm surface fullscreen duy nhất; tiếp tục `app:use_controller="false"`; không chuyển màn hình này sang Compose; không mở rộng scope sang logic hoàn chỉnh của task 1.5-1.6; layout phải tương thích theme fullscreen hiện tại  
**Scale/Scope**: Một activity, một layout XML, một top bar, một timeline row, một transport row với 5 hành động chính, một contract UI cho automation và triển khai tiếp theo

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` vẫn còn ở trạng thái template placeholder nên không tạo được gate chính thức từ văn bản đó. Để tránh planning mơ hồ, feature này dùng các rule thực tế của repo làm gate tạm thời:

- **Gate 1 - Scope containment**: PASS. Thay đổi tập trung vào `PlayerActivity`, `activity_player.xml`, resource hỗ trợ và test UI của player.
- **Gate 2 - Simplicity first**: PASS. Giữ nguyên stack XML/View system hiện hữu, không thêm module, không đổi sang Compose, không thêm service hoặc persistence.
- **Gate 3 - Existing stack reuse**: PASS. Tái sử dụng `PlayerView`, AppCompat/Material, fullscreen theme và instrumentation setup hiện có.
- **Gate 4 - Validation before completion**: PASS. Có thể xác nhận bằng host-side tests hiện có cộng với instrumentation assertions cho region visibility, orientation reflow và launch smoke path.

**Post-design re-check**: PASS. Research và design Phase 0/1 giữ feature trong một màn hình, không phát sinh unknown chưa giải quyết và không tạo complexity cần justification.

## Project Structure

### Documentation (this feature)

```text
specs/003-player-layout/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── player-screen-layout-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
└── app/
    ├── src/main/
    │   ├── AndroidManifest.xml
    │   ├── java/com/cxplayer/ui/player/
    │   │   └── PlayerActivity.kt
    │   └── res/
    │       ├── layout/activity_player.xml
    │       ├── values/strings.xml
    │       ├── values/themes.xml
    │       └── drawable/
    ├── src/androidTest/java/com/cxplayer/ui/player/
    │   └── PlayerActivityPlaybackTest.kt
    └── src/test/java/com/cxplayer/ui/player/
        └── PlayerActivityLaunchParserTest.kt
```

**Structure Decision**: Giữ feature hoàn toàn trong `CxPlayer/app` và mở rộng màn hình player hiện tại thay vì tách module mới. `activity_player.xml` sẽ trở thành nơi định nghĩa contract bố cục, `PlayerActivity.kt` xử lý bind cho top/bottom chrome và insets, còn resource `strings`/`drawable` chứa nhãn cùng icon phục vụ khả năng sử dụng và test automation.

## Complexity Tracking

Không có vi phạm gate nào cần justification ở pha planning này.
