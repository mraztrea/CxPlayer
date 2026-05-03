# Research: Transport Row Redesign

## Decision Log

### D1: Layout approach cho expand/collapse

**Decision**: Sử dụng `LinearLayout` với `visibility` GONE/VISIBLE kết hợp `TranslateAnimation` hoặc `ValueAnimator` để slide up/down hàng nút phụ.

**Rationale**: Đơn giản, không cần thêm dependency. `LinearLayout` vertical chứa function row (expandable) + transport row (always visible) đã đủ. Animation slide dùng `ValueAnimator` trên height cho mượt hơn TranslateAnimation.

**Alternatives considered**:
- `MotionLayout` / `ConstraintLayout` transition: Quá phức tạp cho chỉ show/hide 1 row
- `RecyclerView` với item animations: Không phù hợp cho fixed button layout
- `ViewStub`: Không hỗ trợ animation tốt

### D2: Vị trí nút Lock và Expand

**Decision**: Lock và Expand nằm trong 1 `LinearLayout` vertical riêng, positioned bên phải bottom chrome (ngoài transport row), dùng `FrameLayout` hoặc `RelativeLayout` wrap.

**Rationale**: Theo thiết kế tham chiếu, 2 nút này nằm ngoài hàng nút chính, xếp dọc bên phải. Tách riêng giúp transport row buttons căn giữa không bị lệch.

**Alternatives considered**:
- Đặt trong transport row với weight: Sẽ phá vỡ center alignment
- Floating buttons: Không phù hợp UI pattern của player

### D3: State management cho expanded/collapsed

**Decision**: Sử dụng một `Boolean` property (`isTransportExpanded`) trong `PlayerActivity` để track trạng thái. Reset về `false` khi chrome ẩn hoặc lock.

**Rationale**: Đơn giản, đủ dùng. Không cần ViewModel hay StateFlow cho 1 boolean flag.

**Alternatives considered**:
- SharedPreferences persist: Không cần nhớ trạng thái qua sessions
- ViewModel: Overkill cho 1 flag

### D4: Tổ chức lại buttons giữa 2 rows

**Decision**: Dựa theo mockup:
- **Transport Row (always visible)**: PiP, Previous, Play/Pause, Next, Subtitle — căn giữa
- **Function Row (expandable)**: Shuffle, Rewind, Speed (text "1X"), Fast Forward, Repeat — căn giữa
- Các nút hiện đang ở function row nhưng không nằm trong mockup (Resize, Rotate, AudioTrack, AutoPlay) sẽ được chuyển ra menu overflow hoặc ẩn đi.

**Rationale**: Tuân theo thiết kế tham chiếu. Giữ giao diện gọn gàng.

### D5: Speed button thay thế Spinner

**Decision**: Thay `Spinner` (playerSpeedSpinner) bằng `TextView`/`Button` hiển thị text "1X" trong function row. Click để cycle qua các tốc độ.

**Rationale**: Theo mockup, speed hiển thị dạng text "1X" thay vì dropdown spinner. Đơn giản hơn và khớp thiết kế.

## Unresolved Items

Không có — tất cả đã resolved qua spec clarification và mockup reference.
