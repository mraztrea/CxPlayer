# Feature Specification: Playback Screen Layout

**Feature Branch**: `[003-player-layout]`  
**Created**: 2026-04-30  
**Status**: Draft  
**Input**: User description: "thực hiện \"1.4 Layout\" trong phase-1-core-player.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - See Video and Core Controls Immediately (Priority: P1)

Người xem mở màn hình phát và ngay lập tức thấy vùng hiển thị video chiếm ưu tiên, kèm các khu vực điều khiển chính ở vị trí quen thuộc để có thể tiếp tục xem mà không cần dò tìm giao diện.

**Why this priority**: Nếu bố cục màn hình phát không rõ ràng ngay từ lần mở đầu tiên, mọi tính năng điều khiển ở các bước sau đều mất giá trị sử dụng.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở một video hợp lệ và xác nhận màn hình phát hiển thị đầy đủ vùng xem, khu vực tiến trình và cụm điều khiển chính mà không cần thao tác thiết lập bổ sung.

**Acceptance Scenarios**:

1. **Given** người dùng mở một video hợp lệ, **When** màn hình phát xuất hiện, **Then** vùng hiển thị video chiếm phần lớn màn hình và các khu vực điều khiển trên cùng và dưới cùng xuất hiện rõ ràng.
2. **Given** thông tin thời lượng và vị trí phát đã có sẵn, **When** khu vực điều khiển được hiển thị, **Then** thời gian hiện tại, thanh tiến trình, thời lượng tổng và các hành động điều khiển chính được nhóm lại ở nửa dưới màn hình theo thứ tự nhất quán.

---

### User Story 2 - Understand Context and Leave Quickly (Priority: P2)

Người xem cần biết mình đang xem nội dung nào và có thể quay lại hoặc mở hành động phụ mà không bị mất định hướng trên màn hình phát.

**Why this priority**: Điều hướng và ngữ cảnh nội dung giúp người dùng tự tin sử dụng player, nhất là khi mở video từ file manager hoặc liên kết ngoài.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở video có và không có tiêu đề rồi xác nhận khu vực trên cùng luôn giữ được hành động quay lại, nhãn ngữ cảnh và điểm vào cho hành động phụ.

**Acceptance Scenarios**:

1. **Given** video có tiêu đề hiển thị được, **When** màn hình phát mở ra, **Then** khu vực trên cùng hiển thị nút quay lại, tiêu đề nội dung và điểm vào cho hành động phụ mà không làm che khuất toàn bộ vùng xem.
2. **Given** tiêu đề nội dung bị thiếu hoặc quá dài, **When** khu vực trên cùng được hiển thị, **Then** điều hướng và hành động phụ vẫn truy cập được, đồng thời nhãn nội dung xuống cấp hiển thị một cách gọn gàng mà không phá vỡ bố cục.

---

### User Story 3 - Keep the Layout Usable Across Screen Changes (Priority: P3)

Người xem xoay màn hình hoặc dùng thiết bị có chiều cao hiển thị hạn chế nhưng vẫn có thể thấy và chạm vào mọi điều khiển chính mà không bị chồng lấn hoặc cắt mất thành phần.

**Why this priority**: Player là màn hình sử dụng lâu; bố cục không ổn định khi đổi chiều màn hình sẽ làm gián đoạn trải nghiệm xem.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở video, chuyển giữa chế độ dọc và ngang, rồi xác nhận mọi khu vực điều khiển chính vẫn hiển thị đầy đủ và còn thao tác được.

**Acceptance Scenarios**:

1. **Given** màn hình phát đang ở chế độ dọc, **When** người dùng xoay sang chế độ ngang, **Then** vùng hiển thị video và toàn bộ điều khiển chính vẫn nằm trong vùng nhìn thấy mà không bị cắt hoặc chồng lấn.
2. **Given** thiết bị có chiều cao hiển thị hạn chế, **When** người dùng hiển thị các điều khiển, **Then** các hành động thiết yếu vẫn còn dễ chạm và bố cục không đẩy thành phần quan trọng ra ngoài vùng nhìn thấy.

### Edge Cases

