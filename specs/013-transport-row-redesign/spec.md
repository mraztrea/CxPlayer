# Feature Specification: Transport Row Redesign

**Feature Branch**: `013-transport-row-redesign`  
**Created**: 2026-05-03  
**Status**: Draft  
**Input**: User description: "Tối ưu lại giao diện transport row - hiển thị nút cơ bản mặc định, mở rộng khi bấm nút expand"

## Clarifications

### Session 2026-05-03

- Q: Vị trí nút Lock và Expand — trong transport row hay floating bên phải? → A: Nằm floating bên phải màn hình (như ảnh mẫu), tách biệt khỏi transport row.
- Q: Xử lý Function Row hiện tại khi redesign? → A: Loại bỏ hoàn toàn Function Row, tất cả nút được phân bổ vào transport row (collapsed/expanded).
- Q: Thứ tự nút khi transport row mở rộng? → A: Nút phụ thêm ở hai đầu trái/phải, 5 nút cơ bản giữ nguyên vị trí giữa.

## User Scenarios & Testing

### User Story 1 - Xem video với giao diện transport gọn gàng (Priority: P1)

Người dùng mở video và thấy transport row chỉ hiển thị các nút điều khiển cơ bản (resize, previous, play/pause, next, subtitle) được căn giữa màn hình. Giao diện gọn gàng, không bị rối mắt bởi quá nhiều nút chức năng.

**Why this priority**: Đây là trải nghiệm mặc định khi xem video - cần đảm bảo giao diện sạch sẽ và tập trung vào các thao tác phổ biến nhất.

**Independent Test**: Có thể kiểm tra bằng cách mở bất kỳ video nào và quan sát transport row chỉ hiển thị 5 nút cơ bản được căn giữa.

**Acceptance Scenarios**:

1. **Given** người dùng đang xem video, **When** chrome hiển thị, **Then** transport row chỉ hiển thị 5 nút cơ bản: resize (PIP), skip previous, play/pause, skip next, subtitle — tất cả được căn giữa theo chiều ngang.
2. **Given** transport row đang ở trạng thái thu gọn, **When** người dùng nhìn vào, **Then** bên phải màn hình (floating, tách biệt khỏi transport row) có hiển thị nút Lock (hình khoá) và nút Expand (hình mũi tên mở rộng).

---

### User Story 2 - Mở rộng transport row để truy cập nút phụ (Priority: P1)

Người dùng bấm nút "Expand" (cạnh nút Lock) để mở rộng transport row, hiển thị thêm các nút chức năng phụ như: seek back/forward, repeat, track selector, audio track, speed, shuffle, autoplay.

**Why this priority**: Người dùng nâng cao cần truy cập nhanh các chức năng bổ sung mà không cần vào menu.

**Independent Test**: Bấm nút expand và kiểm tra tất cả nút phụ hiển thị đầy đủ, transport row mở rộng chiều ngang.

**Acceptance Scenarios**:

1. **Given** transport row đang ở trạng thái thu gọn, **When** người dùng bấm nút Expand, **Then** transport row mở rộng, hiển thị thêm các nút phụ ở hai đầu — nút cơ bản giữ nguyên vị trí giữa. Thứ tự: `[SeekBack] [Repeat] [Resize] [Prev] [Play] [Next] [Subtitle] [Audio] [Speed] [Shuffle] [Autoplay] [SeekFwd]`.
2. **Given** transport row đang ở trạng thái mở rộng, **When** người dùng bấm lại nút Expand (lúc này icon thay đổi thành "thu gọn"), **Then** transport row trở về trạng thái thu gọn chỉ hiển thị 5 nút cơ bản.
3. **Given** transport row đang mở rộng, **When** chrome ẩn rồi hiện lại, **Then** transport row giữ nguyên trạng thái mở rộng/thu gọn trước đó.

---

### User Story 3 - Nút Lock hoạt động độc lập (Priority: P2)

Nút Lock nằm cạnh nút Expand trong transport row, hoạt động độc lập và không bị ảnh hưởng bởi trạng thái expand/collapse.

**Why this priority**: Lock screen là chức năng quan trọng nhưng đã có sẵn, chỉ cần đảm bảo vị trí mới phù hợp.

