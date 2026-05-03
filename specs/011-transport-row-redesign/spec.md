# Feature Specification: Transport Row Redesign

**Feature Branch**: `014-transport-row-redesign`  
**Created**: 2026-05-03  
**Status**: Draft  
**Input**: User description: "Tối ưu lại giao diện transport row với chế độ thu gọn (collapsed) và mở rộng (expanded), dựa theo thiết kế tham chiếu từ video_player_module"

## Clarifications

### Session 2026-05-03

- Q: Khi transport row đang mở rộng và chrome tự ẩn sau timeout, transport row xử lý thế nào? → A: Tự thu gọn về collapsed rồi ẩn cùng chrome — lần hiện tiếp theo luôn ở trạng thái collapsed
- Q: Hướng animation khi mở rộng/thu gọn hàng nút phụ? → A: Slide up/down — hàng phụ trượt từ dưới lên khi expand, trượt xuống khi collapse

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Xem video với giao diện điều khiển thu gọn (Priority: P1)

Khi người dùng mở video, thanh điều khiển phía dưới (transport row) chỉ hiển thị các nút cơ bản gồm: nút PiP (Picture-in-Picture), nút Previous, nút Play/Pause, nút Next, và nút Subtitle. Các nút được căn giữa (center-aligned) theo chiều ngang. Bên cạnh đó, ở phía bên phải (ngoài transport row), có 2 nút: nút Lock (khóa màn hình) và nút Expand (mở rộng thêm hàng nút phụ).

**Why this priority**: Đây là trạng thái mặc định khi mở player, người dùng sẽ thấy đầu tiên. Giao diện gọn gàng giúp tối đa diện tích hiển thị video.

**Independent Test**: Mở bất kỳ video nào, kiểm tra transport row chỉ hiển thị 5 nút chính (PiP, Previous, Play/Pause, Next, Subtitle) và 2 nút phụ bên phải (Lock, Expand). Không có hàng nút bổ sung nào xuất hiện.

**Acceptance Scenarios**:

1. **Given** người dùng mở video, **When** video bắt đầu phát, **Then** transport row hiển thị ở trạng thái thu gọn với 5 nút chính được căn giữa
2. **Given** transport row đang ở trạng thái thu gọn, **When** người dùng nhìn vào khu vực bên phải, **Then** thấy nút Lock và nút Expand (chevron) xếp dọc
3. **Given** transport row đang ở trạng thái thu gọn, **When** người dùng tương tác với video, **Then** transport row tự ẩn/hiện theo cơ chế chrome visibility hiện có

---

### User Story 2 - Mở rộng transport row để truy cập các chức năng phụ (Priority: P1)

Khi người dùng bấm nút "Expand" (biểu tượng chevron/mũi tên), transport row mở rộng thêm một hàng nút phía trên hàng nút chính. Hàng nút phụ này chứa các nút: Shuffle, Rewind (tua lùi), tốc độ phát (Speed - hiển thị dạng text "1X"), Fast Forward (tua nhanh), và Repeat. Các nút hàng phụ cũng được căn giữa. Khi mở rộng, nút Expand chuyển trạng thái thành "X" (đóng) để người dùng thu gọn lại.

**Why this priority**: Cho phép người dùng truy cập nhanh các chức năng nâng cao mà không làm rối giao diện mặc định.

**Independent Test**: Bấm nút Expand, xác nhận hàng nút phụ xuất hiện phía trên với 5 nút (Shuffle, Rewind, Speed, Fast Forward, Repeat) căn giữa. Bấm nút "X" để thu gọn lại, xác nhận hàng phụ biến mất.

**Acceptance Scenarios**:

1. **Given** transport row đang thu gọn, **When** người dùng bấm nút Expand, **Then** hàng nút phụ xuất hiện phía trên hàng chính với animation mượt
2. **Given** transport row đang mở rộng, **When** người dùng bấm nút đóng (X), **Then** hàng nút phụ ẩn đi và transport row trở về trạng thái thu gọn
3. **Given** transport row đang mở rộng, **When** người dùng bấm nút Speed (1X), **Then** tốc độ phát thay đổi tuần tự (1X → 1.25X → 1.5X → 2X → 0.5X → 0.75X → 1X)

---

### User Story 3 - Bố cục nút đồng nhất trên cả landscape và portrait (Priority: P2)

Giao diện transport row hoạt động nhất quán trên cả chế độ ngang (landscape) và dọc (portrait). Các nút luôn căn giữa bất kể kích thước màn hình. Seekbar (thanh tiến trình) nằm phía trên transport row với thời gian hiện tại bên trái và tổng thời gian bên phải.

