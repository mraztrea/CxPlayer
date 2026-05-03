# Tasks: Transport Row Redesign

**Feature**: Transport Row Redesign  
**Branch**: `013-transport-row-redesign`  
**Generated**: 2026-05-03  
**Spec**: [spec.md](spec.md) | **Plan**: [plan.md](plan.md)

## Phase 1: Setup

**Purpose**: Tạo drawable icons mới và cập nhật dimensions.

- [ ] T001 Tạo expand icon vector drawable tại `CxPlayer/app/src/main/res/drawable/ic_player_expand.xml`
- [ ] T002 [P] Tạo collapse icon vector drawable tại `CxPlayer/app/src/main/res/drawable/ic_player_collapse.xml`
- [ ] T003 [P] Cập nhật dimensions cho transport row compact tại `CxPlayer/app/src/main/res/values/dimens.xml` — giảm `player_transport_row_min_height` từ 56dp→48dp, `player_transport_primary_button_size` từ 56dp→48dp, `player_transport_primary_button_padding` từ 14dp→10dp, `player_transport_row_margin_top` từ 12dp→8dp

## Phase 2: Foundational — Restructure Layout XML

**Purpose**: Xoá Function Row, restructure transport row với collapse/expand pattern, thêm floating buttons.

**Prerequisites**: Phase 1 hoàn thành.

- [ ] T004 Xoá toàn bộ Function Row (HorizontalScrollView `playerFunctionRow` và nội dung bên trong) khỏi `CxPlayer/app/src/main/res/layout/activity_player.xml`
- [ ] T005 Restructure `playerTransportRow` trong `CxPlayer/app/src/main/res/layout/activity_player.xml` — sắp xếp nút theo thứ tự: `[SeekBack GONE] [Repeat GONE] [Resize] [Prev] [Play/Pause] [Next] [Subtitle] [Audio GONE] [Speed GONE] [Shuffle GONE] [Autoplay GONE] [SeekFwd GONE]`. Tất cả nút phụ có `android:visibility="gone"`. Tất cả nút cùng kích thước `player_transport_button_size` (48dp), play/pause cũng 48dp. LinearLayout gravity="center".
- [ ] T006 Thêm floating buttons container (LinearLayout vertical, `layout_gravity="center_vertical|end"`) vào `playerRoot` trong `CxPlayer/app/src/main/res/layout/activity_player.xml` — chứa `playerLockButton` (di chuyển từ Function Row) và `playerExpandButton` (ImageButton mới, dùng `ic_player_expand`). Đặt sau `playerBottomChrome`, trước `playerUnlockButton`.

## Phase 3: User Story 1 — Giao diện transport gọn gàng (P1)

**Goal**: Transport row mặc định chỉ hiển thị 5 nút cơ bản căn giữa.
**Independent Test**: Mở video → chrome hiển thị → thấy 5 nút cơ bản căn giữa, không có function row.

- [ ] T007 [US1] Cập nhật `PlayerActivity.kt` tại `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` — xoá toàn bộ code liên quan đến `functionRow` (biến, binding `playerFunctionRow`, hàm `initializeFunctionRow()`). Thêm binding cho `playerExpandButton`. Cập nhật binding cho `playerLockButton` trỏ đến vị trí mới trong floating container.
- [ ] T008 [US1] Cập nhật logic chrome visibility trong `PlayerActivity.kt` — khi show/hide chrome, floating buttons (Lock + Expand) phải sync visibility cùng lúc với `playerBottomChrome`. Floating buttons visible khi chrome visible, gone khi chrome gone.

## Phase 4: User Story 2 — Expand/Collapse transport row (P1)

**Goal**: Bấm nút Expand → hiện thêm nút phụ ở hai đầu, 5 nút giữa giữ nguyên. Bấm lại → thu gọn.
**Independent Test**: Bấm Expand → thấy tất cả nút → bấm lại → chỉ còn 5 nút cơ bản.

- [ ] T009 [US2] Thêm biến `isTransportExpanded: Boolean = false` và danh sách references đến các nút phụ (seekBack, repeat, audioTrack, speedSpinner, shuffle, autoPlay, seekForward) trong `PlayerActivity.kt`
- [ ] T010 [US2] Implement hàm `toggleTransportExpand()` trong `PlayerActivity.kt` — toggle `isTransportExpanded`, sử dụng `TransitionManager.beginDelayedTransition()` trên `playerTransportRow` (hoặc parent), set visibility VISIBLE/GONE cho các nút phụ. Đổi icon `playerExpandButton` giữa `ic_player_expand` / `ic_player_collapse`.
- [ ] T011 [US2] Gắn `setOnClickListener` cho `playerExpandButton` gọi `toggleTransportExpand()` trong `PlayerActivity.kt`
- [ ] T012 [US2] Đảm bảo trạng thái `isTransportExpanded` được giữ nguyên khi chrome ẩn/hiện — khi chrome hiện lại, gọi lại `applyTransportExpandState()` để khôi phục visibility các nút phụ theo state hiện tại.

## Phase 5: User Story 3 — Nút Lock hoạt động độc lập (P2)

**Goal**: Lock button ở floating position hoạt động đúng, không bị ảnh hưởng bởi expand/collapse.
**Independent Test**: Lock khi collapsed → unlock → vẫn collapsed. Lock khi expanded → unlock → vẫn expanded.

- [ ] T013 [US3] Verify và cập nhật logic lock/unlock trong `PlayerActivity.kt` — khi lock, ẩn tất cả chrome + floating buttons, chỉ hiện `playerUnlockButton`. Khi unlock, khôi phục chrome + floating buttons + trạng thái expand/collapse trước đó.

## Phase 6: Polish & Cross-Cutting

**Purpose**: Hoàn thiện và kiểm tra toàn diện.

- [ ] T014 Xoá các dimension không còn dùng (`player_function_row_height`, `player_function_row_margin_top`, `player_function_button_size`, `player_function_button_padding`, `player_function_button_spacing`) khỏi `CxPlayer/app/src/main/res/values/dimens.xml`
- [ ] T015 Xoá các string resource không còn dùng liên quan function row (nếu có) khỏi `CxPlayer/app/src/main/res/values/strings.xml`
- [ ] T016 Cập nhật changelog trong `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt` dòng 36 thành `[FEATURE]: Transport row redesign collapse/expand - 2026-05-03`

## Dependencies

```text
Phase 1 (T001-T003) → Phase 2 (T004-T006) → Phase 3 (T007-T008) → Phase 4 (T009-T012) → Phase 5 (T013) → Phase 6 (T014-T016)
```

**Parallel opportunities**:
- T001, T002, T003 có thể chạy song song (files khác nhau)
- T014, T015, T016 có thể chạy song song (files khác nhau)

## Implementation Strategy

**MVP**: Phase 1-3 (Setup + Layout + 5 nút cơ bản) — giao diện gọn gàng hoạt động ngay.
**Full Feature**: Phase 4 thêm expand/collapse.
**Polish**: Phase 5-6 verify lock + cleanup.

**Incremental Delivery**: Mỗi phase hoàn thành = app vẫn build + chạy được.
