# Tasks: Track Selector UI

**Input**: Design documents from `/specs/008-track-selector-ui/`  
**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `contracts/track-selector-ui-contract.md`, `quickstart.md`

**Tests**: Bao gồm task test vì `plan.md`, `research.md`, `contracts/` và `quickstart.md` đã chốt rõ unit coverage cho audio-track mapping, regression/smoke coverage cho playback screen, cùng compile/manual validation cho selector popup.

**Organization**: Tasks được nhóm theo user story để mỗi story có thể triển khai và kiểm thử độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì chạm file khác nhau và không phụ thuộc task chưa hoàn thành
- **[Story]**: Ánh xạ tới user story tương ứng trong spec (`US1`, `US2`, `US3`)
- Mỗi task đều ghi rõ file path cần chạm

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị shell UI selector, resource và test fixture trước khi chạm vào playback orchestration

- [ ] T001 [P] Create the popup selector shell and section/item runtime models in `CxPlayer/app/src/main/java/com/cxplayer/ui/controls/TrackSelector.kt`
- [ ] T002 [P] Add selector popup container and option row layouts in `CxPlayer/app/src/main/res/layout/popup_track_selector.xml` and `CxPlayer/app/src/main/res/layout/item_track_selector_option.xml`
- [ ] T003 [P] Add selector section titles, empty-state labels, and track-switch feedback strings in `CxPlayer/app/src/main/res/values/strings.xml`
- [ ] T004 [P] Create audio-track controller test fixtures and fake player helpers in `CxPlayer/app/src/test/java/com/cxplayer/player/TrackSelectorSessionControllerTest.kt`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Dựng shared seams cho audio-track controller, activity host hooks và playback smoke harness mà mọi user story đều phụ thuộc vào

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này xong

- [ ] T005 Create the audio-track runtime controller and option snapshot mapping shell in `CxPlayer/app/src/main/java/com/cxplayer/player/TrackSelectorSessionController.kt`
- [ ] T006 [P] Extend player-session access needed by selector orchestration in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [ ] T007 Add selector host lifecycle hooks and popup state placeholders in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [ ] T008 [P] Prepare playback smoke helpers for selector open/dismiss assertions in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

**Checkpoint**: Selector feature có shared controller seam, activity host seam và test harness đủ ổn để từng story được triển khai độc lập

---

## Phase 3: User Story 1 - Đổi audio track ngay trong lúc xem (Priority: P1) 🎯 MVP

**Goal**: Người dùng mở popup selector và đổi được audio track đang active mà video vẫn tiếp tục phát bình thường

**Independent Test**: Mở video có từ hai audio track trở lên, mở selector, chọn audio track khác và xác nhận âm thanh chuyển đúng trong phiên xem hiện tại mà không mất playback snapshot

### Tests for User Story 1

- [ ] T009 [P] [US1] Add unit coverage for audio-track label mapping and selected-state snapshots in `CxPlayer/app/src/test/java/com/cxplayer/player/TrackSelectorSessionControllerTest.kt`
- [ ] T010 [P] [US1] Add playback smoke coverage for opening the selector and switching audio tracks in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 1

- [ ] T011 [US1] Implement audio-track discovery, fallback labeling, and override selection in `CxPlayer/app/src/main/java/com/cxplayer/player/TrackSelectorSessionController.kt`
- [ ] T012 [US1] Implement the audio section rendering and option click callbacks in `CxPlayer/app/src/main/java/com/cxplayer/ui/controls/TrackSelector.kt`
- [ ] T013 [US1] Wire `playerSettingsButton` popup launch and audio-track apply feedback in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 1 hoàn chỉnh khi selector mở được và audio track đổi thành công mà không làm gián đoạn phiên phát

---

## Phase 4: User Story 2 - Chọn phụ đề hoặc tắt phụ đề từ cùng một nơi (Priority: P2)

**Goal**: Người dùng dùng cùng popup selector để chuyển giữa subtitle khả dụng và trạng thái `Off` mà vẫn giữ luồng nạp phụ đề ngoài hiện có

