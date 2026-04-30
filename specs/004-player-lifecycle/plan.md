# Implementation Plan: Player Lifecycle Management

**Branch**: `[004-player-lifecycle]` | **Date**: 2026-04-30 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/004-player-lifecycle/spec.md`

## Summary

Hoàn thiện vòng đời player hiện có bằng cách giữ `PlayerActivity` là owner duy nhất của phiên phát, dùng `PlaybackSnapshot` cộng `savedInstanceState` làm handoff trạng thái nhẹ giữa recreate và foreground/background ngắn hạn, và chuẩn hoá contract attach/load/release giữa `PlayerActivity` với `CxPlayerManager`. Kế hoạch giữ nguyên stack XML/ViewBinding + Media3 hiện tại, không thêm background playback service, không thêm persistence dài hạn và tập trung vào validation bằng unit test của manager cùng instrumentation test của activity lifecycle.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Android XML/ViewBinding, Java 11 bytecode  
**Primary Dependencies**: AndroidX Media3 1.10.0, AppCompat 1.7.0, Material 1.12.0, AndroidX Test/Espresso, JUnit4  
**Storage**: `savedInstanceState` Bundle + `PlaybackSnapshot` trong bộ nhớ tiến trình; không dùng database hoặc file persistence cho feature này  
**Testing**: JUnit4 host-side trong `CxPlayer/app/src/test`, instrumentation `ActivityScenario` trong `CxPlayer/app/src/androidTest`  
**Target Platform**: Ứng dụng Android điện thoại, minSdk 24, target/compile SDK 36, nguồn phát local + HTTP/HTTPS/content/file của Phase 1  
**Project Type**: Android mobile app một module, màn hình player dùng `AppCompatActivity` + `PlayerView` XML  
**Performance Goals**: Khôi phục đúng media item hiện tại với sai số vị trí không quá 1 giây sau recreate/foreground return; dừng hoàn toàn audio trong vòng 1 giây khi kết thúc phiên xem  
**Constraints**: Giữ `singleTask` và intent contract hiện có; không mở rộng sang background playback service, Picture-in-Picture hoặc media notification; lifecycle boundary chính bám `onStart`/`onStop` vì minSdk 24; phải tương thích với parse logic và chrome layout đang có  
**Scale/Scope**: Một activity player, một manager bọc ExoPlayer, một snapshot model ngắn hạn, một manifest entry và hai cụm test hiện có được mở rộng cho lifecycle assertions

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` vẫn là file template placeholder nên không cung cấp được rule khả thi để tạo gate chính thức. Để không chặn planning, feature này dùng các rule thực tế của repo làm gate tạm thời:

- **Gate 1 - Scope containment**: PASS. Thay đổi được giới hạn trong `PlayerActivity`, `CxPlayerManager`, manifest player nếu thực sự cần và test lifecycle liên quan.
- **Gate 2 - Platform lifecycle alignment**: PASS. MinSdk 24 cho phép dùng `onStart`/`onStop` làm boundary chính cho session mà không cần nhánh API 23 trở xuống.
- **Gate 3 - Single-session discipline**: PASS. Thiết kế tiếp tục giữ một session manager cho một activity instance và dựa trên `singleTask` để tránh activity player trùng lặp.
- **Gate 4 - Validation before completion**: PASS. Có sẵn đường validation hẹp qua `CxPlayerManagerTest`, `PlayerActivityLaunchParserTest` và `PlayerActivityPlaybackTest`, đủ để mở rộng cho recreate, foreground/background và clean release.

**Post-design re-check**: PASS. Research Phase 0 và design Phase 1 không tạo unknown chưa giải quyết, không đòi hỏi service mới, persistence mới hoặc thay đổi kiến trúc vượt phạm vi feature.

## Project Structure

### Documentation (this feature)

```text
specs/004-player-lifecycle/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── player-lifecycle-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
└── app/
    ├── src/main/
    │   ├── AndroidManifest.xml
    │   ├── java/com/cxplayer/player/
    │   │   └── CxPlayerManager.kt
    │   ├── java/com/cxplayer/ui/player/
    │   │   └── PlayerActivity.kt
    │   └── res/layout/
    │       └── activity_player.xml
    ├── src/test/java/com/cxplayer/
    │   ├── player/
    │   │   └── CxPlayerManagerTest.kt
    │   └── ui/player/
    │       └── PlayerActivityLaunchParserTest.kt
    └── src/androidTest/java/com/cxplayer/ui/player/
        └── PlayerActivityPlaybackTest.kt
```

**Structure Decision**: Giữ toàn bộ feature trong `CxPlayer/app` và mở rộng lớp player hiện có thay vì thêm module hoặc service mới. `PlayerActivity.kt` tiếp tục làm nơi điều phối lifecycle và snapshot handoff, `CxPlayerManager.kt` giữ ownership của ExoPlayer session, còn test được tách rõ thành host-side logic checks và instrumentation lifecycle checks.

## Complexity Tracking

Không có vi phạm gate nào cần justification ở pha planning này.
