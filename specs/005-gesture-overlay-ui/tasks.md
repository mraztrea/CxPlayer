# Tasks: Gesture Overlay UI

**Input**: Design documents from `/specs/005-gesture-overlay-ui/`  
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/gesture-overlay-ui-contract.md, quickstart.md

**Tests**: Bao gồm task test vì spec, plan và quickstart đã chốt host-side coverage cho overlay-state formatting hoặc transition và instrumentation coverage cho overlay visibility hoặc lifecycle trên `PlayerActivity`.

**Organization**: Tasks được nhóm theo user story để mỗi story có thể triển khai và kiểm thử độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì khác file và không phụ thuộc task chưa hoàn thành
- **[Story]**: Ánh xạ tới user story tương ứng trong spec (`US1`, `US2`, `US3`)
- Mỗi task đều ghi rõ file path cần chạm

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị file entry point, harness test và shell resource cho overlay trước khi thêm logic hiển thị thật

- [X] T001 Create `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureOverlayState.kt` as the runtime overlay state and formatter entry point
- [X] T002 [P] Create `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityGestureOverlayTest.kt` for host-side overlay formatting and state transition coverage
- [X] T003 [P] Prepare overlay shell ids and placeholder card structure in `CxPlayer/app/src/main/res/layout/activity_player.xml`
- [X] T004 [P] Add base overlay background and sizing resources in `CxPlayer/app/src/main/res/drawable/bg_player_gesture_overlay.xml`, `CxPlayer/app/src/main/res/values/dimens.xml`, and `CxPlayer/app/src/main/res/values/strings.xml`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Thiết lập shared overlay state, activity wiring và test helpers mà mọi user story đều phụ thuộc vào

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này xong

- [X] T005 Implement shared overlay types, display value formatting, and dismiss-window state transitions in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureOverlayState.kt`
- [X] T006 [P] Bind overlay views, auto-dismiss scheduling, and lifecycle cleanup hooks in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T007 [P] Add reusable overlay visibility and timeout assertion helpers in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

**Checkpoint**: Overlay runtime boundary ổn định; từng user story giờ chỉ cần lấp logic mapping hoặc lifecycle cho loại feedback tương ứng

---

## Phase 3: User Story 1 - Nhìn thấy phản hồi ngay khi vuốt (Priority: P1) 🎯 MVP

**Goal**: Người dùng vuốt volume, brightness và seek đều thấy đúng overlay ngay trên màn hình phát với giá trị dễ đọc

**Independent Test**: Phát một video, vuốt dọc nửa phải, vuốt dọc nửa trái và vuốt ngang trên `playerView`, rồi xác nhận overlay hiện đúng loại, đúng giá trị hiển thị và tự ẩn sau khi ngừng thao tác

### Tests for User Story 1

- [X] T008 [P] [US1] Add host-side coverage for volume percent, brightness percent, seek delta formatting, and clamp-aware display values in `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityGestureOverlayTest.kt`
- [X] T009 [P] [US1] Add instrumentation swipe overlay assertions for volume, brightness, and seek visibility on `playerView` in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 1

- [X] T010 [US1] Implement swipe overlay state mapping for volume, brightness, and seek delta in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureOverlayState.kt`
- [X] T011 [US1] Render swipe overlay updates from gesture callbacks in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T012 [US1] Finalize swipe overlay labels, cue text, and card layout for volume, brightness, and seek in `CxPlayer/app/src/main/res/layout/activity_player.xml` and `CxPlayer/app/src/main/res/values/strings.xml`

**Checkpoint**: User Story 1 hoàn chỉnh khi thao tác swipe hiển thị feedback trực quan đúng loại và đủ rõ để dùng như MVP của overlay gesture

---

## Phase 4: User Story 2 - Biết rõ khi đang tua nhanh tạm thời (Priority: P2)

**Goal**: Người dùng nhấn giữ để fast-forward 2x sẽ thấy overlay chuyên biệt trong suốt thời gian giữ và biến mất đúng lúc sau khi thả