**Independent Test**: Với video có embedded subtitle hoặc external subtitle đã nạp, mở selector, chọn subtitle khác hoặc `Off`, rồi xác nhận subtitle đổi đúng còn playback vẫn tiếp tục và overflow vẫn mở được file picker phụ đề ngoài

### Tests for User Story 2

- [ ] T014 [P] [US2] Add unit coverage for selector-facing subtitle source snapshots and off-state mapping in `CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt`
- [ ] T015 [P] [US2] Add playback smoke coverage for subtitle selection, subtitle off, and overflow picker continuity in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 2

- [ ] T016 [US2] Expose selector-friendly subtitle source refresh helpers in `CxPlayer/app/src/main/java/com/cxplayer/player/SubtitleManager.kt`
- [ ] T017 [US2] Implement the subtitle section rendering and selection callback flow in `CxPlayer/app/src/main/java/com/cxplayer/ui/controls/TrackSelector.kt`
- [ ] T018 [US2] Rewire external subtitle picker entry to `playerOverflowButton` and connect selector subtitle actions in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 2 hoàn chỉnh khi popup selector hiển thị `Off`, embedded và external subtitles đúng trạng thái, và luồng nạp subtitle ngoài không bị regression

---

## Phase 5: User Story 3 - Hiểu nhanh trạng thái track hiện tại (Priority: P3)

**Goal**: Người dùng nhìn vào popup selector và biết ngay audio/subtitle nào đang active, cũng như trạng thái khi không có lựa chọn hữu ích

**Independent Test**: Mở selector trên video chỉ có một audio track hoặc không có subtitle, rồi xác nhận selected marker, fallback label và empty-state message đều rõ ràng; recreate activity xong popup không để lại state rác

### Tests for User Story 3

- [ ] T019 [P] [US3] Add unit coverage for ambiguous audio labels and section empty-state snapshots in `CxPlayer/app/src/test/java/com/cxplayer/player/TrackSelectorSessionControllerTest.kt`
- [ ] T020 [P] [US3] Add playback smoke coverage for single-audio or no-subtitle states and popup dismissal on recreate in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 3

- [ ] T021 [US3] Implement selected-marker and empty-state row presentation for both sections in `CxPlayer/app/src/main/java/com/cxplayer/ui/controls/TrackSelector.kt`
- [ ] T022 [US3] Normalize fallback labels and empty-state messaging for ambiguous track metadata in `CxPlayer/app/src/main/java/com/cxplayer/player/TrackSelectorSessionController.kt`
- [ ] T023 [US3] Sync selector refresh and dismiss behavior across recreate and playback-state changes in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 3 hoàn chỉnh khi popup luôn cho thấy trạng thái hiện tại một cách rõ ràng và không giữ state stale qua lifecycle changes

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Khóa validation cuối, xác nhận quickstart và dọn placeholder/wiring thừa của selector feature

