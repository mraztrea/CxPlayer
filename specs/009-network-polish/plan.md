# Implementation Plan: Network Polish

**Branch**: `[010-network-polish]` | **Date**: 2026-05-01 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/009-network-polish/spec.md`

## Summary

Mở rộng playback stack hiện có để xử lý tốt nguồn mạng nội bộ bằng cách chèn seam phân giải source theo URI, dùng HTTP datasource tối ưu cho LAN, thêm SMB browse + stream path, và tách ownership của player sang service-backed session để PiP và background audio hoạt động thực sự. `PlayerActivity` tiếp tục là playback shell hiện có, nhưng lifecycle của player không còn gắn cứng với `onStop`; thay vào đó activity điều khiển UI, PiP, orientation và flow browse/play, còn `CxPlayerManager` cùng media session layer giữ continuity của phiên phát.

## Technical Context

**Language/Version**: Kotlin 2.2.10, Gradle Kotlin DSL, Android bytecode Java 11  
**Primary Dependencies**: AndroidX Media3 1.10.0 (`media3-exoplayer`, `media3-common`, `media3-ui`, `media3-datasource`, `media3-session`), `media3-datasource-okhttp`, OkHttp 4.12.0, SMBJ 0.13.0, AppCompat 1.7.0, Material 1.12.0  
**Storage**: Không thêm database; state phiên phát, credential SMB và orientation lock được giữ ở runtime/session scope, không persist dài hạn trong phase này  
**Testing**: JUnit4 host-side cho source routing, wake/buffer policy, parser và SMB seams; Android instrumentation cho `PlayerActivityPlaybackTest`; compile sanity qua `compileDebugKotlin` và `compileDebugAndroidTestKotlin`  
**Target Platform**: Ứng dụng Android điện thoại/tablet, minSdk 24, target/compile SDK 36  
**Project Type**: Android mobile app một module ứng dụng chính với một module ffmpeg extension  
**Performance Goals**: HTTP/LAN playback bắt đầu trong vòng 5 giây ở phần lớn mẫu hợp lệ; video LAN ổn định không vượt quá một stall do app xử lý trong 10 phút; audio nền duy trì ít nhất 15 phút nếu user chưa dừng; PiP/orientation không làm mất snapshot phát  
**Constraints**: Phải giữ local/content/http launch flow hiện có; manifest hiện chỉ nhận `http/https/content/file`, nên SMB được mở theo flow nội bộ chứ không thêm implicit VIEW mới; `PlayerActivity` hiện release player ở `onStop`, nên background audio yêu cầu service-backed session thay vì patch hời hợt; phase này không lưu password SMB vĩnh viễn  
**Scale/Scope**: Một feature doc set, một app module bị chạm chính, thêm một ít class playback/network mới, chỉnh manifest + activity hiện có và mở rộng test surface hiện tại thay vì tạo navigation stack mới

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

`.specify/memory/constitution.md` vẫn là placeholder template, nên gate được suy ra từ quy tắc repo trong `AGENTS.md`, spec mới và playback seams đang có.

- **Gate 1 - Scope containment**: PASS. Plan chỉ bao phủ LAN/SMB playback, PiP, background audio và orientation lock. Không kéo thêm playlist, subtitle styling, thư viện media đầy đủ hoặc lưu credential lâu dài.
- **Gate 2 - Simplicity first**: PASS. Thiết kế tận dụng đúng seams Media3 được docs hỗ trợ (`LoadControl`, datasource factory, wake mode, media session service) và tránh dựng playback stack thứ hai.
- **Gate 3 - Existing seam reuse**: PASS. `PlayerActivity`, `CxPlayerManager`, `PlaybackRequestParser` và `SubtitleManager` vẫn là các entry points chính; plan chỉ thêm các collaborator network/service nhỏ để lấp khoảng trống phase 4.
- **Gate 4 - Validation before completion**: PASS. Validation khóa bằng unit tests cho routing/policy/parser, instrumentation smoke cho playback continuity, và manual verification cho LAN/SMB/PiP trên thiết bị thật.

**Post-design re-check**: PASS. `research.md`, `data-model.md`, `quickstart.md` và contract đều giữ cùng một hướng: network playback được chuẩn hóa quanh một media-source seam, SMB chỉ được đưa vào qua flow browse nội bộ, và playback continuity chuyển về service-backed ownership để giải quyết trực tiếp hạn chế lifecycle hiện có.

## Project Structure

### Documentation (this feature)

```text
specs/009-network-polish/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── network-playback-contract.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
└── app/
    ├── src/main/java/com/cxplayer/player/
    │   ├── CxPlayerManager.kt
    │   ├── CxLoadControl.kt
    │   ├── CxMediaSourceFactory.kt
    │   ├── PlaybackService.kt
    │   └── SubtitleManager.kt
    ├── src/main/java/com/cxplayer/data/datasource/
    │   ├── CxDataSourceFactory.kt
    │   └── SmbDataSource.kt
    ├── src/main/java/com/cxplayer/network/
    │   └── SmbBrowser.kt
    ├── src/main/java/com/cxplayer/ui/controls/
    │   └── NetworkBrowserDialog.kt
    ├── src/main/java/com/cxplayer/ui/player/
    │   └── PlayerActivity.kt
    ├── src/main/AndroidManifest.xml
    ├── src/test/java/com/cxplayer/player/
    │   ├── CxPlayerManagerTest.kt
    │   ├── PlaybackRequestParserTest.kt
    │   └── SmbBrowserContractTest.kt
    └── src/androidTest/java/com/cxplayer/ui/player/
        └── PlayerActivityPlaybackTest.kt
```

**Structure Decision**: Giữ toàn bộ thay đổi trong `CxPlayer/app`. `player/` tiếp tục là nơi owner của playback/session policy; `data/datasource/` tách riêng HTTP/SMB stream concerns để không làm `CxPlayerManager` phình to; `network/` chứa browse/authentication logic cho SMB; `ui/player/PlayerActivity.kt` vẫn là playback shell và entry point của intent parsing, PiP và orientation. Không tạo package `domain/` mới vì repo hiện chưa dùng pattern đó và phase này chủ yếu cần seams runtime gần player hơn là model nghiệp vụ chia sẻ rộng.

## Complexity Tracking

Không có vi phạm gate nào cần justification ở pha planning này.