**Independent Test**: Phát một video, nhấn giữ trên `playerView`, rồi xác nhận overlay `2X` xuất hiện xuyên suốt thời gian giữ và được gỡ bỏ ngay sau khi thao tác kết thúc hoặc bị hủy

### Tests for User Story 2

- [X] T013 [P] [US2] Add host-side tests for sticky fast-forward overlay state and release-triggered dismiss scheduling in `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityGestureOverlayTest.kt`
- [X] T014 [P] [US2] Add instrumentation assertions for long-press `2X` overlay visibility and release behavior in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 2

- [X] T015 [US2] Implement fast-forward overlay state, cue text, and release transition rules in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureOverlayState.kt`
- [X] T016 [US2] Wire long-press `2X` overlay show or hide lifecycle in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 2 hoàn chỉnh khi long-press feedback hoạt động độc lập và không làm ảnh hưởng overlay swipe đã có

---

## Phase 5: User Story 3 - Giữ overlay rõ ràng khi thao tác liên tiếp (Priority: P3)

**Goal**: Overlay luôn chỉ hiển thị một card đang hiệu lực, thay nội dung tại chỗ khi gesture đổi loại và dọn sạch an toàn khi lifecycle hoặc interaction bị hủy

**Independent Test**: Thực hiện volume rồi seek liên tiếp, lặp nhiều gesture hỗ trợ liên tục và thử đóng activity hoặc hủy thao tác giữa chừng, rồi xác nhận không có overlay cũ bị kẹt hoặc chồng lớp

### Tests for User Story 3

- [X] T017 [P] [US3] Add host-side tests for overlay replacement, single-card invariants, and cancellation cleanup in `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityGestureOverlayTest.kt`
- [X] T018 [P] [US3] Add instrumentation coverage for overlay replacement, auto-dismiss reset, and lifecycle cleanup in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 3

- [X] T019 [US3] Implement overlay replacement, dismiss-window reset, and single-visible-card rules in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureOverlayState.kt`
- [X] T020 [US3] Enforce lifecycle-safe overlay cleanup and card reuse in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` and `CxPlayer/app/src/main/res/layout/activity_player.xml`

**Checkpoint**: User Story 3 hoàn chỉnh khi overlay không chồng lớp, không kẹt state và vẫn nhất quán qua các chuỗi gesture liên tiếp

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Dọn code, khóa regression và xác nhận quickstart cho toàn bộ feature overlay

- [ ] T021 Clean up duplicated overlay constants and unused resource wiring in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureOverlayState.kt`, `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`, and `CxPlayer/app/src/main/res/values/strings.xml`
- [X] T022 Run host-side overlay quickstart validation from `specs/005-gesture-overlay-ui/quickstart.md` with `CxPlayer/gradlew.bat testDebugUnitTest --tests com.cxplayer.ui.player.PlayerActivityGestureOverlayTest`
- [ ] T023 Run androidTest compile, instrumentation, and manual overlay verification from `specs/005-gesture-overlay-ui/quickstart.md` with `CxPlayer/gradlew.bat compileDebugAndroidTestKotlin` and `CxPlayer/gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: Không phụ thuộc task nào khác
- **Phase 2 (Foundational)**: Phụ thuộc Phase 1 và chặn toàn bộ user story
- **Phase 3 (US1)**: Phụ thuộc Phase 2 và là MVP khuyến nghị
- **Phase 4 (US2)**: Phụ thuộc Phase 2; có thể kiểm thử độc lập sau foundation vì long-press overlay dùng cùng overlay boundary nhưng không cần logic swipe hoàn chỉnh để bắt đầu
- **Phase 5 (US3)**: Phụ thuộc US1 và US2 vì replacement và cleanup phải bao phủ đủ các loại overlay đã tồn tại
- **Phase 6 (Polish)**: Phụ thuộc tất cả story muốn bàn giao

### User Story Dependencies

- **US1 (P1)**: Có thể bắt đầu ngay sau Phase 2; không phụ thuộc story nào khác
- **US2 (P2)**: Có thể bắt đầu ngay sau Phase 2 và vẫn độc lập test được, nhưng thứ tự triển khai an toàn nhất là sau US1 vì tái sử dụng cùng overlay card và scheduler
- **US3 (P3)**: Phụ thuộc US1 và US2 vì logic replacement và cleanup phải áp trên toàn bộ loại overlay đã được hỗ trợ

### Within Each User Story

- Test task của story nên được viết trước và fail trước khi bắt đầu implementation task tương ứng
- `GestureOverlayState.kt` phải hoàn tất mapping hoặc transition logic trước khi `PlayerActivity.kt` wiring UI theo story đó
- `PlayerActivity.kt` phải hoàn tất trước khi tinh chỉnh resource hoặc lifecycle assertions cuối cùng cho story tương ứng
- Story chỉ được coi là xong khi independent test của story đó pass độc lập

### Parallel Opportunities

- T002, T003, và T004 có thể chạy song song sau khi chốt scope setup
- T006 và T007 có thể chạy song song trong Phase 2
- Trong US1: T008 và T009 có thể chạy song song
- Trong US2: T013 và T014 có thể chạy song song
- Trong US3: T017 và T018 có thể chạy song song

---

## Parallel Example: User Story 1

```text
T008 [US1] Add host-side coverage for volume percent, brightness percent, seek delta formatting, and clamp-aware display values in CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityGestureOverlayTest.kt
T009 [US1] Add instrumentation swipe overlay assertions for volume, brightness, and seek visibility on playerView in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 2