- Khi tiêu đề nội dung không có hoặc dài bất thường: Khu vực trên cùng vẫn phải ưu tiên điều hướng và không để văn bản đẩy mất hành động chính.
- Khi thời lượng hoặc vị trí phát chưa sẵn sàng ở thời điểm mở màn hình: Khu vực tiến trình vẫn giữ cấu trúc ổn định và không làm nhảy vị trí các nút điều khiển.
- Khi chiều cao hiển thị bị giới hạn: Cụm điều khiển dưới cùng vẫn phải hiển thị đầy đủ và không che phủ hoàn toàn vùng xem video.
- Khi hành động phụ chưa có nội dung cụ thể: Điểm vào hành động phụ không được để lại khoảng trống khó hiểu trong thanh trên cùng.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST trình bày màn hình phát với vùng hiển thị video là khu vực chiếm ưu thế về diện tích và mức độ tập trung thị giác.
- **FR-002**: Hệ thống MUST cung cấp một khu vực ngữ cảnh ở phía trên gồm hành động quay lại, nhãn nội dung đang phát và điểm vào cho hành động phụ khi các điều khiển được hiển thị.
- **FR-003**: Hệ thống MUST cung cấp một khu vực tiến trình ở nửa dưới màn hình, nhóm thời gian hiện tại, chỉ báo tiến trình và thời lượng tổng trong cùng một cụm thông tin.
- **FR-004**: Hệ thống MUST cung cấp một cụm điều khiển chính gồm tua lùi, phát hoặc tạm dừng, tua tiến, âm thanh và cài đặt theo thứ tự ổn định, dễ dự đoán.
- **FR-005**: Hệ thống MUST tách biệt rõ ràng về mặt thị giác giữa vùng xem video và các lớp điều khiển, đồng thời tránh làm mất vĩnh viễn không gian xem chính.
- **FR-006**: Hệ thống MUST giữ cho mọi hành động chính còn nhìn thấy và thao tác được trên các bố cục điện thoại hỗ trợ ở cả chế độ dọc và ngang, không bị cắt, chồng lấn hoặc mơ hồ thứ tự ưu tiên.
- **FR-007**: Hệ thống MUST bảo toàn khả năng truy cập điều hướng và hành động phụ ngay cả khi nhãn nội dung bị thiếu hoặc vượt quá chiều rộng sẵn có.
- **FR-008**: Hệ thống MUST duy trì bố cục ổn định của khu vực tiến trình và cụm điều khiển ngay cả khi thông tin thời gian phát chưa sẵn sàng.
- **FR-009**: Hệ thống MUST duy trì vị trí xuất hiện nhất quán của các nhóm điều khiển chính giữa các lần mở màn hình để người dùng không phải học lại giao diện.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Trong kiểm thử chấp nhận trên toàn bộ bố cục điện thoại được hỗ trợ, 100% lần mở màn hình phát hiển thị đầy đủ vùng xem video, khu vực trên cùng, khu vực tiến trình và cụm điều khiển chính mà không bị cắt thành phần.
- **SC-002**: Ít nhất 90% người dùng thử lần đầu có thể xác định nút quay lại, nhãn nội dung và nút phát hoặc tạm dừng trong vòng 3 giây sau khi mở màn hình phát.
- **SC-003**: Trong kiểm thử xoay màn hình, người dùng có thể tiếp tục chạm vào bất kỳ điều khiển chính nào trong vòng 2 giây sau khi đổi chiều hiển thị mà không cần thao tác khôi phục bố cục.
- **SC-004**: Trong 100% kịch bản tiêu đề dài, thiếu tiêu đề hoặc thiếu thời lượng ban đầu, bố cục vẫn giữ được điều hướng nhìn thấy, cụm điều khiển ổn định và không có phần tử chồng lấn nhau.

## Assumptions

- Phạm vi của mục 1.4 chỉ bao gồm bố cục và cách sắp xếp thành phần trên màn hình phát; logic hành vi của từng nút được xử lý ở các mục tiếp theo của Phase 1.
- Phase 1 ưu tiên bố cục cho điện thoại ở chế độ dọc và ngang; các tối ưu riêng cho tablet hoặc multi-window nằm ngoài phạm vi đặc tả này.
- Màn hình phát có thể nhận được nhãn nội dung dễ đọc khi nguồn phát cung cấp thông tin; nếu không có, một nhãn thay thế trung tính là chấp nhận được.
- Hành động phụ ở giai đoạn này được gom vào một điểm vào duy nhất thay vì hiển thị nhiều hành động nâng cao cùng lúc.