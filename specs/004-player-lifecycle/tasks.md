# Tasks: Player Lifecycle Management

**Input**: Design documents from `/specs/004-player-lifecycle/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/player-lifecycle-contract.md, quickstart.md

**Tests**: Bao gồm task test vì `plan.md`, `quickstart.md`, và `contracts/player-lifecycle-contract.md` đã chốt unit test + instrumentation validation cho lifecycle continuity, single-session semantics, restore fallback, và clean release.

**Organization**: Tasks được nhóm theo user story để mỗi story có thể triển khai và kiểm thử độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì khác file và không phụ thuộc task chưa hoàn thành
- **[Story]**: Ánh xạ tới user story tương ứng trong spec (`US1`, `US2`, `US3`)
- Mỗi task đều ghi rõ file path cần chạm tới

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị các bề mặt test và copy dùng chung cho toàn bộ feature lifecycle

- [X] T001 [P] Add lifecycle recovery and restore-failure strings in `CxPlayer/app/src/main/res/values/strings.xml`
- [X] T002 [P] Prepare shared manager lifecycle fixtures for release/reload assertions in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- [X] T003 [P] Prepare shared ActivityScenario helpers for recreate, foreground return, and finish assertions in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Thiết lập boundary request/snapshot/session mà mọi user story đều phụ thuộc vào

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này xong

- [X] T004 Centralize pending request, pending snapshot, and lifecycle transition helpers in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T005 [P] Harden released-state, snapshot precedence, and single-session reload semantics in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [X] T006 [P] Add baseline regression coverage for release/reload consistency and stale snapshot invalidation in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`

**Checkpoint**: `PlayerActivity` và `CxPlayerManager` đã có boundary lifecycle đủ rõ để triển khai từng story mà không chồng session hoặc mất ownership

---

## Phase 3: User Story 1 - Continue Playback After Temporary Interruptions (Priority: P1) 🎯 MVP

**Goal**: Người dùng rời player tạm thời rồi quay lại và tiếp tục đúng nội dung với vị trí và play/pause intent gần như trước khi gián đoạn

**Independent Test**: Mở video local hoặc HTTP, đưa activity ra trạng thái nền ngắn hạn rồi quay lại, sau đó xác nhận cùng media item được khôi phục với snapshot và play/pause intent đúng kỳ vọng

### Tests for User Story 1

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [X] T007 [P] [US1] Add foreground/background continuity assertions for local and HTTP launches in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- [X] T008 [P] [US1] Add unit coverage for snapshot export and same-request resume after temporary release in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`

### Implementation for User Story 1

- [X] T009 [US1] Implement temporary-stop snapshot capture and same-request restore flow in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T010 [US1] Update same-request reload behavior and duplicate-session guards in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`

**Checkpoint**: User Story 1 hoàn chỉnh khi foreground/background ngắn hạn không làm người dùng chọn lại nguồn phát và không tự đổi play/pause intent

---

## Phase 4: User Story 2 - Preserve Watching Context Through Screen Recreation (Priority: P2)

**Goal**: Người dùng recreate activity hoặc xoay màn hình vẫn giữ đúng item hiện tại, vị trí phát, và ngữ cảnh phiên xem đang hoạt động

**Independent Test**: Phát video một item hoặc nhiều item, trigger `scenario.recreate()`, rồi xác nhận current index, current position, và play/pause intent vẫn khớp snapshot đã lưu hoặc fallback đúng request hiện hành

### Tests for User Story 2

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [X] T011 [P] [US2] Add recreate and multi-item current-index persistence assertions in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- [X] T012 [P] [US2] Add unit coverage for snapshot precedence over request defaults and invalid snapshot fallback in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`

### Implementation for User Story 2

- [X] T013 [US2] Implement recreate-safe `savedInstanceState` restore guards and selected-item continuity in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T014 [US2] Surface clear restore-failure fallback for unavailable resumed content in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` and `CxPlayer/app/src/main/res/values/strings.xml`

**Checkpoint**: User Story 2 hoàn chỉnh khi recreate không trả người dùng về item sai, không bỏ mất vị trí phát, và báo lỗi rõ ràng nếu restore không còn hợp lệ

---

## Phase 5: User Story 3 - Exit the Player Cleanly (Priority: P3)

**Goal**: Người dùng đóng player hoặc mở request mới mà không để sót audio, session cũ, hoặc stale snapshot gây khôi phục nhầm

**Independent Test**: Phát video, thoát hẳn khỏi player hoặc mở video khác khi activity đang tồn tại, rồi xác nhận session cũ bị dọn sạch và lần mở sau không kéo theo snapshot stale

### Tests for User Story 3

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [X] T015 [P] [US3] Add clean-exit and reopen-without-stale-session assertions in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- [X] T016 [P] [US3] Add unit coverage for idempotent release and post-exit stale snapshot invalidation in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`

### Implementation for User Story 3

- [X] T017 [US3] Implement final-exit cleanup and `onNewIntent()` stale-snapshot invalidation in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T018 [US3] Keep `release()` idempotent and expose stable released-state snapshots in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`