**Independent Test**: Bấm nút Lock khi transport row ở cả hai trạng thái (thu gọn/mở rộng) đều hoạt động đúng.

**Acceptance Scenarios**:

1. **Given** transport row ở trạng thái thu gọn hoặc mở rộng, **When** người dùng bấm nút Lock, **Then** màn hình bị khoá, ẩn toàn bộ chrome, chỉ hiện nút Unlock ở giữa màn hình.

---

### Edge Cases

- Khi transport row mở rộng, nếu có quá nhiều nút vượt quá chiều ngang màn hình → cần hỗ trợ scroll ngang (HorizontalScrollView).
- Khi xoay màn hình (landscape ↔ portrait), trạng thái expand/collapse phải được giữ nguyên.
- Animation mở rộng/thu gọn phải mượt mà, không bị giật.

## Requirements

### Functional Requirements

- **FR-001**: Transport row PHẢI hiển thị mặc định ở trạng thái thu gọn với 5 nút cơ bản: Resize (PIP), Skip Previous, Play/Pause, Skip Next, Subtitle.
- **FR-002**: Nút Lock và nút Expand PHẢI hiển thị dạng floating bên phải màn hình, tách biệt khỏi transport row (theo ảnh mẫu).
- **FR-003**: Khi bấm nút Expand, transport row PHẢI mở rộng — nút phụ xuất hiện ở hai đầu trái/phải, 5 nút cơ bản giữ nguyên vị trí giữa. Thứ tự mở rộng: `[nút phụ trái...] [Resize] [Prev] [Play] [Next] [Subtitle] [nút phụ phải...]`.
- **FR-004**: Khi bấm nút Expand lần nữa (khi đang mở rộng), transport row PHẢI thu gọn về trạng thái ban đầu.
- **FR-005**: Tất cả các nút trong transport row PHẢI được căn giữa (center aligned) theo chiều ngang.
- **FR-006**: Trạng thái expand/collapse PHẢI được duy trì khi chrome ẩn/hiện (toggle visibility).
- **FR-007**: Nút Lock PHẢI hoạt động độc lập, không phụ thuộc trạng thái expand/collapse.
- **FR-008**: Khi transport row mở rộng vượt chiều ngang màn hình, PHẢI hỗ trợ cuộn ngang (horizontal scroll).
- **FR-009**: Animation mở rộng/thu gọn PHẢI mượt mà với hiệu ứng chuyển đổi phù hợp.
- **FR-010**: Icon của nút Expand PHẢI thay đổi giữa trạng thái "mở rộng" và "thu gọn" để phản ánh hành vi.

## Success Criteria

### Measurable Outcomes

- **SC-001**: Người dùng có thể nhận biết và sử dụng nút Expand trong vòng 3 giây khi lần đầu thấy giao diện.
- **SC-002**: Thời gian animation mở rộng/thu gọn không vượt quá 300ms.
- **SC-003**: Transport row thu gọn chiếm không quá 60% chiều ngang màn hình ở landscape mode.
- **SC-004**: 100% chức năng hiện có (play/pause, seek, skip, subtitle, lock, speed, etc.) vẫn hoạt động đúng sau redesign.
- **SC-005**: Giao diện transport row khớp với ảnh mẫu tham khảo (giao_dien_mau.jpg).

## Assumptions

- Giao diện hiện tại đã có đầy đủ các nút chức năng, chỉ cần sắp xếp lại layout theo mô hình collapse/expand.
- Function Row hiện tại (HorizontalScrollView chứa lock, subtitle, resize, rotate, audio track, speed, shuffle, autoplay) sẽ bị **xoá hoàn toàn** khỏi layout — tất cả nút được phân bổ lại vào transport row (collapsed/expanded) hoặc floating buttons (Lock, Expand).
- Nút Lock và Expand nằm floating bên phải màn hình, xếp dọc, tách biệt hoàn toàn khỏi transport row (theo ảnh mẫu).
- Existing Kotlin code trong PlayerActivity.kt đã bind đầy đủ các nút, chỉ cần cập nhật logic expand/collapse.
