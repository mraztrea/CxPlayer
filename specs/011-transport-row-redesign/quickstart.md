# Quickstart: Transport Row Redesign

## Tổng quan

Refactor bottom chrome trong player để có 2 trạng thái: thu gọn và mở rộng. Transport row (nút chính) luôn hiển thị, function row (nút phụ) hiển thị khi bấm Expand.

## Files cần thay đổi

1. **`activity_player.xml`** — Refactor bottom chrome layout:
   - Tách transport row thành 2 hàng: main buttons + expandable function row
   - Thêm side buttons container (Lock + Expand) bên phải
   - Function row mặc định `visibility=GONE`

2. **`PlayerActivity.kt`** — Logic expand/collapse:
   - Thêm `isTransportExpanded` flag
   - Thêm `toggleTransportExpand()` method với slide animation
   - Thêm `playerExpandButton` binding
   - Thay `Spinner` speed bằng `TextView` click-to-cycle
   - Reset expanded state khi chrome ẩn / lock
   - Di chuyển các buttons không cần thiết ra khỏi visible layout

3. **`dimens.xml`** — Dimensions mới cho expanded row height

4. **`strings.xml`** — Content descriptions cho nút Expand

5. **Drawable** — Icon expand (chevron) và close (X) nếu chưa có

## Verification

- [ ] Mở video → transport row collapsed, 5 nút chính căn giữa
- [ ] Bấm Expand → function row slide up, 5 nút phụ căn giữa
- [ ] Bấm Close (X) → function row slide down ẩn
- [ ] Chrome auto-hide → function row collapse trước khi ẩn
- [ ] Lock screen → function row collapse trước khi lock
- [ ] Portrait ↔ Landscape → layout không bị vỡ
