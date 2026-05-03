# Research: Transport Row Redesign

**Date**: 2026-05-03

## R1: Cách tổ chức collapse/expand cho transport row

**Decision**: Sử dụng `visibility toggle` trên các View phụ trong cùng một LinearLayout, kết hợp `TransitionManager.beginDelayedTransition()` cho animation mượt.

**Rationale**: 
- Đơn giản nhất vì chỉ cần toggle `View.VISIBLE` / `View.GONE` cho các nút phụ.
- `TransitionManager` tự động animate layout changes mà không cần custom animation.
- Giữ tất cả nút trong cùng 1 LinearLayout → căn giữa tự nhiên bằng `gravity="center"`.

**Alternatives considered**:
- ConstraintLayout + MotionLayout: quá phức tạp cho use case đơn giản.
- Custom ViewGroup: over-engineering, khó maintain.
- RecyclerView: không phù hợp với số lượng nút cố định.

## R2: Vị trí floating buttons (Lock + Expand)

**Decision**: Đặt Lock + Expand trong FrameLayout root, dùng `layout_gravity="center_vertical|end"` và margin phải. Chúng nằm ngoài playerBottomChrome, xuất hiện cùng lúc khi chrome visible.

**Rationale**: 
- Tách biệt khỏi transport row → không ảnh hưởng căn giữa.
- FrameLayout gravity cho phép định vị chính xác bên phải.
- Visibility sync với chrome visibility (cùng show/hide).

**Alternatives considered**:
- Đặt trong playerBottomChrome: sẽ đẩy transport row sang trái, phá vỡ center alignment.

## R3: Thu nhỏ height transport row

**Decision**: Giảm `player_transport_row_min_height` từ 56dp → 48dp, giảm `player_transport_primary_button_size` từ 56dp → 48dp, bỏ `player_function_row_height`, bỏ `player_function_row_margin_top`. Transport row chỉ còn 1 hàng nút duy nhất.

**Rationale**:
- User yêu cầu transport row chỉ vừa 1 hàng nút.
- 48dp là kích thước nút tiêu chuẩn Android, đủ touch target.
- Loại bỏ function row → bottom chrome gọn hơn: chỉ timeline + transport.

**Alternatives considered**:
- Giữ 56dp cho play button: tạo sự khác biệt nhưng tăng chiều cao → reject theo yêu cầu user.

## R4: Thứ tự nút khi expand

**Decision**: 
- **Collapsed**: `[Resize] [Prev] [Play/Pause] [Next] [Subtitle]`
- **Expanded**: `[SeekBack] [Repeat] [Resize] [Prev] [Play/Pause] [Next] [Subtitle] [Audio] [Speed] [Shuffle] [Autoplay] [SeekFwd]`
- Nút phụ thêm ở hai đầu, 5 nút cơ bản giữ nguyên vị trí.

**Rationale**: Giữ muscle memory cho người dùng — 5 nút trung tâm không dịch chuyển.

## R5: Icon cho nút Expand/Collapse

**Decision**: Sử dụng chevron icon — `ic_player_expand` (chevron xuống/mở rộng), `ic_player_collapse` (chevron lên/thu gọn). Dùng Vector Drawable.

**Rationale**: Chevron là ký hiệu phổ biến cho expand/collapse, dễ nhận biết.
