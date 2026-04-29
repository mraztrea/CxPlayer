# Tasks: Playback Session Manager

**Input**: Design documents from `/specs/002-cxplayer-manager/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/player-launch-contract.md, quickstart.md

**Tests**: Bao gồm task test vì plan.md và quickstart.md yêu cầu unit test cho normalization/lifecycle logic và instrumentation smoke test cho wiring `PlayerActivity`.

**Organization**: Tasks được nhóm theo user story để mỗi story có thể triển khai và kiểm thử độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì khác file và không phụ thuộc task chưa hoàn thành
- **[Story]**: Ánh xạ tới user story tương ứng trong spec (`US1`, `US2`, `US3`)
- Mỗi task đều ghi rõ file path cần chạm tới

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị các bề mặt file cần cho manager, unit test và instrumentation smoke test

- [ ] T001 Create `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt` as the feature entry point for player ownership and lifecycle management
- [ ] T002 [P] Create `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt` for host-side manager behavior coverage
- [ ] T003 [P] Create `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt` for device/emulator smoke coverage

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Thiết lập contract và ownership cơ sở mà mọi user story đều phụ thuộc vào

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này xong

- [ ] T004 Implement the base manager API, playback snapshot model, and single-session ownership rules in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [ ] T005 [P] Extend clamp/reset and rejected-empty normalization coverage in `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt`
- [ ] T006 Replace direct `ExoPlayer` field ownership with a `CxPlayerManager` boundary in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [ ] T007 [P] Add manager construction/release regression coverage in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`

**Checkpoint**: `PlayerActivity` no longer owns `ExoPlayer` directly and the shared manager contract is ready for story work

---

## Phase 3: User Story 1 - Start Playback Reliably (Priority: P1) 🎯 MVP

**Goal**: Người dùng mở nguồn video hợp lệ và player chuẩn bị đúng item, đúng vị trí, tự động phát khi request hợp lệ

**Independent Test**: Cung cấp request hợp lệ với một hoặc nhiều URI, xác nhận `PlayerActivity` giao request đã normalize cho manager và manager chuẩn bị đúng media item với auto-play bật

### Tests for User Story 1

- [ ] T008 [P] [US1] Add accepted-request playlist preparation tests in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- [ ] T009 [P] [US1] Add local/http launch smoke coverage in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 1

- [ ] T010 [US1] Implement playlist loading, selected-item start, normalized position start, and auto-play behavior in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [ ] T011 [US1] Refactor accepted launch handling and recoverable launch-error flow in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 1 hoạt động độc lập cho local file và HTTP/HTTPS launch path

---

## Phase 4: User Story 2 - Restore Session After Lifecycle Changes (Priority: P2)

**Goal**: Người dùng quay lại sau recreate/background transition và phiên phát được restore đúng item, vị trí, và `playWhenReady`

**Independent Test**: Phát một video, tạo recreate hoặc background/foreground transition, rồi xác nhận item đang xem, vị trí phát và trạng thái phát được restore theo snapshot đã lưu

### Tests for User Story 2

- [ ] T012 [P] [US2] Add snapshot export/restore coverage in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- [ ] T013 [P] [US2] Add recreate and foreground-return smoke coverage in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 2

- [ ] T014 [US2] Implement snapshot capture, snapshot restore, and `playWhenReady` persistence in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [ ] T015 [US2] Implement `savedInstanceState` handoff and API-level symmetric init/release callbacks in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 2 hoạt động độc lập và restore drift nằm trong ngưỡng spec

---

## Phase 5: User Story 3 - Use Core Transport Controls Consistently (Priority: P3)

**Goal**: Manager hỗ trợ play/pause/seekTo/seek ±10 giây nhất quán để `PlayerActivity` và các control phase sau có thể dùng lại

**Independent Test**: Từ một phiên phát đang hoạt động, gọi play/pause/seek API qua manager và xác nhận vị trí phát cùng trạng thái player thay đổi đúng kỳ vọng mà không tạo session thứ hai

### Tests for User Story 3

