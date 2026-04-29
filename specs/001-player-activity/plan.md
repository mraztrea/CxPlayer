# Implementation Plan: Player Launch Entry

**Branch**: `[001-player-activity]` | **Date**: 2026-04-29 | **Spec**: [spec.md](./spec.md)  
**Input**: Feature specification from `/specs/001-player-activity/spec.md`

**Note**: Tài liệu này chốt thiết kế cho task `1.2 PlayerActivity + Manifest` trước khi sinh `tasks.md`.

## Summary

Tạo điểm vào phát video riêng bằng `PlayerActivity` để nhận yêu cầu mở video từ app khác hoặc từ flow nội bộ. Phạm vi của plan này chỉ bao gồm manifest intent filter, chuẩn hóa yêu cầu mở video, chọn item bắt đầu, chọn vị trí bắt đầu, và xử lý lỗi đầu vào. Layout player, controls, lifecycle restore, playlist manager và playback wrapper chi tiết vẫn thuộc các task Phase 1 tiếp theo.

## Technical Context

**Language/Version**: Kotlin + Android SDK, Java 11 bytecode target  
**Primary Dependencies**: AndroidX Media3, Hilt + KSP, AppCompat, Material, Lifecycle ViewModel, Compose + ViewBinding  
**Storage**: N/A cho task này; chỉ xử lý dữ liệu launch trong bộ nhớ  
**Testing**: JUnit, Android instrumentation/Compose test nền tảng, cộng với kiểm thử thủ công bằng device/emulator cho `ACTION_VIEW`  
**Target Platform**: Ứng dụng Android, min SDK 24, target SDK 36  
**Project Type**: Single-module mobile app (`CxPlayer/app`)  
**Performance Goals**: Mở player với nguồn hợp lệ trong 3 giây cho local/content/file và 5 giây cho HTTP/HTTPS theo spec  
**Constraints**:
- Phải giữ scope đúng task `1.2`; không kéo controls, lifecycle restore, gesture hoặc playlist logic sang đây
- Phải tương thích manifest implicit intent trên Android 12+ với `android:exported` rõ ràng
- Phải hỗ trợ `http`, `https`, `content`, `file` và các MIME type video đã nêu trong phase plan
- Phải tránh tạo stack player trùng lặp cho cùng một luồng mở video
- Phải dùng KSP, không dùng kapt, để khớp cấu hình project hiện tại
**Scale/Scope**: Một activity mới, một đường xử lý launch chuẩn hóa, cập nhật manifest/theme/chuỗi thông báo trong module `app`

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- File constitution hiện vẫn là placeholder template, chưa có nguyên tắc dự án đã ratify để áp gate riêng.
- Gate thực tế áp dụng từ `AGENTS.md` và chỉ dẫn repo:
  - Giữ thay đổi tối giản, đúng phạm vi `1.2`
  - Dùng PowerShell/Windows command và prefix `rtk`
  - Ưu tiên cấu trúc hiện có của Android app template, không thêm abstraction không cần thiết
  - Tài liệu/response dùng tiếng Việt
- Kết quả trước Phase 0: `PASS`
- Kết quả sau Phase 1 design: `PASS`

## Project Structure

### Documentation (this feature)

```text
specs/001-player-activity/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── player-launch-intent.md
└── tasks.md
```

### Source Code (repository root)

```text
CxPlayer/
└── app/
    ├── src/
    │   ├── main/
    │   │   ├── AndroidManifest.xml                 # sửa để thêm PlayerActivity + ACTION_VIEW filter
    │   │   ├── java/com/cxplayer/
    │   │   │   ├── MainActivity.kt                 # launcher hiện tại, giữ nguyên trừ khi cần điều hướng tối thiểu
    │   │   │   └── ui/player/
    │   │   │       └── PlayerActivity.kt           # mới, nhận intent và chuẩn hóa launch request
    │   │   └── res/
    │   │       ├── values/
    │   │       │   ├── strings.xml                 # thông báo lỗi launch nếu cần
    │   │       │   └── themes.xml                  # bổ sung fullscreen theme cho player
    │   │       └── layout/
    │   │           └── activity_player.xml         # chỉ tạo skeleton nếu task 1.2 cần màn hình tối thiểu
    │   ├── test/java/com/cxplayer/                 # unit tests cho parser/validation nếu được tách nhỏ
    │   └── androidTest/java/com/cxplayer/          # kiểm thử intent launch nếu cần instrumentation
    └── build.gradle.kts
```

**Structure Decision**: Giữ nguyên single-module Android app hiện tại và chỉ mở rộng đúng các path liên quan tới player entry. Không tách thêm module mới trong task này.

## Phase 0: Outline & Research

- Kết quả nghiên cứu được ghi tại [research.md](./research.md).
- Các điểm cần khóa trước khi implement:
  - Giữ `MainActivity` làm launcher hiện tại, thêm `PlayerActivity` làm điểm vào playback riêng
  - Chuẩn hóa tất cả đầu vào implicit/explicit thành một mô hình `PlaybackRequest`
  - Chọn manifest contract đủ hẹp để nhận đúng video, nhưng đủ rộng để hỗ trợ local/file/content/http(s)
  - Chọn hành vi lỗi nhất quán khi request không hợp lệ hoặc không truy cập được nguồn

## Phase 1: Design & Contracts

- Data model được chốt tại [data-model.md](./data-model.md).
- Hợp đồng giao tiếp được chốt tại [contracts/player-launch-intent.md](./contracts/player-launch-intent.md).
- Luồng xác minh thủ công và build được ghi tại [quickstart.md](./quickstart.md).
- Agent context trong `AGENTS.md` đã được cập nhật để trỏ tới plan hiện hành.

## Phase 2: Task Planning Approach

1. Cập nhật `AndroidManifest.xml` để khai báo `PlayerActivity`, `android:exported`, `launchMode`, fullscreen theme, và intent filter cho video sources.
2. Tạo `PlayerActivity` với một lớp xử lý launch gọn trong cùng file hoặc cùng package để:
   - đọc `ACTION_VIEW` và explicit extras
   - chuẩn hóa URI/scheme
   - xác thực danh sách nguồn, `startIndex`, `startPositionMs`
   - chọn fallback an toàn hoặc trả lỗi sớm
3. Bổ sung resource tối thiểu cần cho player entry:
   - fullscreen theme
   - thông báo lỗi launch
   - skeleton layout nếu activity cần content view riêng trước task layout
4. Thêm kiểm thử phù hợp nhất với mức scope:
   - unit test cho parsing/validation nếu có hàm thuần
   - build/instrumentation/manual verification cho manifest launch paths

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | - | - |
