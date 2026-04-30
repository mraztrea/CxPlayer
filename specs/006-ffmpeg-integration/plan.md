# Implementation Plan: FFmpeg Integration

**Branch**: `[007-ffmpeg-integration]` | **Date**: 2026-04-30 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/006-ffmpeg-integration/spec.md`

## Summary

Mở rộng lớp phát Media3 hiện tại để ưu tiên FFmpeg decoder cho các codec âm thanh hoặc media profile mà đường giải mã mặc định không đáp ứng ổn định, đồng thời giữ nguyên API hiện có của `CxPlayerManager` và trải nghiệm mở file cho những media đang phát tốt. Thiết kế tập trung vào ba thay đổi nhỏ: khai báo dependency Media3 FFmpeg trong Gradle, thêm `CxRenderersFactory` dưới `com.cxplayer.player`, và truyền renderers factory đó vào `ExoPlayer.Builder` trong `ExoPlayerSessionFactory`.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Gradle Kotlin DSL, Android bytecode Java 11  
**Primary Dependencies**: AndroidX Media3 1.10.0 (`media3-exoplayer`, `media3-common`, `media3-ui`, `media3-session`, `media3-datasource`, `media3-extractor`) và dependency mới `media3-decoder-ffmpeg`; Android framework audio/media APIs; AppCompat 1.7.0  
**Storage**: N/A; chỉ có runtime playback configuration trong session player  
**Testing**: JUnit4 host-side cho `CxPlayerManagerTest` hoặc test mới quanh session factory/renderers policy; `assembleDebug` hoặc `compileDebugKotlin` để xác nhận wiring Gradle; manual playback verification với sample media AC3, DTS, H.265 và regression sample MP4/MKV đang phát tốt  
**Target Platform**: Ứng dụng Android điện thoại, minSdk 24, target/compile SDK 36  
**Project Type**: Android mobile app một module  
**Performance Goals**: File media hợp lệ thuộc codec mục tiêu bắt đầu phát với hình và tiếng trong vòng 5 giây; không tạo regression rõ rệt cho file MP4/MKV đang phát tốt; không có lệch hình tiếng người dùng nhận thấy trong 10 phút đầu của sample pass  
**Constraints**: Tự động chọn decoder không yêu cầu user setting mới; giữ backward-compatible API của `CxPlayerManager`; không mở rộng sang subtitle, track selection hoặc playlist ở task này; bám version catalog hiện có để tránh lệch phiên bản Media3; không thêm abstraction player mới ngoài một renderers factory nhỏ  
**Scale/Scope**: Một module `CxPlayer/app`, một file build module, một version catalog, một package `com.cxplayer.player`, một unit test slice cho playback wiring, và manual verification trên bộ sample codec mục tiêu

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` hiện vẫn là template placeholder, nên gate thực tế được suy ra từ repo rules trong `AGENTS.md`, spec hiện hành và cấu trúc code hiện có.

- **Gate 1 - Scope containment**: PASS. Plan chỉ bao phủ task 3.1 FFmpeg Integration; `CxRenderersFactory`, subtitle, chọn track audio hoặc playlist được giữ tách bạch, trong đó chỉ `CxRenderersFactory` là phần nối tiếp trực tiếp của task này.
- **Gate 2 - Simplicity first**: PASS. Giải pháp dùng đúng seam sẵn có là `ExoPlayerSessionFactory.create()` trong `CxPlayerManager`, tránh tạo module media mới hoặc cấu hình decoder do người dùng điều khiển.
- **Gate 3 - Existing stack reuse**: PASS. Tái sử dụng Media3 hiện tại, version catalog hiện có và seam test `PlayerSessionFactory`; không thay đổi contract của `PlaybackRequest`, `PlayerActivity` hoặc playback controls.
- **Gate 4 - Validation before completion**: PASS. Plan khóa rõ validation bằng unit tests cho wiring policy, Gradle compile check, và manual playback verification với sample AC3/DTS/H.265 cùng regression sample đang phát tốt.

**Post-design re-check**: PASS. `research.md`, `data-model.md`, `quickstart.md` và contract đều giữ cùng hướng: dependency FFmpeg được thêm theo version catalog, decoder preference được encapsulate trong renderers factory nhỏ, và `CxPlayerManager` vẫn là entry point duy nhất của playback session.

## Project Structure

### Documentation (this feature)

```text
specs/006-ffmpeg-integration/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── ffmpeg-playback-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
├── gradle/
│   └── libs.versions.toml
└── app/
    ├── build.gradle.kts
    ├── src/main/java/com/cxplayer/player/
    │   ├── CxPlayerManager.kt
    │   └── CxRenderersFactory.kt
    ├── src/test/java/com/cxplayer/player/
    │   └── CxPlayerManagerTest.kt
    └── src/androidTest/java/com/cxplayer/ui/player/
        └── PlayerActivityPlaybackTest.kt
```

**Structure Decision**: Giữ toàn bộ thay đổi trong `CxPlayer/app` và package `com.cxplayer.player`, vì đây là nơi `ExoPlayer.Builder` đang được khởi tạo hôm nay. `gradle/libs.versions.toml` và `app/build.gradle.kts` chịu trách nhiệm khai báo dependency FFmpeg; `CxRenderersFactory.kt` cô lập decoder preference; `CxPlayerManager.kt` chỉ đổi ở seam session factory để build player bằng renderers factory mới; validation ưu tiên host-side test tại `src/test` và manual playback verification trên activity hiện có thay vì mở thêm UI flow khác.

## Complexity Tracking

Không có vi phạm gate nào cần justification ở pha planning này.
