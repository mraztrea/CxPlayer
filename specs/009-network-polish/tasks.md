# Tasks: Network Polish

**Input**: Design documents from `/specs/009-network-polish/`  
**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `contracts/network-playback-contract.md`, `quickstart.md`

**Tests**: Bao gồm task test vì `plan.md`, `research.md`, `contracts/` và `quickstart.md` đã chốt rõ unit coverage cho source routing, wake/load policy, SMB browse contract và instrumentation smoke cho PiP/background/orientation continuity.

**Organization**: Tasks được nhóm theo user story để mỗi story có thể triển khai và kiểm thử độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song vì chạm file khác nhau và không phụ thuộc task chưa hoàn thành
- **[Story]**: Ánh xạ tới user story tương ứng trong spec (`US1`, `US2`, `US3`)
- Mỗi task đều ghi rõ file path cần chạm

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Chuẩn bị dependency, test shell và đường dẫn build cho network playback trước khi chạm orchestration chính

- [X] T001 Add Media3 OkHttp and SMBJ version catalog entries in `CxPlayer/gradle/libs.versions.toml`
- [X] T002 Update app dependencies for `media3-datasource-okhttp`, OkHttp, and SMBJ in `CxPlayer/app/build.gradle.kts`
- [X] T003 [P] Create host-side test shells for source routing and SMB seams in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`, `CxPlayer/app/src/test/java/com/cxplayer/player/PlaybackRequestParserTest.kt`, and `CxPlayer/app/src/test/java/com/cxplayer/player/SmbBrowserContractTest.kt`
- [ ] T004 [P] Prepare instrumentation smoke test hooks for PiP, background audio, and orientation scenarios in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Dựng shared seams cho source classification, load control và datasource routing mà mọi user story đều dùng

**⚠️ CRITICAL**: Không bắt đầu user story nào trước khi phase này xong

- [X] T005 Extend playback source classification and internal SMB launch parsing in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T006 [P] Create the LAN-oriented buffer policy in `CxPlayer/app/src/main/java/com/cxplayer/player/CxLoadControl.kt`
- [X] T007 [P] Create the OkHttp-backed datasource bridge in `CxPlayer/app/src/main/java/com/cxplayer/data/datasource/CxDataSourceFactory.kt`
- [X] T008 [P] Create the source resolver shell in `CxPlayer/app/src/main/java/com/cxplayer/player/CxMediaSourceFactory.kt`
- [X] T009 Integrate load-control and datasource-routing seams into `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`

**Checkpoint**: Playback stack đã có source resolver, load control và parser seam đủ ổn để từng user story được triển khai độc lập

---

## Phase 3: User Story 1 - Phát video mạng nội bộ ổn định (Priority: P1) 🎯 MVP

**Goal**: Người dùng phát ổn định video HTTP/LAN và duyệt SMB để chọn video phát trực tiếp mà không cần tải local trước

**Independent Test**: Mở một video HTTP trên LAN hoặc đăng nhập SMB hợp lệ, duyệt tới file video rồi phát trực tiếp; xác nhận nội dung bắt đầu phát nhanh, tiếp tục ổn định và lỗi auth/path được báo rõ ràng

### Tests for User Story 1

- [X] T010 [P] [US1] Add host-side coverage for HTTP or SMB source routing and wake or buffer policy selection in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt` and `CxPlayer/app/src/test/java/com/cxplayer/player/PlaybackRequestParserTest.kt`
- [X] T011 [P] [US1] Add SMB browse contract coverage for authentication, directory listing, and playable entry mapping in `CxPlayer/app/src/test/java/com/cxplayer/player/SmbBrowserContractTest.kt`

### Implementation for User Story 1

- [X] T012 [P] [US1] Implement read-only SMB browse and authentication client in `CxPlayer/app/src/main/java/com/cxplayer/network/SmbBrowser.kt`
- [X] T013 [P] [US1] Implement SMB streaming datasource in `CxPlayer/app/src/main/java/com/cxplayer/data/datasource/SmbDataSource.kt`
- [X] T014 [US1] Implement HTTP, local, and SMB media-source routing in `CxPlayer/app/src/main/java/com/cxplayer/player/CxMediaSourceFactory.kt` and `CxPlayer/app/src/main/java/com/cxplayer/data/datasource/CxDataSourceFactory.kt`
- [X] T015 [US1] Add internal SMB playback request creation and error messaging flow in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [X] T016 [US1] Add minimal SMB browser UI and browse-to-play wiring in `CxPlayer/app/src/main/java/com/cxplayer/ui/controls/NetworkBrowserDialog.kt` and `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 1 hoàn chỉnh khi app phát ổn định HTTP/LAN, mở được SMB browser, và phát trực tiếp file SMB đã chọn với lỗi rõ ràng khi auth hoặc path thất bại

---

## Phase 4: User Story 2 - Tiếp tục xem hoặc nghe khi rời ứng dụng (Priority: P2)

**Goal**: Người dùng rời app mà video vẫn tiếp tục trong PiP hoặc audio vẫn tiếp tục ở nền, rồi quay lại màn hình phát mà không mất session

**Independent Test**: Phát một video, nhấn Home để vào PiP trên thiết bị hỗ trợ hoặc tắt màn hình để giữ audio nền; quay lại app và xác nhận vị trí phát với trạng thái phát được giữ nguyên

### Tests for User Story 2

- [ ] T017 [P] [US2] Add instrumentation smoke coverage for PiP entry, foreground return, and background-audio continuity in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- [ ] T018 [P] [US2] Add host-side coverage for session attach-detach continuity and playback snapshot retention in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`

