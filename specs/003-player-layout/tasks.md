# Tasks: Playback Screen Layout

**Input**: Design documents from `/specs/003-player-layout/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/player-screen-layout-contract.md, quickstart.md

**Tests**: Bao gồm task test vì `plan.md`, `research.md`, và `quickstart.md` đã chốt instrumentation assertions cho layout visibility, orientation reflow, và smoke validation của `PlayerActivity`.

**Organization**: Tasks được nhóm theo user story để mỗi story có thể triển khai và kiểm thử độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì khác file và không phụ thuộc task chưa hoàn thành
- **[Story]**: Ánh xạ tới user story tương ứng trong spec (`US1`, `US2`, `US3`)
- Mỗi task đều ghi rõ file path cần chạm tới

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị resource dùng chung cho toàn bộ player chrome trước khi thay bố cục và wiring activity

- [X] T001 [P] Add shared player chrome scrim resources in `CxPlayer/app/src/main/res/values/colors.xml` and `CxPlayer/app/src/main/res/drawable/bg_player_chrome_scrim.xml`
- [X] T002 [P] Add fallback text and accessibility strings for player chrome in `CxPlayer/app/src/main/res/values/strings.xml`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Thiết lập skeleton overlay và wiring nền tảng mà mọi user story đều phụ thuộc vào

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này xong

- [X] T003 Replace the single-surface root with overlay-ready chrome containers and stable region IDs in `CxPlayer/app/src/main/res/layout/activity_player.xml`
- [X] T004 Add player chrome view references and initialization entry points in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T005 [P] Add reusable player chrome lookup and assertion helpers in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

**Checkpoint**: `PlayerActivity` và `activity_player.xml` đã có skeleton ổn định để US1-US3 chỉ cần lấp từng region theo story

---

## Phase 3: User Story 1 - See Video and Core Controls Immediately (Priority: P1) 🎯 MVP

**Goal**: Người dùng mở player và thấy ngay video region, timeline region, và transport region ở vị trí ổn định trên màn hình đầu tiên

**Independent Test**: Mở một video hợp lệ và xác nhận `playerView`, timeline row, và transport row đều hiển thị đầy đủ mà không cần thao tác bổ sung

### Tests for User Story 1

- [X] T006 [P] [US1] Add first-render assertions for video, timeline, and transport regions in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 1

- [X] T007 [US1] Add `playerCurrentTimeView`, `playerSeekBar`, `playerDurationView`, `playerSeekBackButton`, `playerPlayPauseButton`, `playerSeekForwardButton`, `playerVolumeButton`, and `playerSettingsButton` to `CxPlayer/app/src/main/res/layout/activity_player.xml`
- [X] T008 [P] [US1] Add transport vector assets in `CxPlayer/app/src/main/res/drawable/ic_player_seek_back.xml`, `CxPlayer/app/src/main/res/drawable/ic_player_play.xml`, `CxPlayer/app/src/main/res/drawable/ic_player_pause.xml`, `CxPlayer/app/src/main/res/drawable/ic_player_seek_forward.xml`, `CxPlayer/app/src/main/res/drawable/ic_player_volume.xml`, and `CxPlayer/app/src/main/res/drawable/ic_player_settings.xml`
- [X] T009 [US1] Bind bottom chrome placeholder values, icon state, and safe no-op click handlers in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 1 hoàn chỉnh khi màn hình player có video + bottom chrome đầy đủ và mở lên ổn định trên local/HTTP launch

---

## Phase 4: User Story 2 - Understand Context and Leave Quickly (Priority: P2)

**Goal**: Người dùng nhìn thấy top bar có điều hướng, tiêu đề nội dung, và overflow action mà không làm mất ngữ cảnh xem video

**Independent Test**: Mở video có hoặc không có metadata title và xác nhận back button, title fallback, và overflow action đều còn nhìn thấy, dùng được, và không che phủ vùng video chính

### Tests for User Story 2

- [X] T010 [P] [US2] Add assertions for top bar visibility, fallback title, and overflow availability in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 2

- [X] T011 [US2] Add `playerBackButton`, `playerTitleView`, and `playerOverflowButton` to the top chrome region in `CxPlayer/app/src/main/res/layout/activity_player.xml`
- [X] T012 [P] [US2] Add top-bar vector assets in `CxPlayer/app/src/main/res/drawable/ic_player_back.xml` and `CxPlayer/app/src/main/res/drawable/ic_player_overflow.xml`
- [X] T013 [US2] Wire back navigation, fallback title text, metadata title updates, and overflow placeholder behavior in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 2 hoàn chỉnh khi top bar luôn giữ được điều hướng và ngữ cảnh dù title đầy đủ, dài, hay thiếu hoàn toàn

---

## Phase 5: User Story 3 - Keep the Layout Usable Across Screen Changes (Priority: P3)

**Goal**: Toàn bộ player chrome vẫn còn nhìn thấy và thao tác được sau recreate, orientation change, và trên màn hình có chiều cao hạn chế

**Independent Test**: Mở player, xoay portrait/landscape hoặc recreate activity, rồi xác nhận top region, timeline region, và transport region vẫn còn trong viewport và không chồng lấn nhau

### Tests for User Story 3

- [X] T014 [P] [US3] Add recreate and orientation assertions for full player chrome visibility in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 3

- [X] T015 [P] [US3] Add chrome spacing and compact-height dimensions in `CxPlayer/app/src/main/res/values/dimens.xml`
- [X] T016 [US3] Apply portrait/landscape spacing, compact-height layout rules, and stable timeline sizing in `CxPlayer/app/src/main/res/layout/activity_player.xml`
- [X] T017 [US3] Apply `WindowInsets` handling and compact-mode updates for top and bottom chrome in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 3 hoàn chỉnh khi cùng một chrome contract vẫn usable sau orientation/recreate mà không cần tạo layout riêng ngoài phạm vi Phase 1

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Khóa regression, dọn wiring chéo, và xác nhận quickstart trước khi chuyển sang feature kế tiếp

- [X] T018 Clean up duplicate chrome wiring and unused placeholders in `CxPlayer/app/src/main/res/layout/activity_player.xml` and `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T019 Run host-side validation command from `specs/003-player-layout/quickstart.md` using `CxPlayer/gradlew.bat testDebugUnitTest`
- [ ] T020 Run instrumentation and manual verification scenarios from `specs/003-player-layout/quickstart.md` using `CxPlayer/gradlew.bat connectedDebugAndroidTest`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: Không phụ thuộc task nào khác
- **Phase 2 (Foundational)**: Phụ thuộc Phase 1 và chặn toàn bộ user story
- **Phase 3 (US1)**: Phụ thuộc Phase 2 và là MVP khuyến nghị
- **Phase 4 (US2)**: Phụ thuộc Phase 2; độc lập về hành vi nhưng nên đi sau US1 để giảm merge conflict trên cùng `activity_player.xml` và `PlayerActivity.kt`
- **Phase 5 (US3)**: Phụ thuộc US1 và US2 vì nó tối ưu lại toàn bộ top + bottom chrome sau khi hai region đã tồn tại
- **Phase 6 (Polish)**: Phụ thuộc tất cả story muốn bàn giao