**Checkpoint**: User Story 3 hoàn chỉnh khi thoát player hoặc thay request không còn audio nền, không còn session trùng, và không hồi sinh snapshot của phiên đã kết thúc

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Dọn code, chạy validation cuối, và khóa regression theo quickstart

- [X] T019 Clean up duplicate lifecycle branches and obsolete snapshot handoff code in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` and `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [X] T020 Run host-side lifecycle regression from `specs/004-player-lifecycle/quickstart.md` using `CxPlayer/gradlew.bat testDebugUnitTest --tests "com.cxplayer.player.CxPlayerManagerTest" --tests "com.cxplayer.ui.player.PlayerActivityLaunchParserTest"`
- [ ] T021 Run instrumentation lifecycle regression from `specs/004-player-lifecycle/quickstart.md` using `CxPlayer/gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest`
- [ ] T022 Execute the manual lifecycle verification checklist in `specs/004-player-lifecycle/quickstart.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: Không phụ thuộc task nào khác
- **Phase 2 (Foundational)**: Phụ thuộc Phase 1 và chặn toàn bộ user story
- **Phase 3 (US1)**: Phụ thuộc Phase 2 và là MVP khuyến nghị
- **Phase 4 (US2)**: Phụ thuộc Phase 2; có thể kiểm thử độc lập nhưng nên đi sau US1 vì dùng cùng boundary snapshot/reload
- **Phase 5 (US3)**: Phụ thuộc Phase 2; an toàn nhất khi đi sau US1-US2 vì dùng chung final release và replacement flow
- **Phase 6 (Polish)**: Phụ thuộc tất cả story muốn bàn giao

### User Story Dependencies

- **US1 (P1)**: Có thể bắt đầu ngay sau Phase 2; không phụ thuộc story khác
- **US2 (P2)**: Có thể bắt đầu sau Phase 2; thực tế nên đi sau US1 để reuse cùng logic restore và giảm conflict trên `PlayerActivity.kt`
- **US3 (P3)**: Có thể bắt đầu sau Phase 2; thực tế nên đi sau US1-US2 vì dùng chung boundary release/new-intent và cần session semantics đã ổn định

### Within Each User Story

- Test task của story nên được viết trước và fail trước khi bắt đầu implementation task tương ứng
- `CxPlayerManager.kt` phải chốt semantics snapshot/release trước khi `PlayerActivity.kt` phụ thuộc vào chúng ở boundary lifecycle liên quan
- Story chỉ được coi là xong khi independent test của story đó pass độc lập

### Parallel Opportunities

- T001, T002, và T003 có thể chạy song song trong Phase 1
- T005 và T006 có thể chạy song song trong Phase 2 sau khi đã rõ boundary ở T004
- Trong US1: T007 và T008 có thể chạy song song
- Trong US2: T011 và T012 có thể chạy song song
- Trong US3: T015 và T016 có thể chạy song song

---

## Parallel Example: User Story 1

```text
T007 [US1] Add foreground/background continuity assertions for local and HTTP launches in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
T008 [US1] Add unit coverage for snapshot export and same-request resume after temporary release in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
```

## Parallel Example: User Story 2

```text
T011 [US2] Add recreate and multi-item current-index persistence assertions in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
T012 [US2] Add unit coverage for snapshot precedence over request defaults and invalid snapshot fallback in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
```

## Parallel Example: User Story 3

```text
T015 [US3] Add clean-exit and reopen-without-stale-session assertions in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
T016 [US3] Add unit coverage for idempotent release and post-exit stale snapshot invalidation in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Hoàn thành US1 (T007-T010)
3. Chạy T020 và independent test của US1
4. Demo continuity của local + HTTP launch trước khi mở rộng recreate và clean exit

### Incremental Delivery

1. Setup + Foundational → boundary snapshot/session sẵn sàng
2. US1 → foreground/background continuity ổn định
3. US2 → recreate continuity và fallback rõ ràng
4. US3 → clean exit và request replacement ổn định
5. Polish → chạy regression + manual verification

### Parallel Team Strategy

1. Một người chuẩn bị lifecycle copy và unit-test fixtures (T001-T002) trong khi người khác chuẩn bị ActivityScenario helpers (T003)
2. Trong US1, một người viết instrumentation assertions (T007) song song với người viết manager unit coverage (T008)
3. Trong US2, một người viết recreate assertions (T011) song song với người khác khóa snapshot fallback semantics (T012)
4. Trong US3, một người viết clean-exit assertions (T015) song song với người khác viết idempotent-release coverage (T016)

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, và toàn bộ US1
- **Next**: US2 để khóa continuity qua recreate trước khi xử lý stale-session edge cases
- **Last**: US3 vì dựa trên boundary release và replacement đã ổn định

---

## Notes

- Tổng số task: 22
- Task theo user story: US1 = 4, US2 = 4, US3 = 4
- Setup/Foundation/Polish: 10 task
- Parallel opportunities đã đánh dấu: 11 task
- Tất cả task đều dùng checklist format checkbox + Task ID tuần tự, với story label chỉ xuất hiện ở phase user story và mỗi task đều có file path rõ ràng