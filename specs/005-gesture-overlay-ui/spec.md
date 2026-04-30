# Feature Specification: Gesture Overlay UI

**Feature Branch**: `[006-gesture-overlay-ui]`  
**Created**: 2026-04-30  
**Status**: Draft  
**Input**: User description: "triển khai task \"2.3 Overlay UI khi gesture\" trong _docs/plans/phase-2-gesture-controls.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Nhìn thấy phản hồi ngay khi vuốt (Priority: P1)

Người xem muốn thấy ngay một lớp chỉ báo nổi trên màn hình phát khi vuốt để biết mình đang thay đổi âm lượng, độ sáng hay tua nội dung bao nhiêu.

**Why this priority**: Nếu không có phản hồi trực quan tức thời, gesture swipe trở nên khó đoán và người dùng dễ thao tác quá tay hoặc phải mở lại cụm điều khiển phát.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát một video, thực hiện vuốt dọc ở nửa phải, vuốt dọc ở nửa trái và vuốt ngang trên bề mặt phát, rồi xác nhận mỗi thao tác đều hiện đúng loại chỉ báo với giá trị dễ đọc.

**Acceptance Scenarios**:

1. **Given** video đang phát và người dùng vuốt dọc ở nửa phải màn hình, **When** hệ thống nhận diện đây là thao tác đổi âm lượng, **Then** màn hình phải hiển thị chỉ báo âm lượng với mức hiện tại theo dạng phần trăm dễ đọc.
2. **Given** video đang phát và người dùng vuốt dọc ở nửa trái màn hình, **When** hệ thống nhận diện đây là thao tác đổi độ sáng, **Then** màn hình phải hiển thị chỉ báo độ sáng với mức hiện tại theo dạng phần trăm dễ đọc.
3. **Given** video đang phát và người dùng vuốt ngang trên bề mặt phát, **When** hệ thống cập nhật độ lệch tua theo quãng đường vuốt, **Then** màn hình phải hiển thị chỉ báo tua với hướng tua và thời lượng delta có dấu theo định dạng thời gian dễ hiểu.

---

### User Story 2 - Biết rõ khi đang tua nhanh tạm thời (Priority: P2)

Người xem muốn thấy một chỉ báo nổi rõ ràng khi nhấn giữ để tua nhanh tạm thời, để họ biết video đang ở trạng thái phát nhanh và khi nào trạng thái này kết thúc.

**Why this priority**: Tua nhanh tạm thời là trạng thái ngắn nhưng có tác động lớn tới trải nghiệm xem; thiếu chỉ báo khiến người dùng khó hiểu vì sao video đang chạy nhanh hơn bình thường.

**Independent Test**: Có thể kiểm thử độc lập bằng cách nhấn giữ trên bề mặt phát để kích hoạt tua nhanh tạm thời, rồi thả tay và xác nhận chỉ báo 2x xuất hiện trong suốt thời gian giữ và biến mất ngay sau khi thao tác kết thúc.

**Acceptance Scenarios**:

1. **Given** video đang phát bình thường, **When** người dùng nhấn giữ để kích hoạt tua nhanh tạm thời, **Then** màn hình phải hiển thị chỉ báo 2x rõ ràng trong suốt thời gian nhấn giữ.
2. **Given** chỉ báo 2x đang hiển thị do nhấn giữ, **When** người dùng thả tay hoặc thao tác bị hủy, **Then** chỉ báo phải được gỡ bỏ trong khoảng thời gian ngắn mà không để trạng thái tua nhanh trông như vẫn còn hiệu lực.

---

### User Story 3 - Giữ overlay rõ ràng khi thao tác liên tiếp (Priority: P3)

Người xem muốn lớp overlay luôn chỉ hiển thị một thông điệp đang có hiệu lực, cập nhật mượt theo gesture hiện tại và không để lại chỉ báo cũ sau những chuỗi chạm nhanh hoặc bị gián đoạn.

**Why this priority**: Khi người dùng thao tác liên tục, overlay dễ trở thành nguồn gây nhiễu nếu nhiều chỉ báo chồng lên nhau hoặc một chỉ báo cũ bị kẹt lại trên màn hình.