### User Story Dependencies

- **US1 (P1)**: Có thể bắt đầu ngay sau Phase 2; không phụ thuộc story nào khác
- **US2 (P2)**: Có thể kiểm thử độc lập sau Phase 2, nhưng thứ tự triển khai an toàn nhất là sau US1 do chạm cùng layout/activity files
- **US3 (P3)**: Phụ thuộc US1 và US2 vì logic responsive/insets phải áp dụng trên đầy đủ top region, timeline region, và transport region

### Within Each User Story

- Test task của story nên được viết trước và fail trước khi bắt đầu implementation task tương ứng
- Resource icon/dimension nên hoàn tất trước khi layout hoặc activity consume chúng
- `activity_player.xml` phải có ID ổn định trước khi `PlayerActivity.kt` bind hoặc instrumentation tests assert các view đó
- Story chỉ được coi là xong khi independent test của story đó pass độc lập

### Parallel Opportunities

- T001 và T002 có thể chạy song song trong Phase 1
- T005 có thể chạy song song sau khi T003 định nghĩa xong region IDs
- Trong US1: T006 và T008 có thể chạy song song
- Trong US2: T010 và T012 có thể chạy song song
- Trong US3: T014 và T015 có thể chạy song song

---

## Parallel Example: User Story 1

```text
T006 [US1] Add first-render assertions for video, timeline, and transport regions in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
T008 [US1] Add transport vector assets in CxPlayer/app/src/main/res/drawable/ic_player_seek_back.xml, CxPlayer/app/src/main/res/drawable/ic_player_play.xml, CxPlayer/app/src/main/res/drawable/ic_player_pause.xml, CxPlayer/app/src/main/res/drawable/ic_player_seek_forward.xml, CxPlayer/app/src/main/res/drawable/ic_player_volume.xml, and CxPlayer/app/src/main/res/drawable/ic_player_settings.xml
```

## Parallel Example: User Story 2

```text
T010 [US2] Add assertions for top bar visibility, fallback title, and overflow availability in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
T012 [US2] Add top-bar vector assets in CxPlayer/app/src/main/res/drawable/ic_player_back.xml and CxPlayer/app/src/main/res/drawable/ic_player_overflow.xml
```

## Parallel Example: User Story 3

```text
T014 [US3] Add recreate and orientation assertions for full player chrome visibility in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
T015 [US3] Add chrome spacing and compact-height dimensions in CxPlayer/app/src/main/res/values/dimens.xml
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Hoàn thành US1 (T006-T009)
3. Chạy T019 và kiểm tra launch path local/HTTP theo `quickstart.md`
4. Demo màn hình player với bottom chrome đã ổn định trước khi mở rộng top bar và responsive behavior

### Incremental Delivery

1. Setup + Foundational → overlay skeleton và wiring nền tảng sẵn sàng
2. US1 → video + timeline + transport region hiển thị ổn định
3. US2 → top bar hoàn chỉnh với back/title/overflow
4. US3 → orientation/recreate/insets được khóa
5. Polish → regression và manual verification hoàn tất

### Parallel Team Strategy

1. Một người xử lý resource/setup (T001-T002) trong khi người khác chuẩn bị test helper (T005 sau T003)
2. Trong US1, một người làm icon assets (T008) song song với người viết assertions (T006)
3. Trong US2, một người làm top-bar icons (T012) song song với người viết assertions (T010)
4. Trong US3, một người làm dimens (T015) song song với người viết orientation assertions (T014)

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, và toàn bộ US1
- **Next**: US2 để hoàn thiện điều hướng và title fallback
- **Last**: US3 vì phụ thuộc toàn bộ chrome contract đã ổn định

---

## Notes

- Tổng số task: 20
- Task theo user story: US1 = 4, US2 = 4, US3 = 4
- Setup/Foundation/Polish: 8 task
- Parallel opportunities đã đánh dấu: 9 task
- Tất cả task đều dùng đúng checklist format với checkbox, Task ID tuần tự, marker `[P]` khi phù hợp, story label cho phase story, và file path rõ ràng