### Implementation for User Story 2

- [ ] T019 [P] [US2] Create the service-backed playback host in `CxPlayer/app/src/main/java/com/cxplayer/player/PlaybackService.kt`
- [ ] T020 [US2] Refactor shared player session ownership and activity attach-detach flow in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- [ ] T021 [US2] Register the media playback service and PiP-capable activity settings in `CxPlayer/app/src/main/AndroidManifest.xml`
- [ ] T022 [US2] Implement PiP lifecycle guards and background-audio continuity handling in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 2 hoàn chỉnh khi playback session sống qua foreground, PiP và background audio mà không bị `onStop` release phá continuity

---

## Phase 5: User Story 3 - Giữ hành vi phát phù hợp với ngữ cảnh thiết bị (Priority: P3)

**Goal**: App giữ wake policy phù hợp cho source mạng và cho phép user khóa hoặc trả về auto orientation mà không mất vị trí phát

**Independent Test**: Phát nội dung mạng, đổi orientation lock qua các trạng thái rồi recreate activity; xác nhận requested orientation, wake behavior và playback snapshot vẫn đúng, đồng thời thông báo rõ khi thiết bị không hỗ trợ PiP

### Tests for User Story 3

- [ ] T023 [P] [US3] Add instrumentation smoke coverage for orientation-lock persistence and unsupported-PiP feedback in `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- [ ] T024 [P] [US3] Add host-side coverage for source-specific wake-mode transitions and orientation preference state in `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`

### Implementation for User Story 3

- [ ] T025 [P] [US3] Add orientation preference state and requested-orientation helpers in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [ ] T026 [US3] Apply source-specific wake-mode updates and network-idle continuity policy in `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt` and `CxPlayer/app/src/main/java/com/cxplayer/player/CxLoadControl.kt`
- [ ] T027 [US3] Add user-facing orientation controls and unsupported-capability messages in `CxPlayer/app/src/main/res/values/strings.xml` and `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`

**Checkpoint**: User Story 3 hoàn chỉnh khi orientation lock hoặc auto-rotate giữ đúng qua recreate, wake policy phản ánh loại source, và UX báo rõ khi PiP không khả dụng

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Khóa validation cuối, chạy quickstart matrix và dọn phần wiring chạm nhiều story

- [ ] T028 [P] Run the host-side validation commands documented in `specs/009-network-polish/quickstart.md`
- [ ] T029 Run the compile and manual LAN, SMB, PiP, background-audio, and orientation verification checklist in `specs/009-network-polish/quickstart.md`
- [ ] T030 Clean up cross-story playback wiring drift in `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`, `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`, and `CxPlayer/app/src/main/AndroidManifest.xml`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: Không phụ thuộc task nào khác
- **Phase 2 (Foundational)**: Phụ thuộc Phase 1 và chặn toàn bộ user story
- **Phase 3 (US1)**: Phụ thuộc Phase 2 và là MVP khuyến nghị
- **Phase 4 (US2)**: Phụ thuộc Phase 2; về mặt outcome có thể test độc lập nhưng an toàn nhất là rebase trên routing seam của US1 vì cùng chạm `CxPlayerManager.kt` và `PlayerActivity.kt`
- **Phase 5 (US3)**: Phụ thuộc Phase 2; có thể test độc lập nhưng nên thực hiện sau US2 vì cùng mở rộng playback continuity và activity lifecycle state
- **Phase 6 (Polish)**: Phụ thuộc các story muốn bàn giao

### User Story Dependencies

- **US1 (P1)**: Có thể bắt đầu ngay sau Phase 2; không phụ thuộc user story khác và là phạm vi MVP
- **US2 (P2)**: Có thể bắt đầu sau Phase 2; outcome độc lập nhưng cần dùng lại shared player/session seam nên thực tế nên chốt sau US1
- **US3 (P3)**: Có thể bắt đầu sau Phase 2; outcome độc lập nhưng dễ merge nhất sau US2 vì cùng chạm lifecycle playback của activity và manager

### Within Each User Story

- Test task của story nên được viết trước và fail trước khi implementation task tương ứng bắt đầu
- Parser or manager state phải xong trước khi UI flow hoặc service continuity của story đó được nối đầy đủ
- Implementation task cuối của từng story phải hoàn tất independent test trong `spec.md` và `quickstart.md` trước khi chuyển sang story tiếp theo
- Story chỉ được coi là xong khi outcome user-facing hoạt động mà không làm regression local playback flow đã có

### Parallel Opportunities

- T003 và T004 có thể chạy song song trong Phase 1
- T006, T007, và T008 có thể chạy song song trong Phase 2 trước khi T009 nối vào manager
- T010 và T011 có thể chạy song song trong US1
- T012 và T013 có thể chạy song song trong US1
- T017 và T018 có thể chạy song song trong US2
- T023 và T024 có thể chạy song song trong US3
- T028 có thể chạy song song với việc chuẩn bị manual verification cho T029 sau khi code đã ổn định

---

## Parallel Example: User Story 1

```text
T010 [US1] Add host-side coverage for HTTP or SMB source routing and wake or buffer policy selection in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt and CxPlayer/app/src/test/java/com/cxplayer/player/PlaybackRequestParserTest.kt
T011 [US1] Add SMB browse contract coverage for authentication, directory listing, and playable entry mapping in CxPlayer/app/src/test/java/com/cxplayer/player/SmbBrowserContractTest.kt
T012 [US1] Implement read-only SMB browse and authentication client in CxPlayer/app/src/main/java/com/cxplayer/network/SmbBrowser.kt
T013 [US1] Implement SMB streaming datasource in CxPlayer/app/src/main/java/com/cxplayer/data/datasource/SmbDataSource.kt
```

## Parallel Example: User Story 2

```text
T017 [US2] Add instrumentation smoke coverage for PiP entry, foreground return, and background-audio continuity in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
T018 [US2] Add host-side coverage for session attach-detach continuity and playback snapshot retention in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
T019 [US2] Create the service-backed playback host in CxPlayer/app/src/main/java/com/cxplayer/player/PlaybackService.kt
```

## Parallel Example: User Story 3

```text
T023 [US3] Add instrumentation smoke coverage for orientation-lock persistence and unsupported-PiP feedback in CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt
T024 [US3] Add host-side coverage for source-specific wake-mode transitions and orientation preference state in CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt
T025 [US3] Add orientation preference state and requested-orientation helpers in CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Hoàn thành Phase 1 và Phase 2
2. Hoàn thành US1 (T010-T016)
3. Chạy validation trong `specs/009-network-polish/quickstart.md`
4. Demo flow HTTP/LAN playback và SMB browse-to-play trước khi chuyển sang story tiếp theo

