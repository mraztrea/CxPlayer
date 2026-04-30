# Tasks: FFmpeg Integration

**Input**: Design documents from `/specs/006-ffmpeg-integration/`  
**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `contracts/ffmpeg-playback-contract.md`, `quickstart.md`

**Tests**: Bao gồm task test vì `plan.md` và `quickstart.md` đã chốt unit coverage cho playback wiring, compile validation cho Gradle integration, và manual verification cho codec sample pass hoặc fail.

**Organization**: Tasks được nhóm theo user story để mỗi story có thể triển khai và kiểm thử độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì khác file và không phụ thuộc task chưa hoàn thành
- **[Story]**: Ánh xạ tới user story tương ứng trong spec (`US1`, `US2`, `US3`)
- Mỗi task đều ghi rõ file path cần chạm

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị dependency và build wiring cho FFmpeg extension trước khi chạm vào playback code

- [ ] T001 [P] Add Media3 FFmpeg decoder alias to `CxPlayer/gradle/libs.versions.toml`
- [ ] T002 [P] Wire the FFmpeg decoder dependency into `CxPlayer/app/build.gradle.kts`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Dựng playback policy boundary và test harness mà mọi user story đều phụ thuộc vào

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này xong

- [X] T003 Create the custom renderer policy shell in `CxPlayer/app/src/main/java/com/cxplayer/player/CxRenderersFactory.kt`
- [X] T004 [P] Expand shared player-construction assertions in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- [X] T005 [P] Prepare playback smoke-test hooks for session launch and reuse in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

**Checkpoint**: FFmpeg integration có seam rõ ràng trong playback layer và test harness sẵn sàng cho từng story

---

## Phase 3: User Story 1 - Mở được phim có codec nâng cao (Priority: P1) 🎯 MVP

**Goal**: Người dùng mở được sample AC3, EAC3, DTS, DTS-HD, TrueHD, FLAC hoặc H.264/H.265 cần fallback mà không phải đổi ứng dụng hay chọn tay decoder

**Independent Test**: Mở sample media mục tiêu và xác nhận player bắt đầu phát với cả hình và tiếng trong cùng ứng dụng mà không xuất hiện bước cấu hình mới

### Tests for User Story 1

- [X] T006 [P] [US1] Add unit coverage for preferred extension renderer mode and preserved seek increments in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`

### Implementation for User Story 1

- [X] T007 [US1] Finalize preferred FFmpeg renderer mode and decoder fallback in `CxPlayer/app/src/main/java/com/cxplayer/player/CxRenderersFactory.kt`
- [X] T008 [US1] Integrate the custom renderers factory into player session creation in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [X] T009 [US1] Lock advanced-codec sample pass criteria in `specs/006-ffmpeg-integration/contracts/ffmpeg-playback-contract.md` and `specs/006-ffmpeg-integration/quickstart.md`

**Checkpoint**: User Story 1 hoàn chỉnh khi sample codec mục tiêu phát được trong app với decoder policy mới và không cần user intervention

---

## Phase 4: User Story 2 - Không làm hỏng các file đang phát tốt (Priority: P2)

**Goal**: Những file MP4 hoặc MKV vốn đang phát tốt tiếp tục hoạt động ổn định sau khi bật FFmpeg integration

**Independent Test**: Phát regression sample đang pass, thực hiện play, pause, seek forward và seek back, rồi xác nhận user flow và playback controls vẫn giữ nguyên

### Tests for User Story 2

- [X] T010 [P] [US2] Add regression coverage for load, play, pause, seek, and snapshot behavior in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- [X] T011 [P] [US2] Add playback smoke coverage for unchanged player launch and controls in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 2

- [X] T012 [US2] Preserve current transport increments and session behavior while wiring FFmpeg integration in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [X] T013 [US2] Record regression sample expectations for existing MP4 or MKV playback in `specs/006-ffmpeg-integration/quickstart.md`

**Checkpoint**: User Story 2 hoàn chỉnh khi regression sample vẫn phát được và các control cơ bản không thay đổi theo cách người dùng nhận thấy

---

## Phase 5: User Story 3 - Thất bại có kiểm soát khi file vẫn ngoài phạm vi (Priority: P3)

**Goal**: Sample hỏng hoặc ngoài phạm vi decoder policy thất bại ổn định, không crash, không treo loading vô thời hạn và không làm hỏng lần mở file kế tiếp

**Independent Test**: Mở sample hỏng hoặc ngoài phạm vi, xác nhận player đi vào trạng thái lỗi ổn định rồi tiếp tục mở sample khác thành công trong cùng activity

### Tests for User Story 3

- [X] T014 [P] [US3] Add unit coverage for error-state reporting and session reuse after failed playback in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- [X] T015 [P] [US3] Add smoke coverage for unsupported-sample recovery in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

### Implementation for User Story 3

- [X] T016 [US3] Harden error-state refresh and reusable session handling for unsupported media in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [X] T017 [US3] Keep the playback screen reusable after failed launch handling in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 3 hoàn chỉnh khi failure path ổn định và người dùng vẫn có thể quay lại hoặc mở file khác ngay sau một lần phát thất bại

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Khóa validation cuối cùng và dọn phần phụ trợ ảnh hưởng nhiều story

- [X] T018 [P] Run unit and assemble validation referenced by `specs/006-ffmpeg-integration/quickstart.md` against `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt` and `CxPlayer/app/build.gradle.kts`
- [ ] T019 Run androidTest compile and manual codec matrix verification from `specs/006-ffmpeg-integration/quickstart.md`
- [ ] T020 Clean up unused imports, constants, and temporary playback wiring in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt` and `CxPlayer/app/src/main/java/com/cxplayer/player/CxRenderersFactory.kt`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: Không phụ thuộc task nào khác
- **Phase 2 (Foundational)**: Phụ thuộc Phase 1 và chặn toàn bộ user story
- **Phase 3 (US1)**: Phụ thuộc Phase 2 và là MVP khuyến nghị
- **Phase 4 (US2)**: Phụ thuộc Phase 2; nên đi sau US1 để regression coverage bám đúng decoder policy đã hoàn thiện
- **Phase 5 (US3)**: Phụ thuộc Phase 2; an toàn nhất là thực hiện sau US1 và US2 vì error path cần bám vào playback wiring cuối cùng
- **Phase 6 (Polish)**: Phụ thuộc các story muốn bàn giao