**Independent Test**: Có thể kiểm thử độc lập bằng cách thực hiện các gesture hỗ trợ liên tiếp, lặp nhiều lần trong cùng phiên xem và thử hủy thao tác giữa chừng, rồi xác nhận chỉ có một overlay đang hoạt động tại mọi thời điểm và overlay tự dọn sạch đúng lúc.

**Acceptance Scenarios**:

1. **Given** một overlay gesture đang hiển thị, **When** người dùng tiếp tục cập nhật cùng gesture hoặc chuyển sang một gesture hỗ trợ khác, **Then** màn hình phải cập nhật hoặc thay thế nội dung overlay hiện tại thay vì chồng thêm nhiều lớp chỉ báo.
2. **Given** một gesture hỗ trợ bị gián đoạn do thao tác kết thúc đột ngột hoặc bị hủy, **When** chuỗi chạm đóng lại, **Then** overlay phải tự biến mất sau khoảng trễ ngắn và không còn lưu lại thông tin cũ trên màn hình.
3. **Given** người dùng thao tác tại giới hạn thấp nhất hoặc cao nhất của âm lượng, độ sáng hoặc tua nội dung, **When** hệ thống không thể tăng hoặc giảm thêm theo mong muốn, **Then** overlay vẫn phải phản ánh đúng trạng thái biên hiện tại thay vì hiển thị giá trị vượt phạm vi thật.

### Edge Cases

- Khi người dùng bắt đầu một gesture mới trước khi overlay của gesture trước vừa kịp tự ẩn, nội dung hiển thị phải được thay thế tại chỗ thay vì chồng thêm một overlay khác.
- Khi cùng một gesture gửi nhiều lần cập nhật liên tiếp, overlay phải cập nhật giá trị hiện tại trong cùng một vùng hiển thị thay vì nhấp nháy hoặc dựng lại nhiều thành phần rời rạc.
- Khi gesture kết thúc ở biên âm lượng tối đa, âm lượng tối thiểu, độ sáng tối đa, độ sáng tối thiểu hoặc tại vị trí không thể tua thêm, overlay phải cho thấy giá trị biên thực tế đang có hiệu lực.
- Khi thao tác bị hủy do mất focus tạm thời, đổi ứng dụng hoặc màn hình phát bị gián đoạn, overlay không được kẹt lại trên màn hình sau khi người dùng quay lại.
- Khi người dùng thực hiện các gesture ngoài phạm vi feedback của feature này, hệ thống không được hiển thị chỉ báo sai loại hoặc dùng lại nội dung từ overlay trước đó.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST hiển thị một overlay phản hồi trực quan trên màn hình phát ngay khi nhận diện thành công một gesture được hỗ trợ trong phạm vi feature này.
- **FR-002**: Hệ thống MUST hỗ trợ overlay cho bốn loại feedback trong phạm vi hiện tại: thay đổi âm lượng, thay đổi độ sáng, tua theo delta và tua nhanh tạm thời 2x.
- **FR-003**: Hệ thống MUST chỉ hiển thị một trạng thái overlay có hiệu lực tại một thời điểm và MUST cập nhật tại chỗ khi cùng gesture tiếp tục thay đổi giá trị.
- **FR-004**: Hệ thống MUST hiển thị feedback âm lượng với dấu hiệu nhận biết rõ ràng và mức hiện tại dưới dạng phần trăm dễ đọc.
- **FR-005**: Hệ thống MUST hiển thị feedback độ sáng với dấu hiệu nhận biết rõ ràng và mức hiện tại dưới dạng phần trăm dễ đọc.
- **FR-006**: Hệ thống MUST hiển thị feedback tua với hướng tua và thời lượng delta có dấu theo định dạng thời gian dễ hiểu cho người xem.
- **FR-007**: Hệ thống MUST hiển thị feedback tua nhanh tạm thời ở mức 2x trong suốt thời gian gesture nhấn giữ còn hiệu lực.
- **FR-008**: Hệ thống MUST làm cho overlay xuất hiện không quá 0,2 giây sau khi một gesture được hỗ trợ được nhận diện và MUST duy trì hiển thị trong suốt thời gian gesture đó còn hoạt động.
- **FR-009**: Hệ thống MUST tự ẩn overlay không quá 1 giây sau khi gesture hoàn tất hoặc bị hủy, trừ khi một gesture được hỗ trợ khác tiếp quản ngay lập tức.
- **FR-010**: Hệ thống MUST giữ overlay đủ dễ đọc trên nhiều nền video khác nhau và không cản trở người dùng tiếp tục thao tác trên bề mặt phát.
- **FR-011**: Hệ thống MUST phản ánh đúng trạng thái giá trị biên hiện tại khi âm lượng, độ sáng hoặc tua nội dung không thể tiếp tục thay đổi theo hướng người dùng vừa thao tác.
- **FR-012**: Hệ thống MUST bỏ qua các gesture ngoài phạm vi overlay của feature này thay vì hiển thị nhầm một chỉ báo không liên quan.