**Why this priority**: Đảm bảo trải nghiệm nhất quán giữa các chế độ xoay màn hình.

**Independent Test**: Xoay thiết bị qua lại giữa landscape và portrait, xác nhận layout không bị vỡ và các nút vẫn căn giữa.

**Acceptance Scenarios**:

1. **Given** người dùng đang xem video ở landscape, **When** xoay sang portrait, **Then** transport row tự điều chỉnh layout, các nút vẫn căn giữa
2. **Given** hàng nút phụ đang mở ở landscape, **When** xoay sang portrait, **Then** hàng nút phụ vẫn hiển thị và căn giữa đúng

---

### Edge Cases

- Khi transport row đang mở rộng và người dùng bấm lock màn hình: transport row phải tự thu gọn trước khi khóa
- Khi video kết thúc trong trạng thái mở rộng: giữ nguyên trạng thái transport row
- Khi người dùng bấm nhanh liên tục nút Expand/Collapse: animation không bị chồng chéo, trạng thái cuối cùng phải chính xác
- Khi chỉ có 1 video trong playlist: nút Previous và Next vẫn hiển thị nhưng ở trạng thái disabled
- Khi transport row đang mở rộng và chrome tự ẩn sau timeout: transport row tự thu gọn về collapsed trước khi ẩn, lần hiện tiếp theo luôn ở trạng thái collapsed

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Transport row PHẢI có 2 trạng thái: thu gọn (collapsed - mặc định) và mở rộng (expanded)
- **FR-002**: Ở trạng thái thu gọn, hàng nút chính PHẢI hiển thị 5 nút theo thứ tự: PiP, Previous, Play/Pause, Next, Subtitle — tất cả căn giữa theo chiều ngang
- **FR-003**: Nút Lock và nút Expand PHẢI nằm ở phía bên phải, xếp dọc, ngoài hàng nút chính (cùng vị trí với thiết kế tham chiếu)
- **FR-004**: Khi bấm nút Expand, hàng nút phụ PHẢI xuất hiện phía trên hàng nút chính, chứa 5 nút theo thứ tự: Shuffle, Rewind, Speed (text "1X"), Fast Forward, Repeat — căn giữa
- **FR-005**: Khi mở rộng, nút Expand PHẢI chuyển thành biểu tượng đóng (X) để người dùng thu gọn lại
- **FR-006**: Seekbar PHẢI nằm phía trên tất cả các hàng nút, với thời gian hiện tại bên trái và tổng thời gian bên phải
- **FR-007**: Animation chuyển đổi giữa thu gọn và mở rộng PHẢI mượt mà, không giật — sử dụng hiệu ứng slide up (mở rộng) và slide down (thu gọn) cho hàng nút phụ
- **FR-008**: Trạng thái thu gọn/mở rộng PHẢI được đồng bộ với cơ chế hiển thị/ẩn chrome hiện tại (tap để ẩn/hiện)
- **FR-009**: Khi lock màn hình, nếu transport row đang mở rộng, nó PHẢI tự thu gọn về trạng thái mặc định
- **FR-010**: Khi chrome tự ẩn sau timeout, nếu transport row đang mở rộng, nó PHẢI tự thu gọn về collapsed trước khi ẩn — lần hiện tiếp theo luôn ở trạng thái collapsed

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% các nút hiển thị đúng vị trí và căn giữa trên cả landscape và portrait
- **SC-002**: Thời gian chuyển đổi giữa trạng thái thu gọn và mở rộng dưới 300ms
- **SC-003**: Không có hiện tượng nút bị che khuất hoặc tràn ra ngoài màn hình trên các thiết bị từ 4.7 inch trở lên
- **SC-004**: Giao diện transport row phải khớp với thiết kế tham chiếu (ảnh mockup) ở cả 2 trạng thái

## Assumptions

- Các chức năng của từng nút (PiP, Shuffle, Speed, Repeat, v.v.) đã được implement sẵn, chỉ cần tổ chức lại bố cục UI
- Cơ chế ẩn/hiện chrome (tap to show/hide) đã hoạt động và sẽ được tái sử dụng
- Thiết kế tham chiếu từ `video_player_module` là chuẩn cuối cùng cần tuân theo
- Seekbar và logic điều khiển playback không thay đổi, chỉ thay đổi bố cục hiển thị
- Nút Lock và Expand nằm bên phải, cùng khu vực với vị trí hiện tại trong thiết kế tham chiếu
