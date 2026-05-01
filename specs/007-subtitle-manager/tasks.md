# Tasks: Subtitle Manager

**Input**: Design documents from `/specs/007-subtitle-manager/`  
**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `contracts/subtitle-manager-contract.md`, `quickstart.md`

**Tests**: Bao gồm task test vì `plan.md`, `research.md`, `contracts/` và `quickstart.md` đều đã chốt unit coverage cho `SubtitleManager`, regression/smoke coverage cho playback screen, cùng compile/manual validation cho Media3 subtitle workflow.

**Organization**: Tasks được nhóm theo user story để mỗi story có thể triển khai và kiểm thử độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì khác file và không phụ thuộc task chưa hoàn thành
- **[Story]**: Ánh xạ tới user story tương ứng trong spec (`US1`, `US2`, `US3`)
- Mỗi task đều ghi rõ file path cần chạm

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị shell runtime, test fixture và resource labels cho subtitle feature trước khi chạm vào playback flow

- [X] T001 [P] Create the subtitle orchestration shell and runtime state placeholders in `CxPlayer/app/src/main/java/com/cxplayer/player/SubtitleManager.kt`
- [X] T002 [P] Create the subtitle unit-test fixture and fake player helpers in `CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt`
- [X] T003 [P] Add subtitle action labels and lightweight feedback strings in `CxPlayer/app/src/main/res/values/strings.xml`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Dựng shared seams cho player session, activity orchestration và smoke harness mà mọi user story đều phụ thuộc vào

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này xong

- [X] T004 Add internal player-session access needed by subtitle orchestration in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [X] T005 [P] Extend playback-session regression assertions for subtitle-safe state reuse in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- [X] T006 Add subtitle action hooks, lifecycle wiring, and session state placeholders in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T007 [P] Prepare subtitle-safe playback smoke hooks in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

**Checkpoint**: Subtitle feature có seam rõ ràng trong manager, activity và test harness để từng story có thể triển khai độc lập

---

## Phase 3: User Story 1 - Xem video kèm phụ đề ngoài ngay lập tức (Priority: P1) 🎯 MVP

**Goal**: Người dùng mở video local có subtitle cùng tên hoặc tự chọn một file subtitle ngoài hợp lệ và thấy subtitle xuất hiện ngay trong phiên xem hiện tại

**Independent Test**: Mở `video.mp4` có `video.srt` đặt cạnh hoặc nạp thủ công một file `.ass`/`.vtt`, rồi xác nhận subtitle xuất hiện mà video không restart từ đầu và playback controls vẫn hoạt động

### Tests for User Story 1

- [X] T008 [P] [US1] Add unit coverage for basename auto-detect, subtitle MIME mapping, and preserved playback position in `CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt`
- [X] T009 [P] [US1] Add playback smoke coverage for external subtitle attach stability in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 1

- [X] T010 [US1] Implement external subtitle attachment and playback-state preservation in `CxPlayer/app/src/main/java/com/cxplayer/player/SubtitleManager.kt`
- [X] T011 [US1] Implement local sibling subtitle auto-detect rules for `.srt`, `.ass`, `.ssa`, and `.vtt` in `CxPlayer/app/src/main/java/com/cxplayer/player/SubtitleManager.kt`
- [X] T012 [US1] Integrate playback-start auto-detect and manual external subtitle actions in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 1 hoàn chỉnh khi subtitle ngoài được auto-detect hoặc nạp tay thành công mà không làm gián đoạn phiên phát

---

## Phase 4: User Story 2 - Chọn đúng nguồn phụ đề cần xem (Priority: P2)

**Goal**: Người dùng chuyển được giữa embedded subtitle, external subtitle và trạng thái `Off` mà chỉ có một nguồn subtitle hoạt động tại một thời điểm

**Independent Test**: Phát video có nhiều subtitle source, chọn từng nguồn rồi tắt subtitle, và xác nhận nội dung hiển thị đổi đúng theo lựa chọn mới trong cùng phiên phát

### Tests for User Story 2

