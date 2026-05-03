# Tasks: Transport Row Redesign

## Format: `[ID] [P?] [Story] Description`

- **[P]** = Parallelizable (can run concurrently with other [P] tasks in same phase)
- **[USn]** = Maps to User Story n from spec.md

## Path Conventions

- Layout: `CxPlayer/app/src/main/res/layout/activity_player.xml`
- Kotlin: `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- Dimens: `CxPlayer/app/src/main/res/values/dimens.xml`
- Strings: `CxPlayer/app/src/main/res/values/strings.xml`
- Drawables: `CxPlayer/app/src/main/res/drawable/`

---

## Phase 1: Setup (Shared Infrastructure)

- [ ] T001 Tạo drawable `ic_player_expand.xml` (chevron up icon) trong `CxPlayer/app/src/main/res/drawable/`
- [ ] T002 [P] Tạo drawable `ic_player_close.xml` (close X icon) trong `CxPlayer/app/src/main/res/drawable/`
- [ ] T003 [P] Tạo drawable `ic_player_pip.xml` (Picture-in-Picture icon) trong `CxPlayer/app/src/main/res/drawable/` (nếu chưa có)
- [ ] T004 [P] Thêm dimensions mới cho expanded function row trong `CxPlayer/app/src/main/res/values/dimens.xml`: `player_expanded_row_height`, `player_side_buttons_width`, `player_speed_button_text_size`
- [ ] T005 [P] Thêm string resources trong `CxPlayer/app/src/main/res/values/strings.xml`: `player_expand_content_description`, `player_collapse_content_description`, `player_speed_content_description`, `player_pip_content_description`

---

## Phase 2: Foundational (Blocking Prerequisites)

- [ ] T006 Refactor bottom chrome layout trong `CxPlayer/app/src/main/res/layout/activity_player.xml` — Thay đổi cấu trúc `playerBottomChrome` thành: timeline row + FrameLayout chứa (center: LinearLayout vertical [expandable function row + transport row]) + (right: LinearLayout vertical [Lock button + Expand button]). Transport row chỉ giữ 5 nút: PiP, Previous, Play/Pause, Next, Subtitle — căn giữa. Function row chứa 5 nút: Shuffle, SeekBack, Speed (TextView), SeekForward, Repeat — căn giữa, mặc định `visibility=GONE`. Thay `Spinner` speed bằng `TextView` hiển thị "1X"
- [ ] T007 Di chuyển các nút không cần thiết (Resize, Rotate, AudioTrack, AutoPlay) ra khỏi layout hiển thị hoặc ẩn đi trong `CxPlayer/app/src/main/res/layout/activity_player.xml` — các nút này sẽ được truy cập qua menu overflow (giữ ID để không break code)

---

## Phase 3: User Story 1 — Giao diện thu gọn mặc định (Priority: P1) 🎯 MVP

**Goal**: Transport row hiển thị 5 nút chính (PiP, Previous, Play/Pause, Next, Subtitle) căn giữa + 2 nút phụ (Lock, Expand) bên phải khi mở video

**Independent Test**: Mở video, xác nhận chỉ có 5 nút chính + 2 nút bên phải, không có hàng nút phụ

### Implementation for User Story 1

- [ ] T008 [US1] Cập nhật bindings trong `PlayerActivity.kt` — thêm binding cho `playerExpandButton`, `playerPipButton`, `playerSpeedButton` (TextView), `playerFunctionRowExpandable` (LinearLayout mới). Loại bỏ binding cho `playerSpeedSpinner` (thay bằng TextView)
- [ ] T009 [US1] Cập nhật `initializeFunctionRow()` trong `PlayerActivity.kt` — set click listener cho `playerExpandButton` gọi `toggleTransportExpand()`. Set click listener cho PiP button. Loại bỏ Spinner logic, thay bằng Speed TextView click-to-cycle
- [ ] T010 [US1] Implement speed button click-to-cycle logic trong `PlayerActivity.kt` — thay thế `setupSpeedSpinner()` bằng logic click trên `playerSpeedButton` TextView, cycle qua các tốc độ (1X → 1.25X → 1.5X → 2X → 0.5X → 0.75X → 1X) và cập nhật text hiển thị

---

## Phase 4: User Story 2 — Mở rộng transport row (Priority: P1)

**Goal**: Bấm Expand → hàng nút phụ slide up; bấm X → slide down. Nút Expand chuyển icon giữa chevron và X

**Independent Test**: Bấm Expand → function row xuất hiện với animation slide up, 5 nút phụ căn giữa. Bấm X → slide down ẩn

### Implementation for User Story 2

- [ ] T011 [US2] Implement `toggleTransportExpand()` trong `PlayerActivity.kt` — dùng `ValueAnimator` để animate height của `playerFunctionRowExpandable` từ 0 → target height (expand) hoặc target → 0 (collapse). Duration 300ms. Khi expand xong: set Expand icon → close (X). Khi collapse xong: set icon → chevron. Thêm `isTransportExpanded` boolean flag
- [ ] T012 [US2] Tích hợp auto-collapse vào chrome visibility logic trong `PlayerActivity.kt` — khi chrome auto-hide (timeout), nếu `isTransportExpanded == true`, gọi collapse animation trước rồi mới ẩn chrome. Reset `isTransportExpanded = false`
- [ ] T013 [US2] Tích hợp auto-collapse vào lock screen logic trong `PlayerActivity.kt` — khi `setScreenLocked(true)`, nếu `isTransportExpanded == true`, collapse function row trước khi lock. Reset `isTransportExpanded = false`

---

## Phase 5: User Story 3 — Layout nhất quán landscape/portrait (Priority: P2)

**Goal**: Transport row hoạt động đúng trên cả 2 orientation, các nút luôn căn giữa

**Independent Test**: Xoay qua lại landscape ↔ portrait, xác nhận layout không bị vỡ ở cả collapsed và expanded

### Implementation for User Story 3

- [ ] T014 [US3] Review và fix layout cho portrait mode trong `CxPlayer/app/src/main/res/layout/activity_player.xml` — đảm bảo FrameLayout wrap transport + side buttons có `layout_width=match_parent` và nút bên phải không bị đẩy ra ngoài màn hình ở portrait. Kiểm tra `adjustPaddingForCompactChrome()` trong `PlayerActivity.kt` vẫn hoạt động đúng với layout mới
- [ ] T015 [US3] Xử lý orientation change trong `PlayerActivity.kt` — nếu đang expanded khi xoay màn hình, giữ nguyên trạng thái `isTransportExpanded` và re-apply correct height cho function row (không cần re-animate)

---

## Phase 6: Polish & Cross-Cutting Concerns

- [ ] T016 Xử lý edge case: rapid tap Expand/Collapse — trong `toggleTransportExpand()` của `PlayerActivity.kt`, thêm guard kiểm tra animation đang chạy (isAnimating flag), nếu đang chạy thì bỏ qua click
- [ ] T017 Xử lý edge case: 1 video trong playlist — trong `PlayerActivity.kt`, đảm bảo nút Previous và Next hiển thị disabled (alpha 0.3, clickable false) khi playlist chỉ có 1 item
- [ ] T018 Update changelog trong `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt` dòng greeting thành `[FEATURE]: Transport row redesign - collapsed/expanded - 2026-05-03`

---

## Dependencies & Execution Order

### Phase Dependencies

```
Phase 1 (Setup) → Phase 2 (Foundational) → Phase 3 (US1) → Phase 4 (US2) → Phase 5 (US3) → Phase 6 (Polish)
```

### User Story Dependencies

```
US1 (giao diện thu gọn) → US2 (mở rộng) → US3 (orientation)
```

US2 phụ thuộc US1 vì cần layout và bindings từ US1.
US3 phụ thuộc US2 vì cần test expanded state trên cả 2 orientations.

### Within Each User Story

- Phase 3 (US1): T008 → T009 → T010 (sequential — bindings trước, listeners sau, speed logic cuối)
- Phase 4 (US2): T011 → T012/T013 (T012 và T013 parallelizable sau T011)
- Phase 5 (US3): T014/T015 (parallelizable — layout và Kotlin code riêng biệt)

### Parallel Opportunities

```
Phase 1: T001 | T002 | T003 | T004 | T005 (tất cả parallelizable — files khác nhau)
Phase 4: T012 | T013 (sau T011 — 2 integration points độc lập)
Phase 5: T014 | T015 (layout XML vs Kotlin code)
```

## Implementation Strategy

### MVP First (User Story 1 Only)

Hoàn thành Phase 1 → 2 → 3 để có giao diện thu gọn hoạt động. Đây là trạng thái mặc định, đủ để sử dụng.

### Incremental Delivery

1. **MVP**: Phase 1–3 → Transport row thu gọn với 5 nút chính
2. **Expand**: Phase 4 → Thêm chức năng mở rộng/thu gọn
3. **Polish**: Phase 5–6 → Orientation support + edge cases

## Notes

- Không cần test automation — manual UI testing trên thiết bị
- Các nút bị ẩn (Resize, Rotate, AudioTrack, AutoPlay) vẫn giữ ID, chỉ set `visibility=GONE` để không break existing code references
- Speed button thay thế Spinner — logic cycle tốc độ giữ nguyên, chỉ đổi UI widget