### Incremental Delivery

1. Setup + Foundational → source routing, datasource seam và test harness sẵn sàng
2. US1 → LAN or SMB playback hoạt động ổn định trong app
3. US2 → PiP và background audio continuity hoàn chỉnh mà không phá US1
4. US3 → orientation và wake-mode polish hoàn chỉnh
5. Polish → compile, unit validation và manual verification matrix hoàn tất

### Parallel Team Strategy

1. Một người chuẩn bị dependency and tests shell trong khi người khác dựng `CxLoadControl.kt` và `CxDataSourceFactory.kt`
2. Sau foundation, một người làm SMB browse or datasource flow của US1 trong khi người khác viết host-side coverage của US1
3. Khi routing seam đã ổn định, một người có thể làm `PlaybackService.kt` cho US2 trong khi người khác chuẩn bị instrumentation smoke cho PiP and background continuity
4. US3 có thể được chuẩn bị song song bằng test coverage và orientation helper state sau khi shared service lifecycle đã rõ

### Suggested MVP Scope

- **MVP**: Phase 1, Phase 2, và toàn bộ US1
- **Next**: US2 để khóa continuity khi app rời foreground
- **Last**: US3 vì đây là lớp device-context polish dựa trên playback continuity đã ổn định

---

## Notes

- Tổng số task: 30
- Task theo user story: US1 = 7, US2 = 6, US3 = 5
- Setup or Foundation or Polish: 12 task
- Parallel opportunities đã đánh dấu: 16 task
- Mọi task implementation đều theo đúng checklist format `- [ ] Txxx ... in <file path>` để có thể thực thi ngay bởi một coding agent