- [X] T013 [P] [US2] Add unit coverage for embedded subtitle discovery, track switching, and off-state mapping in `CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt`
- [X] T014 [P] [US2] Add playback smoke coverage for subtitle source switching and off behavior in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 2
- [X] T015 [US2] Implement embedded subtitle source enumeration and track switching in `CxPlayer/app/src/main/java/com/cxplayer/player/SubtitleManager.kt`
- [X] T016 [US2] Update subtitle action handlers to expose `Off` plus available sources in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`


**Checkpoint**: User Story 2 hoàn chỉnh khi user chuyển qua lại giữa embedded, external và `Off` mà không bị chồng subtitle hoặc mất playback state

---

## Phase 5: User Story 3 - Tùy chỉnh phụ đề để dễ đọc hơn (Priority: P3)

**Goal**: Người dùng đổi font size, bold, màu chữ và kiểu viền của subtitle ngay trên `PlayerView` trong phiên xem hiện tại

**Independent Test**: Bật một subtitle đang hiển thị, đổi lần lượt các thiết lập style, rồi xác nhận subtitle đổi ngay và video tiếp tục phát bình thường

### Tests for User Story 3

- [X] T017 [P] [US3] Add unit coverage for subtitle style mapping to `CaptionStyleCompat` and fixed text sizing in `CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt`
- [X] T018 [P] [US3] Add playback smoke coverage for runtime subtitle style updates in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 3

- [X] T019 [US3] Implement runtime subtitle style state and `PlayerView.subtitleView` updates in `CxPlayer/app/src/main/java/com/cxplayer/player/SubtitleManager.kt`
- [X] T020 [US3] Wire subtitle style actions and visible feedback in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 3 hoàn chỉnh khi subtitle style đổi ngay trong lúc phát và vẫn giữ readability trên nền sáng hoặc tối

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Khóa validation cuối cùng, dọn placeholder và xác nhận manual verification theo quickstart

- [X] T021 [P] Run unit and assemble validation from `specs/007-subtitle-manager/quickstart.md` against `CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt`, `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`, and `CxPlayer/app/build.gradle.kts`
- [ ] T022 Run androidTest compile and manual subtitle verification from `specs/007-subtitle-manager/quickstart.md` against `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- [X] T023 Clean up unused subtitle placeholders and duplicate state wiring in `CxPlayer/app/src/main/java/com/cxplayer/player/SubtitleManager.kt` and `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: Không phụ thuộc task nào khác
- **Phase 2 (Foundational)**: Phụ thuộc Phase 1 và chặn toàn bộ user story
- **Phase 3 (US1)**: Phụ thuộc Phase 2 và là MVP khuyến nghị
- **Phase 4 (US2)**: Phụ thuộc Phase 2; về mặt story có thể test độc lập, nhưng trên một code line duy nhất nên an toàn nhất là hoàn tất sau US1
- **Phase 5 (US3)**: Phụ thuộc Phase 2; có thể test độc lập nhưng thực tế nên chốt sau US1 và US2 vì cùng mở rộng `SubtitleManager` và `PlayerActivity`
- **Phase 6 (Polish)**: Phụ thuộc các story muốn bàn giao

### User Story Dependencies

- **US1 (P1)**: Có thể bắt đầu ngay sau Phase 2; không phụ thuộc story nào khác và là phạm vi MVP
- **US2 (P2)**: Có thể bắt đầu sau Phase 2; độc lập về hành vi nhưng chia sẻ cùng seam với US1 nên nên rebase trên external subtitle flow đã ổn định
- **US3 (P3)**: Có thể bắt đầu sau Phase 2; độc lập về hành vi nhưng hiệu quả nhất khi chạy sau khi US1 và US2 đã khóa xong source/state model

### Within Each User Story

- Test task của story nên được viết trước và fail trước khi implementation task tương ứng bắt đầu
- `SubtitleManager.kt` phải chốt state model trước khi `PlayerActivity.kt` nối action UI vào story đó
- Mỗi story chỉ được coi là xong khi independent test của story đó pass độc lập và outcome khớp `spec.md` cùng `quickstart.md`

### Parallel Opportunities

- T001, T002, và T003 có thể chạy song song trong Phase 1 vì chạm các file khác nhau
- T005 và T007 có thể chạy song song trong Phase 2 trong khi T004 hoặc T006 đang được triển khai
- T008 và T009 có thể chạy song song trong US1
- T013 và T014 có thể chạy song song trong US2
- T017 và T018 có thể chạy song song trong US3
- T021 có thể chạy song song với phần chuẩn bị manual verification của T022 sau khi code đã ổn định

---

## Parallel Example: User Story 1

```text
T008 [US1] Add unit coverage for basename auto-detect, subtitle MIME mapping, and preserved playback position in CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt
T009 [US1] Add playback smoke coverage for external subtitle attach stability in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 2

```text
T013 [US2] Add unit coverage for embedded subtitle discovery, track switching, and off-state mapping in CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt
T014 [US2] Add playback smoke coverage for subtitle source switching and off behavior in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 3

```text
T017 [US3] Add unit coverage for subtitle style mapping to CaptionStyleCompat and fixed text sizing in CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt
T018 [US3] Add playback smoke coverage for runtime subtitle style updates in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Hoàn thành US1 (T008-T012)
3. Chạy validation trong `specs/007-subtitle-manager/quickstart.md`
4. Demo flow auto-detect `video.srt` hoặc nạp tay một file `.ass`/`.vtt` trước khi chuyển sang story tiếp theo

### Incremental Delivery

1. Setup + Foundational → subtitle seam và test harness sẵn sàng
2. US1 → external subtitle load và auto-detect hoạt động trong app
3. US2 → embedded/off selection hoàn chỉnh mà không phá US1
4. US3 → style updates hoạt động ngay trong session hiện tại
5. Polish → compile, unit validation và manual subtitle matrix hoàn tất

### Parallel Team Strategy

1. Một người dựng `SubtitleManager.kt` shell và state model, người khác chuẩn bị unit/androidTest harness
2. Sau foundation, một người xử lý external subtitle flow của US1 trong khi người khác viết test cho US2 hoặc US3
3. Khi runtime state ổn định, validation và cleanup ở Phase 6 có thể được chuẩn bị song song với manual verification

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, và toàn bộ US1
- **Next**: US2 để khóa embedded/off selection
- **Last**: US3 vì đây là lớp readability polish dựa trên source/state model đã ổn định

---

## Notes

- Tổng số task: 23
- Task theo user story: US1 = 5, US2 = 4, US3 = 4
- Setup/Foundation/Polish: 10 task
- Parallel opportunities đã đánh dấu: 12 task
- `compileDebugAndroidTestKotlin` vẫn là sanity-check tối thiểu nếu chưa thể chạy full instrumentation trên thiết bị có sample subtitle phù hợp