### User Story Dependencies

- **US1 (P1)**: Có thể bắt đầu ngay sau Phase 2; không phụ thuộc story nào khác
- **US2 (P2)**: Có thể bắt đầu sau Phase 2 nhưng nên khóa sau US1 để regression test bám đúng renderer policy cuối cùng
- **US3 (P3)**: Có thể bắt đầu sau Phase 2 nhưng tốt nhất hoàn tất sau US1 và US2 vì session reuse sau lỗi phải xác thực trên wiring ổn định

### Within Each User Story

- Test task của story nên được viết trước và fail trước khi implementation task tương ứng bắt đầu
- `CxRenderersFactory.kt` phải hoàn tất policy trước khi `CxPlayerManager.kt` dùng policy đó trong player builder
- Story chỉ được coi là xong khi independent test của story đó pass độc lập và sample verification của story đó khớp `quickstart.md`

### Parallel Opportunities

- T001 và T002 có thể thực hiện song song vì chạm hai file Gradle khác nhau
- T004 và T005 có thể chạy song song trong Phase 2
- T010 và T011 có thể chạy song song trong US2
- T014 và T015 có thể chạy song song trong US3
- T018 có thể chạy song song với việc chuẩn bị manual verification ở T019 sau khi code đã ổn định

---

## Parallel Example: User Story 2

```text
T010 [US2] Add regression coverage for load, play, pause, seek, and snapshot behavior in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
T011 [US2] Add playback smoke coverage for unchanged player launch and controls in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

## Parallel Example: User Story 3

```text
T014 [US3] Add unit coverage for error-state reporting and session reuse after failed playback in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
T015 [US3] Add smoke coverage for unsupported-sample recovery in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Hoàn thành US1 (T006-T009)
3. Chạy validation trong `specs/006-ffmpeg-integration/quickstart.md`
4. Demo sample AC3 hoặc DTS và sample H.265 fallback trước khi chuyển sang regression hoặc failure-path hardening

### Incremental Delivery

1. Setup + Foundational → dependency, renderer policy shell và test harness sẵn sàng
2. US1 → playback codec nâng cao hoạt động trong app
3. US2 → regression sample giữ nguyên trải nghiệm cũ
4. US3 → failure path ổn định và activity tiếp tục dùng được
5. Polish → compile, unit validation và manual codec matrix hoàn tất

### Parallel Team Strategy

1. Một người xử lý Gradle và `CxRenderersFactory.kt` trong khi người khác chuẩn bị test harness Phase 2
2. Sau foundation, một người khóa advanced-codec policy ở US1 còn người khác chuẩn bị regression tests cho US2
3. Khi wiring cuối đã ổn định, failure-path tests của US3 có thể được phát triển song song với compile/manual validation chuẩn bị cho Phase 6

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, và toàn bộ US1
- **Next**: US2 để khóa regression cho những file đang phát tốt
- **Last**: US3 vì đây là lớp hardening cho failure path và session reuse

---

## Notes

- Tổng số task: 20
- Task theo user story: US1 = 4, US2 = 4, US3 = 4
- Setup/Foundation/Polish: 8 task
- Parallel opportunities đã đánh dấu: 10 task
- `connectedDebugAndroidTest` có thể vẫn bị chặn bởi prompt cài test app trên thiết bị thật, nên `compileDebugAndroidTestKotlin` vẫn là sanity-check tối thiểu nếu chưa thể chạy full instrumentation
