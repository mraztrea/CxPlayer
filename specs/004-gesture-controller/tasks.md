# Tasks: Playback Gesture Controller

**Input**: Design documents from `/specs/004-gesture-controller/`  
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/gesture-controller-contract.md, quickstart.md

**Tests**: Bao gồm task test vì `plan.md`, `research.md`, và `quickstart.md` đã chốt unit test cho gesture math, quantified threshold mapping, callback sequencing, và instrumentation test cho `PlayerView` touch integration.

**Organization**: Tasks được nhóm theo user story để mỗi story có thể triển khai và kiểm thử độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì khác file và không phụ thuộc task chưa hoàn thành
- **[Story]**: Ánh xạ tới user story tương ứng trong spec (`US1`, `US2`, `US3`)
- Mỗi task đều ghi rõ file path cần chạm tới

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị entry point và test harness cho gesture feature trước khi thêm logic nhận diện thật

- [X] T001 Create `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt` as the dedicated touch coordination entry point for player gestures
- [X] T002 [P] Create `CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt` for host-side gesture math, threshold profile, and callback sequencing coverage
- [X] T003 [P] Prepare gesture dispatch scaffolding around `playerView` in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Thiết lập contract gesture và integration hooks mà mọi user story đều phụ thuộc vào

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này xong

- [X] T004 Implement shared gesture session state, zone resolution helpers, and quantified threshold profile (`150px`, `1f`, `0.05f`, `100ms`, `10000ms`, `2f`, `1f..3f`) in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt`
- [X] T005 [P] Add temporary playback speed control APIs needed for long-press `2x` fast forward in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [X] T006 Implement `GestureController` ownership, `AudioManager`/brightness dependencies, and callback plumbing in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T007 [P] Add reusable touch dispatch and gesture assertion helpers for quantified gesture mapping in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

**Checkpoint**: `GestureController`, `PlayerActivity`, và `CxPlayerManager` đã có boundary ổn định để story work chỉ cần lấp từng nhánh gesture

---

## Phase 3: User Story 1 - Adjust Playback Without Leaving the Video Surface (Priority: P1) 🎯 MVP

**Goal**: Người dùng vuốt trực tiếp trên vùng phát để điều chỉnh âm lượng, độ sáng và seek mà không cần mở control phụ

**Independent Test**: Mở một video đang phát, vuốt dọc nửa phải/nửa trái và vuốt ngang trên `playerView`, rồi xác nhận mapping `1 bước / 150px`, `0,05 / 150px`, và `distance * 100ms` được áp đúng mà không phát sai loại effect

### Tests for User Story 1

- [X] T008 [P] [US1] Add zone-lock, axis-lock, and quantified swipe-delta unit coverage for `150px`, `0.05`, and `100ms` mapping in `CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt`
- [X] T009 [P] [US1] Add instrumentation swipe assertions for quantified seek, brightness, and volume handling in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 1

- [X] T010 [US1] Implement right-half volume, left-half brightness, and horizontal seek gesture parsing with `1 bước / 150px`, `0.05 / 150px`, and `distance * 100ms` rules in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt`
- [X] T011 [US1] Wire quantified volume, brightness, and seek-delta callbacks to device/player side effects in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 1 hoàn chỉnh khi vuốt dọc/ngang trên `playerView` điều khiển đúng hành vi định lượng mà không làm rơi playback session

---

## Phase 4: User Story 2 - Trigger Common Playback Actions with Simple Touch Gestures (Priority: P2)

**Goal**: Người dùng double tap hoặc long press trên vùng phát để play/pause, seek ±10 giây và kích hoạt tua nhanh tạm thời 2x

**Independent Test**: Phát một video, double tap ở vùng trái/giữa/phải và nhấn giữ trên `playerView`, rồi xác nhận seek cố định `±10000ms`, toggle play/pause đúng một lần và long-press lifecycle `2x` xuất hiện đúng cặp start/end

### Tests for User Story 2

- [X] T012 [P] [US2] Add double-tap zone routing and long-press lifecycle unit coverage for `±10000ms` seek and `2f` fast-forward in `CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt`
- [X] T013 [P] [US2] Add instrumentation coverage for center/side double tap and temporary `2x` fast-forward behavior in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 2

- [X] T014 [US2] Implement center/side double tap detection and long-press start/end callbacks with fixed `±10000ms` seek mapping in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt`
- [X] T015 [US2] Add temporary playback speed start/reset helpers for `2f` long-press fast forward in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [X] T016 [US2] Wire play/pause toggle, fixed seek `±10000ms`, and long-press `2x` lifecycle in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 2 hoàn chỉnh khi gesture chạm nhanh và nhấn giữ tạo đúng playback action mà không cần chạm transport buttons

---

## Phase 5: User Story 3 - Keep Gesture Recognition Predictable During Complex Touch Input (Priority: P3)

**Goal**: Pinch và các chuỗi touch phức tạp được phân giải nhất quán, không tạo outcome mâu thuẫn khi người dùng đổi kiểu thao tác giữa chừng

**Independent Test**: Dùng pinch, multi-touch transition và thao tác mơ hồ trên `playerView`, rồi xác nhận zoom bị chặn trong dải `1,0x -> 3,0x` và chỉ một outcome hợp lệ được phát ra cho mỗi gesture session

### Tests for User Story 3

- [X] T017 [P] [US3] Add pinch-priority, ambiguous-gesture cancellation, and `1f..3f` zoom-bound unit coverage in `CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt`
- [X] T018 [P] [US3] Add instrumentation coverage for bounded pinch zoom and multi-touch conflict handling on `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 3

