# Tasks: Player Launch Entry

**Input**: Design documents from `/specs/001-player-activity/`  
**Prerequisites**: `plan.md`, `spec.md`; optional but available: `research.md`, `data-model.md`, `contracts/player-launch-intent.md`, `quickstart.md`

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì khác file và không phụ thuộc task chưa xong
- **[Story]**: Gắn task với user story cụ thể (`US1`, `US2`, `US3`)
- Mọi task đều ghi rõ file path đích để có thể thực thi ngay

## Path Conventions

- Android app chính: `CxPlayer/app/src/main/`
- Kotlin sources: `CxPlayer/app/src/main/java/com/cxplayer/`
- Android resources: `CxPlayer/app/src/main/res/`
- Unit tests: `CxPlayer/app/src/test/java/com/cxplayer/`
- Instrumentation tests: `CxPlayer/app/src/androidTest/java/com/cxplayer/`

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị các file đích và khung package cho player entry task

- [X] T001 Tạo package `ui/player` và xác nhận các file đích cho feature trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/`
- [X] T002 [P] Chuẩn bị resource skeleton cho player entry trong `CxPlayer/app/src/main/res/layout/activity_player.xml`
- [X] T003 [P] Chuẩn bị chuỗi thông báo lỗi launch trong `CxPlayer/app/src/main/res/values/strings.xml`

**Checkpoint**: Có đủ vị trí file để bắt đầu phần foundation và implementation

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Hạ tầng lõi bắt buộc phải xong trước mọi user story

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này hoàn tất

- [X] T004 Cập nhật khai báo `PlayerActivity` và intent-filter video trong `CxPlayer/app/src/main/AndroidManifest.xml`
- [X] T005 [P] Bổ sung fullscreen theme cho player entry trong `CxPlayer/app/src/main/res/values/themes.xml`
- [X] T006 Tạo `PlayerActivity` skeleton và wiring `onCreate` cơ bản trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T007 Tạo mô hình chuẩn hóa launch request (`PlaybackRequest`, `MediaSourceRef`, `LaunchOutcome`) trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T008 Tạo logic parse/normalize URI và validate đầu vào chung trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: Foundation sẵn sàng, các user story có thể được triển khai tăng dần trên cùng pipeline launch

## Phase 3: User Story 1 - Open a video from another app (Priority: P1) 🎯 MVP

**Goal**: Người dùng mở video từ app khác hoặc direct video link và vào đúng player screen

**Independent Test**: Gửi `ACTION_VIEW` với `http`, `https`, `content`, hoặc `file` hợp lệ; xác nhận `PlayerActivity` mở đúng source mà không tạo stack player trùng lặp

### Implementation for User Story 1

- [X] T009 [US1] Hoàn thiện xử lý `ACTION_VIEW` external launch trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T010 [US1] Áp dụng `singleTask`/relaunch handling để tránh duplicate player experience trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T011 [US1] Gắn `activity_player.xml` làm content view tối thiểu cho player entry trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T012 [P] [US1] Thêm test parser/normalizer cho URI external trong `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt`
- [X] T013 [US1] Kiểm tra và chỉnh manifest match đúng MIME type/scheme theo contract trong `CxPlayer/app/src/main/AndroidManifest.xml`

**Checkpoint**: US1 hoạt động độc lập như MVP

## Phase 4: User Story 2 - Start from a selected item and position (Priority: P2)

**Goal**: Launch request nhiều source có thể chọn item bắt đầu và vị trí bắt đầu hợp lệ

**Independent Test**: Khởi chạy explicit request có nhiều media source, `startIndex`, `startPositionMs`; xác nhận chọn đúng item và áp dụng đúng offset hoặc fallback hợp lệ

### Implementation for User Story 2

- [X] T014 [US2] Mở rộng parser để nhận explicit extras cho `sources`, `startIndex`, `startPositionMs` trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T015 [US2] Hoàn thiện validation và fallback cho `startIndex`/`startPositionMs` trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T016 [P] [US2] Thêm test cho multi-source selection và start position validation trong `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt`
- [X] T017 [US2] Kết nối kết quả `PlaybackRequest` đã chuẩn hóa vào đường khởi tạo playback đầu tiên trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: US1 và US2 đều dùng được độc lập

## Phase 5: User Story 3 - Receive clear feedback for invalid launch requests (Priority: P3)

**Goal**: Request lỗi hoặc source không truy cập được phải cho phản hồi rõ ràng, không crash, không để player ở trạng thái hỏng

**Independent Test**: Gửi request thiếu source, source sai MIME/scheme, index sai, hoặc source mất quyền truy cập; xác nhận app trả lỗi rõ ràng và đóng flow sạch sẽ

### Implementation for User Story 3

- [X] T018 [US3] Thêm user-facing error handling và finish flow an toàn trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T019 [US3] Hoàn thiện thông báo lỗi launch cho các trường hợp reject/fallback trong `CxPlayer/app/src/main/res/values/strings.xml`
- [X] T020 [P] [US3] Thêm test cho empty sources, invalid index, unsupported scheme, inaccessible source trong `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt`
- [X] T021 [US3] Rà lại contract hành vi reject để khớp implementation trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: Cả 3 user story đều hoàn chỉnh và độc lập

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Hoàn thiện verification, consistency, và tài liệu vận hành

- [X] T022 [P] Rà soát đồng bộ giữa `AndroidManifest.xml`, `themes.xml`, `strings.xml`, và `PlayerActivity.kt` trong `CxPlayer/app/src/main/`
- [X] T023 Chạy và sửa các lỗi build/unit test liên quan feature bằng `CxPlayer/gradlew.bat` từ module `CxPlayer/`
- [ ] T024 Xác minh quickstart scenarios và cập nhật ghi chú nếu implementation khác thiết kế trong `specs/001-player-activity/quickstart.md`

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1**: Không phụ thuộc, bắt đầu ngay
- **Phase 2**: Phụ thuộc Phase 1, chặn toàn bộ user stories
- **Phase 3 (US1)**: Phụ thuộc Phase 2
- **Phase 4 (US2)**: Phụ thuộc Phase 2; có thể bắt đầu sau foundation nhưng thực tế nên đi sau US1 vì cùng file `PlayerActivity.kt`
- **Phase 5 (US3)**: Phụ thuộc Phase 2; nên đi sau US1/US2 để áp lỗi trên flow đã đủ nhánh
- **Phase 6**: Phụ thuộc các user story mong muốn đã hoàn tất

### User Story Dependencies

- **US1**: MVP độc lập, không phụ thuộc user story khác
- **US2**: Dùng lại pipeline parse/validate từ foundation và chồng thêm explicit multi-source behavior
- **US3**: Dùng lại toàn bộ pipeline từ US1/US2 để hoàn thiện error outcomes

### Within Each User Story

- Test task có thể chạy sau khi logic nền tương ứng được tạo
- Task cùng một file `PlayerActivity.kt` không nên chạy song song
- Task resource file (`strings.xml`, `themes.xml`, `layout`) có thể chạy song song với task logic nếu không phụ thuộc nội dung cuối

### Parallel Opportunities

- `T002` và `T003` có thể chạy song song
- `T005` có thể chạy song song với `T006` sau khi `T004` đã rõ manifest direction
- `T012`, `T016`, `T020` là các task test riêng file, phù hợp chạy song song với task resource hoặc review
- `T022` có thể chạy song song với chuẩn bị lệnh verification của `T023`

## Parallel Example: User Story 1

```text
Task: "T011 [US1] Gắn activity_player.xml làm content view tối thiểu trong CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt"
Task: "T012 [P] [US1] Thêm test parser/normalizer cho URI external trong CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt"
```

## Parallel Example: User Story 2

```text
Task: "T015 [US2] Hoàn thiện validation và fallback cho startIndex/startPositionMs trong CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt"
Task: "T016 [P] [US2] Thêm test cho multi-source selection và start position validation trong CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt"
```

## Parallel Example: User Story 3

```text
Task: "T019 [US3] Hoàn thiện thông báo lỗi launch trong CxPlayer/app/src/main/res/values/strings.xml"
Task: "T020 [P] [US3] Thêm test reject/failure scenarios trong CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt"
```

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Thực hiện US1 (`T009` → `T013`)
3. Verify bằng quickstart HTTP/file launch trước khi mở rộng

### Incremental Delivery

1. Ship MVP với external launch hợp lệ
2. Thêm explicit multi-source + start position cho US2
3. Hoàn thiện reject/failure handling cho US3

### Parallel Team Strategy

1. Một người chốt foundation trong `PlayerActivity.kt` và manifest
2. Người khác có thể chuẩn bị resource/test files song song
3. Sau foundation, test/resource review có thể tách riêng, nhưng các thay đổi logic trong `PlayerActivity.kt` nên tuần tự để tránh conflict

## Notes

- Tổng task: 24
- US1: 5 task
- US2: 4 task
- US3: 4 task
- Setup + Foundation + Polish: 11 task
- MVP đề xuất: hoàn thành qua US1
- Tất cả task đều theo đúng format checklist bắt buộc: checkbox + Task ID + marker tùy chọn + story label khi cần + file path rõ ràng