- [ ] T024 [P] Run the host-side validation commands documented for selector coverage in `specs/008-track-selector-ui/quickstart.md`
- [ ] T025 Run the androidTest compile and manual track-selector verification checklist in `specs/008-track-selector-ui/quickstart.md`
- [ ] T026 Clean up selector-specific placeholder wiring and resource drift in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`, `CxPlayer/app/src/main/java/com/cxplayer/ui/controls/TrackSelector.kt`, and `CxPlayer/app/src/main/res/values/strings.xml`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: Không phụ thuộc task nào khác
- **Phase 2 (Foundational)**: Phụ thuộc Phase 1 và chặn toàn bộ user story
- **Phase 3 (US1)**: Phụ thuộc Phase 2 và là MVP khuyến nghị
- **Phase 4 (US2)**: Phụ thuộc Phase 2; về mặt chức năng có thể test độc lập, nhưng cùng mở rộng `TrackSelector.kt` và `PlayerActivity.kt` nên merge an toàn nhất là sau US1
- **Phase 5 (US3)**: Phụ thuộc Phase 2; vẫn độc lập về outcome nhưng nên chốt sau US1 và US2 vì cùng chạm selector state presentation
- **Phase 6 (Polish)**: Phụ thuộc các story muốn bàn giao

### User Story Dependencies

- **US1 (P1)**: Có thể bắt đầu ngay sau Phase 2; không phụ thuộc user story nào khác và là phạm vi MVP
- **US2 (P2)**: Có thể bắt đầu sau Phase 2; dùng lại subtitle runtime state sẵn có nhưng trên một code line duy nhất nên thực tế nên rebase trên popup shell của US1
- **US3 (P3)**: Có thể bắt đầu sau Phase 2; không cần logic business mới nhưng phụ thuộc selector presentation đã tồn tại để khóa readability states

### Within Each User Story

- Test task của story nên được viết trước và fail trước khi implementation task tương ứng bắt đầu
- Controller/state mapping phải xong trước khi UI popup render section tương ứng
- UI popup phải xong trước khi `PlayerActivity.kt` nối callback user-facing và feedback message
- Mỗi story chỉ được coi là xong khi independent test của story đó pass độc lập và outcome khớp `spec.md` cùng `quickstart.md`

### Parallel Opportunities

- T001, T002, T003, và T004 có thể chạy song song trong Phase 1 vì chạm file khác nhau
- T006 và T008 có thể chạy song song trong Phase 2 trong khi T005 hoặc T007 đang được triển khai
- T009 và T010 có thể chạy song song trong US1
- T014 và T015 có thể chạy song song trong US2
- T019 và T020 có thể chạy song song trong US3
- T024 có thể chạy song song với phần chuẩn bị manual verification của T025 sau khi code đã ổn định

---

## Parallel Example: User Story 1

```text
T009 [US1] Add unit coverage for audio-track label mapping and selected-state snapshots in CxPlayer/app/src/test/java/com/cxplayer/player/TrackSelectorSessionControllerTest.kt
T010 [US1] Add playback smoke coverage for opening the selector and switching audio tracks in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 2

```text
T014 [US2] Add unit coverage for selector-facing subtitle source snapshots and off-state mapping in CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt
T015 [US2] Add playback smoke coverage for subtitle selection, subtitle off, and overflow picker continuity in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 3

```text
T019 [US3] Add unit coverage for ambiguous audio labels and section empty-state snapshots in CxPlayer/app/src/test/java/com/cxplayer/player/TrackSelectorSessionControllerTest.kt
T020 [US3] Add playback smoke coverage for single-audio or no-subtitle states and popup dismissal on recreate in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Hoàn thành US1 (T009-T013)
3. Chạy validation trong `specs/008-track-selector-ui/quickstart.md`
4. Demo flow mở selector và đổi audio track trước khi chuyển sang story tiếp theo

### Incremental Delivery

1. Setup + Foundational → selector shell, controller seam và smoke harness sẵn sàng
2. US1 → audio track switching hoạt động trong app
3. US2 → subtitle selection và overflow picker continuity hoàn chỉnh mà không phá US1
4. US3 → selected markers và empty-state readability hoàn chỉnh
5. Polish → compile, unit validation và manual selector matrix hoàn tất

### Parallel Team Strategy

1. Một người dựng `TrackSelector.kt` shell và resource popup, người khác chuẩn bị `TrackSelectorSessionControllerTest.kt`
2. Sau foundation, một người xử lý audio selection flow của US1 trong khi người khác viết regression test cho US2 hoặc US3
3. Khi popup/controller state đã ổn định, Phase 6 validation có thể được chuẩn bị song song với manual verification

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, và toàn bộ US1
- **Next**: US2 để khóa subtitle switching từ cùng popup mà không mất luồng nạp phụ đề ngoài
- **Last**: US3 vì đây là lớp clarity/readability polish dựa trên selector shell đã ổn định

---

## Notes

- Tổng số task: 26
- Task theo user story: US1 = 5, US2 = 5, US3 = 5
- Setup/Foundation/Polish: 11 task
- Parallel opportunities đã đánh dấu: 13 task
- Mọi task implementation đều theo đúng checklist format `- [ ] Txxx ... in <file path>` để có thể thực thi ngay bởi một coding agent