```text
T013 [US2] Add host-side tests for sticky fast-forward overlay state and release-triggered dismiss scheduling in CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityGestureOverlayTest.kt
T014 [US2] Add instrumentation assertions for long-press 2X overlay visibility and release behavior in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 3

```text
T017 [US3] Add host-side tests for overlay replacement, single-card invariants, and cancellation cleanup in CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityGestureOverlayTest.kt
T018 [US3] Add instrumentation coverage for overlay replacement, auto-dismiss reset, and lifecycle cleanup in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Hoàn thành US1 (T008-T012)
3. Chạy T022 cho host-side overlay regression
4. Demo swipe volume, brightness và seek overlay trên `playerView` trước khi mở rộng sang fast-forward và cleanup nâng cao

### Incremental Delivery

1. Setup + Foundational → overlay boundary và test helpers sẵn sàng
2. US1 → swipe feedback trực quan ổn định
3. US2 → long-press `2X` feedback ổn định
4. US3 → replacement và cleanup rules được khóa
5. Polish → regression + manual verification hoàn tất

### Parallel Team Strategy

1. Một người chuẩn bị `GestureOverlayState.kt` trong khi người khác dựng test scaffold và layout shell ở Phase 1
2. Trong Phase 2, một người wiring `PlayerActivity.kt` còn người khác hoàn thiện instrumentation helpers
3. Trong từng user story, cặp task test `[P]` có thể được thực hiện song song trước khi merge vào implementation task của story đó

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, và toàn bộ US1
- **Next**: US2 để hoàn thiện fast-forward feedback cho thao tác long press
- **Last**: US3 vì đây là lớp ổn định hóa cuối cùng cho overlay lifecycle và replacement

---

## Notes

- Tổng số task: 23
- Task theo user story: US1 = 5, US2 = 4, US3 = 4
- Setup/Foundation/Polish: 10 task
- Parallel opportunities đã đánh dấu: 9 task
- T023 có thể tiếp tục bị chặn bởi prompt cài test app trên thiết bị thật (`INSTALL_FAILED_ABORTED`) hoặc thiếu thiết bị kết nối, nên `compileDebugAndroidTestKotlin` vẫn là sanity-check tối thiểu nếu chưa thể chạy full instrumentation