- [X] T019 [US3] Implement pinch detection, ambiguous-session cancellation, mixed-touch conflict guards, and zoom clamping to `1f..3f` in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt`
- [X] T020 [US3] Apply bounded zoom callback behavior and lifecycle-safe gesture cleanup in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 3 hoàn chỉnh khi pinch hoạt động và không có chuỗi chạm nào phát đồng thời các outcome mâu thuẫn

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Dọn code, khóa regression, và xác nhận quickstart trước khi chuyển sang feature gesture tiếp theo

- [X] T021 Clean up duplicated gesture constants and unused plumbing in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt`, `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`, and `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [X] T022 Run host-side quickstart validation with `CxPlayer/gradlew.bat testDebugUnitTest --tests com.cxplayer.ui.player.GestureControllerTest`
- [ ] T023 Run androidTest compile, instrumentation, and manual gesture verification from `specs/004-gesture-controller/quickstart.md` with `CxPlayer/gradlew.bat compileDebugAndroidTestKotlin` and `CxPlayer/gradlew.bat connectedDebugAndroidTest`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: Không phụ thuộc task nào khác
- **Phase 2 (Foundational)**: Phụ thuộc Phase 1 và chặn toàn bộ user story
- **Phase 3 (US1)**: Phụ thuộc Phase 2 và là MVP khuyến nghị
- **Phase 4 (US2)**: Phụ thuộc Phase 2; có thể kiểm thử độc lập nhưng triển khai an toàn nhất sau US1 vì reuse cùng gesture session scaffolding và `PlayerActivity`
- **Phase 5 (US3)**: Phụ thuộc US1 và US2 vì nhánh pinch/conflict management phải bao quanh đầy đủ hành vi một ngón và long-press đã ổn định
- **Phase 6 (Polish)**: Phụ thuộc tất cả story muốn bàn giao

### User Story Dependencies

- **US1 (P1)**: Có thể bắt đầu ngay sau Phase 2; không phụ thuộc story nào khác
- **US2 (P2)**: Có thể kiểm thử độc lập sau Phase 2, nhưng thứ tự triển khai an toàn nhất là sau US1 vì chạm cùng `GestureController.kt` và `PlayerActivity.kt`
- **US3 (P3)**: Phụ thuộc US1 và US2 vì pinch priority và mixed-touch guards phải được áp lên đầy đủ mapping swipe, double tap và long press đã tồn tại

### Within Each User Story

- Test task của story nên được viết trước và fail trước khi bắt đầu implementation task tương ứng
- `GestureController.kt` phải hoàn tất nhánh nhận diện của story trước khi `PlayerActivity.kt` wiring side effect cho story đó
- `CxPlayerManager.kt` phải có playback speed helpers trước khi wiring long-press 2x ở `PlayerActivity.kt`
- Story chỉ được coi là xong khi independent test của story đó pass độc lập

### Parallel Opportunities

- T002 và T003 có thể chạy song song sau T001
- T005 và T007 có thể chạy song song trong Phase 2
- Trong US1: T008 và T009 có thể chạy song song
- Trong US2: T012 và T013 có thể chạy song song
- Trong US3: T017 và T018 có thể chạy song song

---

## Parallel Example: User Story 1

```text
T008 [US1] Add zone-lock, axis-lock, and quantified swipe-delta unit coverage in CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt
T009 [US1] Add instrumentation swipe assertions for quantified seek, brightness, and volume handling in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 2

```text
T012 [US2] Add double-tap zone routing and long-press lifecycle unit coverage in CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt
T013 [US2] Add instrumentation coverage for center/side double tap and temporary 2x fast-forward behavior in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 3

```text
T017 [US3] Add pinch-priority, ambiguous-gesture cancellation, and zoom-bound unit coverage in CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt
T018 [US3] Add instrumentation coverage for bounded pinch zoom and multi-touch conflict handling on CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Hoàn thành US1 (T008-T011)
3. Chạy T022 cho host-side gesture regression
4. Demo swipe volume/brightness/seek với mapping định lượng trên `playerView` trước khi mở rộng sang double tap, long press và pinch

### Incremental Delivery

1. Setup + Foundational → gesture boundary và player integration hooks sẵn sàng
2. US1 → quantified swipe mapping ổn định
3. US2 → double tap và long press playback actions ổn định
4. US3 → pinch và conflict handling được khóa
5. Polish → regression + manual verification hoàn tất

### Parallel Team Strategy

1. Một người dựng `GestureController.kt` entry point (T001) trong khi người khác chuẩn bị test file sau đó (T002-T003)
2. Trong Phase 2, một người thêm speed API ở `CxPlayerManager.kt` (T005) song song với người chuẩn bị instrumentation helpers (T007)
3. Trong từng user story, cặp task test `[P]` có thể được thực hiện song song trước khi merge vào implementation task của story đó

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, và toàn bộ US1
- **Next**: US2 để hoàn thiện touch shortcuts cho playback actions phổ biến
- **Last**: US3 vì đây là lớp ổn định hóa cuối cùng trên toàn bộ gesture state machine

---

## Notes

- Tổng số task: 23
- Task theo user story: US1 = 4, US2 = 5, US3 = 4
- Setup/Foundation/Polish: 10 task
- Parallel opportunities đã đánh dấu: 10 task
- T023 vẫn mở vì `connectedDebugAndroidTest` hiện bị chặn bởi `INSTALL_FAILED_ABORTED: User rejected permissions` trên thiết bị, và full class instrumentation còn crash ở `recreateAndOrientationChangeKeepPlayerChromeVisible` ngoài slice gesture vừa cập nhật.