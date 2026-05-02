# Tasks: AI Subtitle Generation

**Input**: Design documents from `specs/010-ai-subtitle-generation/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/

**Tests**: Không yêu cầu test tasks trong spec — bỏ qua test phases.

**Organization**: Tasks grouped by user story. Mỗi story có thể triển khai và test độc lập.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Có thể chạy song song (khác file, không dependency)
- **[Story]**: US1, US2, US3, US4

## Path Conventions

- **Android app**: `CxPlayer/app/src/main/java/com/cxplayer/`
- **Resources**: `CxPlayer/app/src/main/res/`
- **Build**: `CxPlayer/app/build.gradle.kts`

---

## Phase 1: Setup

**Purpose**: Thêm dependencies và tạo cấu trúc thư mục cho AI subtitle feature

- [ ] T001 Thêm Room DB dependencies vào `CxPlayer/app/build.gradle.kts` (room-runtime, room-ktx, room-compiler KSP)
- [ ] T002 [P] Tạo thư mục `CxPlayer/app/src/main/java/com/cxplayer/subtitle/`
- [ ] T003 [P] Tạo thư mục `CxPlayer/app/src/main/java/com/cxplayer/data/db/`
- [ ] T004 [P] Tạo thư mục `CxPlayer/app/src/main/java/com/cxplayer/data/model/`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Data models và Room DB dùng chung cho tất cả user stories

**⚠️ CRITICAL**: Không thể bắt đầu user story nào nếu chưa hoàn thành phase này

- [ ] T005 [P] Tạo `SubtitleEvent` sealed class trong `CxPlayer/app/src/main/java/com/cxplayer/data/model/SubtitleEvent.kt` — gồm Original(text, lang), Translation(text), Provisional(text)
- [ ] T006 [P] Tạo `SrtEntry` data class trong `CxPlayer/app/src/main/java/com/cxplayer/data/model/SrtEntry.kt` — gồm index, startMs, endMs, text
- [ ] T007 [P] Tạo `SonioxConfig` data class trong `CxPlayer/app/src/main/java/com/cxplayer/data/model/SonioxConfig.kt` — gồm apiKey, sourceLanguage, targetLanguage, translationTerms
- [ ] T008 [P] Tạo `SubtitleDisplayMode` enum trong `CxPlayer/app/src/main/java/com/cxplayer/data/model/SubtitleDisplayMode.kt` — ORIGINAL_ONLY, TRANSLATION_ONLY, BOTH
- [ ] T009 Tạo `CachedSubtitleEntity` Room entity trong `CxPlayer/app/src/main/java/com/cxplayer/data/db/CachedSubtitleEntity.kt` — gồm id, videoUri, videoHash, language, targetLanguage, createdAt, entries (JSON)
- [ ] T010 Tạo `SubtitleDao` Room DAO trong `CxPlayer/app/src/main/java/com/cxplayer/data/db/SubtitleDao.kt` — query/insert/delete by videoUri
- [ ] T011 Tạo `AppDatabase` Room database trong `CxPlayer/app/src/main/java/com/cxplayer/data/db/AppDatabase.kt` — entities=[CachedSubtitleEntity], Hilt module provide singleton

**Checkpoint**: Data models và database sẵn sàng — có thể bắt đầu user stories

---

## Phase 3: User Story 1 — Tạo phụ đề tự động khi xem video (Priority: P1) 🎯 MVP

**Goal**: Người dùng nhấn nút 🤖, hệ thống trích xuất audio, gửi tới Soniox STT, hiển thị phụ đề real-time.

**Independent Test**: Mở video có tiếng nói → nhấn 🤖 → phụ đề xuất hiện real-time trên overlay trong vòng 3 giây.

### Implementation for User Story 1

- [ ] T012 [US1] Tạo `CxAudioProcessor` trong `CxPlayer/app/src/main/java/com/cxplayer/player/CxAudioProcessor.kt` — extends BaseAudioProcessor, resample inputBuffer sang 16kHz mono PCM, gọi onPcmData callback, pass-through audio nguyên bản
- [ ] T013 [US1] Sửa `CxRenderersFactory` trong `CxPlayer/app/src/main/java/com/cxplayer/player/CxRenderersFactory.kt` — inject CxAudioProcessor vào audio renderer pipeline
- [ ] T014 [US1] Tạo `SonioxClient` trong `CxPlayer/app/src/main/java/com/cxplayer/subtitle/SonioxClient.kt` — OkHttp WebSocket connect tới `wss://stt-rt.soniox.com/transcribe-websocket`, gửi config JSON, sendAudio(ByteArray), parse response tokens sang SubtitleEvent, emit qua SharedFlow
- [ ] T015 [US1] Thêm session management vào `SonioxClient` — timer reset mỗi 3 phút (make-before-break), keepalive `{"type":"keepalive"}` mỗi 15s, context carryover 500 ký tự
- [ ] T016 [US1] Thêm auto-reconnect vào `SonioxClient` — tối đa 3 lần, delay tăng dần (2s, 4s, 6s), emit ConnectionState (IDLE/CONNECTING/ACTIVE/ERROR/RECONNECTING/FAILED)
- [ ] T017 [US1] Tạo `AiSubtitleManager` trong `CxPlayer/app/src/main/java/com/cxplayer/subtitle/AiSubtitleManager.kt` — orchestrate CxAudioProcessor → SonioxClient → SubtitleEvent flow, quản lý start/stop lifecycle, thu thập SrtEntry từ finalized tokens
- [ ] T018 [US1] Thêm nút 🤖 AI Subtitle vào layout `CxPlayer/app/src/main/res/layout/activity_player.xml` — ImageButton trên toolbar, icon robot, toggle visible
- [ ] T019 [US1] Thêm subtitle overlay cho AI subtitle vào layout `CxPlayer/app/src/main/res/layout/activity_player.xml` — TextView/container hiển thị phụ đề AI phía dưới PlayerView
- [ ] T020 [US1] Sửa `PlayerActivity` trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` — xử lý click nút 🤖 toggle AI subtitle, hiển thị connecting indicator, render SubtitleEvent lên overlay, ẩn/hiện khi pause/resume
- [ ] T021 [US1] Thêm cấu hình API key Soniox — dialog nhập API key lần đầu, lưu vào SharedPreferences, validate trước khi kết nối

**Checkpoint**: User Story 1 hoàn chỉnh — bật 🤖 → phụ đề gốc xuất hiện real-time

---

## Phase 4: User Story 2 — Dịch phụ đề + chế độ hiển thị (Priority: P2)

**Goal**: Hiển thị bản dịch song song với phụ đề gốc, cho phép chọn chế độ hiển thị (chỉ gốc / chỉ dịch / cả hai).

**Independent Test**: Mở video tiếng Anh → bật AI subtitle → chuyển đổi 3 chế độ hiển thị → phụ đề thay đổi tương ứng.

### Implementation for User Story 2

- [ ] T022 [US2] Cập nhật subtitle overlay trong `activity_player.xml` — hỗ trợ hiển thị 2 dòng (original + translation) hoặc 1 dòng tùy chế độ
- [ ] T023 [US2] Cập nhật `PlayerActivity` — thêm menu/popup chọn SubtitleDisplayMode (Chỉ phụ đề gốc / Chỉ bản dịch / Cả hai), lọc SubtitleEvent theo displayMode trước khi render
- [ ] T024 [US2] Cập nhật `AiSubtitleManager` — thêm displayMode StateFlow, setDisplayMode(), filter SubtitleEvent theo mode hiện tại

**Checkpoint**: User Story 2 hoàn chỉnh — dịch thuật hoạt động, 3 chế độ hiển thị chuyển đổi mượt mà

---

## Phase 5: User Story 3 — Xuất phụ đề ra file SRT (Priority: P3)

**Goal**: Khi tắt AI subtitle, hỏi người dùng export SRT, lưu file chuẩn SRT.

**Independent Test**: Xem video ≥1 phút với AI subtitle → tắt → chọn Export → file SRT tạo thành công, mở bằng text editor thấy đúng format.

### Implementation for User Story 3

- [ ] T025 [US3] Tạo `SrtExporter` trong `CxPlayer/app/src/main/java/com/cxplayer/subtitle/SrtExporter.kt` — write(List<SrtEntry>, File), formatTime(ms) → "HH:MM:SS,mmm", xuất file SRT chuẩn
- [ ] T026 [US3] Cập nhật `PlayerActivity` — khi tắt AI subtitle và có dữ liệu, hiện AlertDialog "Xuất file SRT?" → gọi SrtExporter.write() → toast xác nhận, nếu không có dữ liệu thì bỏ qua

**Checkpoint**: User Story 3 hoàn chỉnh — xuất SRT hoạt động, file đúng chuẩn

---

## Phase 6: User Story 4 — Tải phụ đề từ bộ nhớ đệm (Priority: P4)

**Goal**: Video đã xem với AI subtitle trước đó sẽ tải phụ đề từ cache, không gọi API.

**Independent Test**: Xem video lần đầu → đóng → mở lại bật AI subtitle → phụ đề hiển thị ngay từ cache.

### Implementation for User Story 4

- [ ] T027 [US4] Tạo `SubtitleCacheManager` trong `CxPlayer/app/src/main/java/com/cxplayer/subtitle/SubtitleCacheManager.kt` — getCachedSubtitle(videoUri), saveSubtitle(), deleteCache(), hasCache(), sử dụng SubtitleDao
- [ ] T028 [US4] Cập nhật `AiSubtitleManager` — khi start(), kiểm tra cache trước, nếu có thì emit từ cache thay vì kết nối API; khi stop() thành công thì save cache
- [ ] T029 [US4] Cập nhật `PlayerActivity` — khi bật AI subtitle cho video đã có cache, hiện tùy chọn "Dùng cache" hoặc "Tạo mới"

**Checkpoint**: User Story 4 hoàn chỉnh — cache hoạt động, tiết kiệm API call

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Xử lý lỗi toàn diện, cải thiện UX

- [ ] T030 [P] Thêm error handling toàn diện vào `SonioxClient` — xử lý API key invalid (toast rõ ràng), rate limit, network error, hiển thị thông báo phù hợp cho từng loại lỗi
- [ ] T031 [P] Thêm connecting/reconnecting indicators vào `PlayerActivity` — hiển thị trạng thái "Đang kết nối...", "Đang kết nối lại..." trên overlay khi ConnectionState thay đổi
- [ ] T032 Xử lý edge case chuyển video khi AI subtitle đang bật — đóng kết nối cũ, reset state, mở kết nối mới cho video mới trong `AiSubtitleManager`
- [ ] T033 Cập nhật changelog trong `MainActivity.kt` dòng 36 — `[FEATURE]: AI Subtitle Generation - 2026-05-01`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: Không dependency — bắt đầu ngay
- **Foundational (Phase 2)**: Phụ thuộc Phase 1 — BLOCKS tất cả user stories
- **User Story 1 (Phase 3)**: Phụ thuộc Phase 2 — MVP
- **User Story 2 (Phase 4)**: Phụ thuộc Phase 3 (cần SonioxClient + overlay đã có)
- **User Story 3 (Phase 5)**: Phụ thuộc Phase 3 (cần SrtEntry data từ AiSubtitleManager)
- **User Story 4 (Phase 6)**: Phụ thuộc Phase 2 (cần Room DB) + Phase 3 (cần AiSubtitleManager)
- **Polish (Phase 7)**: Phụ thuộc Phase 3 trở lên

### User Story Dependencies

- **US1 (P1)**: Độc lập — bắt đầu ngay sau Foundational
- **US2 (P2)**: Phụ thuộc US1 (cần overlay + SonioxClient đã hoạt động)
- **US3 (P3)**: Phụ thuộc US1 (cần SrtEntry collected từ AiSubtitleManager)
- **US4 (P4)**: Phụ thuộc US1 (cần AiSubtitleManager) — có thể song song với US2/US3

### Within Each User Story

- Models trước services
- Services trước UI integration
- Core implementation trước polish

### Parallel Opportunities

- T002, T003, T004 (tạo thư mục) có thể chạy song song
- T005, T006, T007, T008 (data models) có thể chạy song song
- US3 (SRT export) và US4 (cache) có thể chạy song song sau khi US1 hoàn thành
- T030, T031 (polish) có thể chạy song song

---

## Parallel Example: Phase 2 (Foundational)

```text
# Launch all data models together:
Task T005: "Tạo SubtitleEvent sealed class"
Task T006: "Tạo SrtEntry data class"
Task T007: "Tạo SonioxConfig data class"
Task T008: "Tạo SubtitleDisplayMode enum"

# Then Room DB (depends on models):
Task T009: "Tạo CachedSubtitleEntity"
Task T010: "Tạo SubtitleDao"
Task T011: "Tạo AppDatabase"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (T001-T004)
2. Complete Phase 2: Foundational (T005-T011)
3. Complete Phase 3: User Story 1 (T012-T021)
4. **STOP and VALIDATE**: Bật 🤖 → phụ đề xuất hiện real-time?
5. Demo nếu sẵn sàng

### Incremental Delivery

1. Setup + Foundational → Foundation ready
2. Add US1 → Test → Demo (MVP! Phụ đề gốc real-time)
3. Add US2 → Test → Demo (Dịch thuật + chế độ hiển thị)
4. Add US3 → Test → Demo (Xuất SRT)
5. Add US4 → Test → Demo (Cache tiết kiệm API)
6. Polish → Release

---

## Notes

- [P] tasks = khác file, không dependency
- [Story] label map task tới user story cụ thể
- Commit sau mỗi task hoặc nhóm logic
- Dừng ở bất kỳ checkpoint nào để validate story độc lập
- Tránh: task mơ hồ, conflict cùng file, cross-story dependencies phá vỡ tính độc lập