- [ ] T016 [P] [US3] Add transport control coverage for play, pause, seekTo, seekForward, and seekBack in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- [ ] T017 [P] [US3] Add no-crash transport command smoke coverage in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 3

- [ ] T018 [US3] Implement play, pause, seekTo, seekForward, seekBack, and state accessor APIs in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [ ] T019 [US3] Route transport operations through `CxPlayerManager` and keep `PlayerView` state synchronized in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 3 hoạt động độc lập và manager đã sẵn sàng cho control UI ở các phase tiếp theo

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Dọn dẹp, xác nhận chéo, và khóa chất lượng trước khi chuyển sang task kế tiếp

- [ ] T020 Clean up obsolete direct-player imports and duplicate ownership code in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` and `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [ ] T021 Run host-side regression validation with `CxPlayer/gradlew.bat` using `testDebugUnitTest`
- [ ] T022 Run instrumentation smoke validation with `CxPlayer/gradlew.bat` using `connectedDebugAndroidTest`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: Không phụ thuộc task nào khác
- **Phase 2 (Foundational)**: Phụ thuộc Phase 1 và chặn toàn bộ user story
- **Phase 3 (US1)**: Phụ thuộc Phase 2, là MVP khuyến nghị
- **Phase 4 (US2)**: Phụ thuộc Phase 2 và tận dụng manager API từ US1 nếu đã có
- **Phase 5 (US3)**: Phụ thuộc Phase 2 và manager playback flow đã ổn định
- **Phase 6 (Polish)**: Phụ thuộc mọi story muốn giao xong

### User Story Dependencies

- **US1 (P1)**: Có thể bắt đầu ngay sau Phase 2; không phụ thuộc US2 hay US3
- **US2 (P2)**: Có thể bắt đầu sau Phase 2, nhưng thực tế nên đi sau US1 vì reuse startup/session API từ cùng manager
- **US3 (P3)**: Có thể bắt đầu sau Phase 2, nhưng an toàn nhất khi manager startup path của US1 đã ổn định

### Within Each User Story

- Các task test trong story nên được viết trước và fail trước khi triển khai task implementation tương ứng
- `CxPlayerManager.kt` phải đi trước task wiring tương ứng trong `PlayerActivity.kt`
- Mỗi story chỉ được coi là xong khi independent test của story đó pass độc lập

### Parallel Opportunities

- T002 và T003 có thể chạy song song sau T001
- T005 và T007 có thể chạy song song trong Phase 2
- Trong US1: T008 và T009 có thể chạy song song
- Trong US2: T012 và T013 có thể chạy song song
- Trong US3: T016 và T017 có thể chạy song song

---

## Parallel Example: User Story 1

```text
T008 [US1] Add accepted-request playlist preparation tests in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
T009 [US1] Add local/http launch smoke coverage in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 2

```text
T012 [US2] Add snapshot export/restore coverage in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
T013 [US2] Add recreate and foreground-return smoke coverage in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 3

```text
T016 [US3] Add transport control coverage for play, pause, seekTo, seekForward, and seekBack in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
T017 [US3] Add no-crash transport command smoke coverage in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Hoàn thành US1 (T008-T011)
3. Chạy T021 để xác nhận host-side regression
4. Demo launch path cục bộ và HTTP trước khi mở rộng restore/transport

### Incremental Delivery

1. Setup + Foundational → manager ownership boundary sẵn sàng
2. US1 → playback startup ổn định
3. US2 → lifecycle restore ổn định
4. US3 → transport API ổn định cho control phase sau
5. Polish → chạy regression và dọn code

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, và toàn bộ US1
- **Next**: US2 để khóa lifecycle behavior trước khi mở rộng UI controls
- **Last**: US3 vì phụ thuộc vào manager startup path đã ổn định

---

## Notes

- Tổng số task: 22
- Task theo user story: US1 = 4, US2 = 4, US3 = 4
- Setup/Foundation/Polish: 10 task
- Tất cả task đều dùng checklist format `- [ ] Txxx ...` với file path rõ ràng