### Key Entities *(include if feature involves data)*

- **Gesture Overlay State**: Trạng thái hiển thị hiện tại của lớp phản hồi nổi, gồm loại feedback, nội dung đang hiển thị, tình trạng đang hiện hoặc chờ tự ẩn.
- **Gesture Feedback Cue**: Tín hiệu trực quan dùng để phân biệt các hành động như âm lượng, độ sáng, tua delta và tua nhanh tạm thời.
- **Gesture Display Value**: Giá trị người dùng nhìn thấy trên overlay, như phần trăm mức hiện tại hoặc thời lượng delta có dấu.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Trong kiểm thử chấp nhận cho các gesture được hỗ trợ, 100% thao tác vuốt âm lượng, vuốt độ sáng và vuốt tua hợp lệ đều hiển thị đúng loại overlay ngay ở lần nhận diện đầu tiên.
- **SC-002**: Trong 100% kịch bản kiểm thử hợp lệ, giá trị hiển thị trên overlay khớp với trạng thái phản hồi hiện tại: âm lượng và độ sáng phản ánh đúng mức biên hoặc mức đang có hiệu lực, seek phản ánh đúng hướng và delta, còn nhấn giữ phản ánh đúng trạng thái 2x trong suốt thời gian giữ.
- **SC-003**: Trong ít nhất 95% lần đo trên thiết bị mục tiêu, overlay xuất hiện trong vòng 0,2 giây sau khi gesture được nhận diện và tự ẩn trong vòng 1 giây sau khi gesture kết thúc nếu không có gesture kế tiếp.
- **SC-004**: Trong 100% chuỗi kiểm thử gồm nhiều gesture hỗ trợ liên tiếp, hệ thống chỉ hiển thị một overlay tại một thời điểm và không để lại chỉ báo cũ sau khi tương tác kết thúc.
- **SC-005**: Trong đánh giá thủ công với người dùng nội bộ lần đầu tiếp cận tính năng, ít nhất 90% người tham gia nhận biết đúng loại hành động đang diễn ra chỉ dựa trên overlay mà không cần mở thêm cụm điều khiển phát.

## Assumptions

- Feature này áp dụng cho màn hình phát video cảm ứng trên điện thoại ở ngữ cảnh xem toàn màn hình hoặc gần toàn màn hình.
- Phạm vi hiện tại chỉ bao gồm overlay cho vuốt đổi âm lượng, vuốt đổi độ sáng, vuốt tua theo delta và nhấn giữ tua nhanh tạm thời 2x; feedback cho double tap và pinch không nằm trong feature này.
- Màn hình phát đã có sẵn nguồn dữ liệu đủ để suy ra mức âm lượng, mức độ sáng và delta tua cần hiển thị cho người dùng.
- Mức âm lượng và độ sáng có thể được biểu diễn dưới dạng phần trăm dễ hiểu mà không yêu cầu người dùng biết thang đo kỹ thuật của thiết bị.
- Một khoảng trễ tự ẩn ngắn sau khi gesture kết thúc là chấp nhận được nếu overlay vẫn biến mất đủ nhanh để không che nội dung xem kế tiếp.