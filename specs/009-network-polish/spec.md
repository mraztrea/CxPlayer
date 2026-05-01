# Feature Specification: Network Polish

**Feature Branch**: `[010-network-polish]`  
**Created**: 2026-05-01  
**Status**: Draft  
**Input**: User description: "Thực hiện plan @file:phase-4-network-polish.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Phát video mạng nội bộ ổn định (Priority: P1)

Người xem muốn mở video từ nguồn mạng nội bộ như liên kết mạng gia đình hoặc thư mục chia sẻ trong cùng mạng, để xem nội dung có bitrate cao mà không bị giật, chờ quá lâu hoặc mất kết nối khi đang xem.

**Why this priority**: Đây là giá trị cốt lõi của phase này. Nếu việc phát nội dung qua mạng nội bộ chưa ổn định, các cải tiến còn lại chỉ là bổ trợ và không giải quyết nhu cầu xem chính.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở một video dung lượng lớn qua liên kết mạng nội bộ hoặc từ thư mục chia sẻ trong LAN, xác nhận nội dung bắt đầu phát nhanh, tiếp tục ổn định và người dùng vẫn điều hướng được nguồn nội dung mạng.

**Acceptance Scenarios**:

1. **Given** người dùng có một video khả dụng qua mạng nội bộ, **When** họ mở video đó trong ứng dụng, **Then** video phải bắt đầu phát mà không yêu cầu sao chép file về máy trước.
2. **Given** người dùng đang xem một video bitrate cao qua mạng nội bộ ổn định, **When** quá trình phát tiếp diễn trong điều kiện mạng LAN bình thường, **Then** video phải duy trì phát liên tục mà không bị ngắt quãng bất thường.
3. **Given** người dùng cần truy cập thư mục chia sẻ trong mạng, **When** họ nhập thông tin truy cập hợp lệ và duyệt nội dung, **Then** hệ thống phải hiển thị danh sách thư mục hoặc video để họ chọn phát trực tiếp.

---

### User Story 2 - Tiếp tục xem hoặc nghe khi rời ứng dụng (Priority: P2)

Người xem muốn tiếp tục theo dõi nội dung khi rời màn hình phát chính, như nhấn Home để xem ở cửa sổ thu nhỏ hoặc tắt màn hình để tiếp tục nghe audio, để không bị buộc phải dừng nội dung giữa chừng.

**Why this priority**: Sau khi phát mạng nội bộ ổn định, nhu cầu kế tiếp là duy trì trải nghiệm xem nghe liên tục khi người dùng chuyển ngữ cảnh trên thiết bị.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát một video, nhấn Home để vào chế độ cửa sổ thu nhỏ, sau đó thử khóa màn hình với nội dung phù hợp để xác nhận âm thanh vẫn tiếp tục.

**Acceptance Scenarios**:

1. **Given** người dùng đang phát video và thiết bị hỗ trợ cửa sổ thu nhỏ, **When** họ rời ứng dụng bằng thao tác hệ thống tiêu chuẩn, **Then** nội dung phải có thể tiếp tục trong chế độ xem thu nhỏ thay vì dừng đột ngột.
2. **Given** người dùng đang nghe nội dung có audio đang phát, **When** họ tắt màn hình hoặc đưa ứng dụng xuống nền, **Then** audio phải tiếp tục phát nếu người dùng chưa chủ động dừng nội dung.
3. **Given** người dùng quay lại màn hình phát từ trạng thái thu nhỏ hoặc nền, **When** ứng dụng trở lại foreground, **Then** trạng thái phát phải được giữ nguyên và điều khiển phát phải phản ánh đúng trạng thái hiện tại.

---

### User Story 3 - Giữ hành vi phát phù hợp với ngữ cảnh thiết bị (Priority: P3)

Người xem muốn ứng dụng tự ứng xử hợp lý khi phát nội dung mạng, như giữ kết nối cần thiết trong lúc xem và tránh xoay màn hình ngoài ý muốn, để trải nghiệm xem ổn định hơn trên điện thoại và tablet.

**Why this priority**: Đây là lớp polish giúp feature hoạt động đáng tin cậy hơn trong sử dụng thực tế, đặc biệt với phiên xem dài hoặc khi người dùng thay đổi tư thế cầm máy.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát nội dung mạng trong thời gian dài, thay đổi hướng cầm thiết bị và xác nhận ứng dụng giữ được trạng thái phát cũng như hành vi xoay màn hình theo lựa chọn của người dùng.

**Acceptance Scenarios**:

1. **Given** người dùng đang phát nội dung từ nguồn mạng, **When** phiên xem kéo dài trong trạng thái thiết bị nhàn rỗi nhưng vẫn đang phát, **Then** ứng dụng phải duy trì đủ tài nguyên thiết bị để không làm phiên phát bị rớt ngoài ý muốn.
2. **Given** người dùng đã khóa hoặc chọn hướng màn hình mong muốn cho phiên xem, **When** họ thay đổi tư thế cầm thiết bị, **Then** màn hình phải giữ theo lựa chọn đó cho đến khi người dùng thay đổi lại.
3. **Given** người dùng đang xem video từ nguồn cục bộ hoặc nguồn mạng, **When** trạng thái khóa xoay hoặc tự xoay thay đổi, **Then** trải nghiệm phát không được bị reset hoặc mất vị trí xem hiện tại.

### Edge Cases

- Khi thông tin truy cập mạng nội bộ sai hoặc thiếu, hệ thống phải báo rõ không thể truy cập nguồn nội dung thay vì hiển thị danh sách rỗng khó hiểu.
- Khi thư mục chia sẻ truy cập được nhưng không chứa video tương thích, người dùng phải nhận được trạng thái rõ ràng rằng không có nội dung có thể phát.
- Khi kết nối mạng nội bộ suy yếu trong lúc đang phát, phiên xem phải phản hồi theo cách dễ hiểu và không làm ứng dụng treo hoặc thoát đột ngột.
- Khi thiết bị không hỗ trợ chế độ cửa sổ thu nhỏ, thao tác rời ứng dụng không được gây lỗi hoặc khiến phát dừng theo cách khó đoán.
- Khi người dùng chỉ muốn nghe audio ở nền nhưng nội dung đã bị tạm dừng trước đó, hệ thống không được tự phát lại ngoài ý muốn.
- Khi người dùng đang khóa hướng màn hình rồi vào hoặc thoát chế độ cửa sổ thu nhỏ, lựa chọn hướng màn hình trước đó phải được giữ nhất quán sau khi quay lại.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST cho phép người dùng phát trực tiếp video từ nguồn mạng nội bộ mà không yêu cầu tải toàn bộ file về thiết bị trước khi xem.
- **FR-002**: Hệ thống MUST tối ưu trải nghiệm mở và phát nội dung mạng nội bộ để phù hợp với video bitrate cao trong môi trường LAN ổn định.
- **FR-003**: Hệ thống MUST phân biệt được nguồn nội dung mạng và nguồn nội dung cục bộ để áp dụng hành vi phát phù hợp cho từng loại nguồn.
- **FR-004**: Hệ thống MUST cho phép người dùng nhập thông tin truy cập đến thư mục chia sẻ mạng và duyệt danh sách thư mục hoặc video mà họ có quyền xem.
- **FR-005**: Hệ thống MUST cho phép người dùng chọn một video từ thư mục chia sẻ mạng và phát trực tiếp video đó trong ứng dụng.
- **FR-006**: Hệ thống MUST hiển thị lỗi theo cách dễ hiểu khi không thể truy cập nguồn mạng, xác thực thất bại hoặc nguồn nội dung không còn sẵn sàng.
- **FR-007**: Hệ thống MUST duy trì đủ tài nguyên thiết bị trong lúc phát nguồn mạng để giảm nguy cơ phiên phát bị ngắt do thiết bị tự đưa kết nối hoặc xử lý về trạng thái tiết kiệm.
- **FR-008**: Hệ thống MUST cho phép người dùng tiếp tục xem nội dung trong chế độ cửa sổ thu nhỏ khi họ rời ứng dụng trong lúc video còn đang phát trên thiết bị có hỗ trợ.
- **FR-009**: Hệ thống MUST cho phép audio tiếp tục phát khi ứng dụng chuyển xuống nền hoặc màn hình tắt, miễn là người dùng chưa chủ động dừng phát.
- **FR-010**: Hệ thống MUST giữ nguyên trạng thái phát hiện tại khi người dùng chuyển giữa màn hình đầy đủ, chế độ thu nhỏ và phát nền.
- **FR-011**: Hệ thống MUST cho phép người dùng bật tự xoay hoặc khóa hướng màn hình cho phiên xem hiện tại.
- **FR-012**: Hệ thống MUST áp dụng lựa chọn hướng màn hình của người dùng mà không làm mất vị trí phát hoặc khởi tạo lại phiên xem ngoài ý muốn.
- **FR-013**: Hệ thống MUST thể hiện rõ khi thiết bị hoặc ngữ cảnh hiện tại không hỗ trợ một khả năng như cửa sổ thu nhỏ, thay vì làm thao tác thất bại im lặng.
- **FR-014**: Hệ thống MUST giữ phạm vi feature này trong các khả năng phát mạng nội bộ, duyệt thư mục chia sẻ mạng, phát nền, cửa sổ thu nhỏ và kiểm soát hướng màn hình; đồng bộ phụ đề, playlist mới và các tính năng thư viện nội dung khác nằm ngoài phạm vi của feature này.

### Key Entities *(include if feature involves data)*

- **Network Source**: Một nguồn nội dung đến từ mạng nội bộ, có thể là liên kết trực tiếp hoặc thư mục chia sẻ mà người dùng có thể truy cập để phát video.
- **Network Credential Set**: Tập thông tin truy cập mà người dùng cung cấp để mở thư mục chia sẻ mạng, bao gồm địa chỉ nguồn và thông tin xác thực cần thiết.
- **Shared Library Entry**: Một mục thư mục hoặc video hiển thị cho người dùng khi duyệt nguồn chia sẻ mạng.
- **Playback Continuity State**: Trạng thái xác định nội dung hiện tại đang phát ở màn hình chính, cửa sổ thu nhỏ hay nền, cùng vị trí phát liên quan.
- **Orientation Preference**: Lựa chọn hiện hành của người dùng về tự xoay hoặc khóa hướng trong phiên xem.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Trong ít nhất 95% kịch bản kiểm thử với video LAN hợp lệ, nội dung bắt đầu phát trong vòng 5 giây kể từ khi người dùng xác nhận mở video.
- **SC-002**: Trong ít nhất 90% phiên kiểm thử kéo dài 10 phút với video LAN bitrate cao trên mạng nội bộ ổn định, số lần gián đoạn phát do ứng dụng xử lý không vượt quá một lần mỗi phiên.
- **SC-003**: Trong 100% kịch bản kiểm thử với thông tin truy cập thư mục chia sẻ hợp lệ, người dùng duyệt được đến danh sách nội dung khả dụng và có thể bắt đầu phát video đã chọn mà không phải rời khỏi ứng dụng.
- **SC-004**: Trong 100% kịch bản kiểm thử trên thiết bị hỗ trợ, người dùng đang phát video có thể chuyển sang chế độ cửa sổ thu nhỏ bằng thao tác hệ thống tiêu chuẩn mà không mất phiên phát hiện tại.
- **SC-005**: Trong ít nhất 95% kịch bản kiểm thử phát nền hợp lệ, audio tiếp tục phát trong ít nhất 15 phút sau khi ứng dụng xuống nền hoặc màn hình tắt nếu người dùng chưa dừng nội dung.
- **SC-006**: Trong 100% kịch bản kiểm thử thay đổi hướng màn hình khi đang phát, lựa chọn khóa xoay hoặc tự xoay được giữ đúng và vị trí phát không bị mất.

## Assumptions

- Người dùng sử dụng feature này chủ yếu trong cùng một mạng nội bộ ổn định, nơi thiết bị phát có quyền truy cập tới các nguồn chia sẻ cần thiết.
- Các nguồn chia sẻ mạng mục tiêu đã tồn tại sẵn và người dùng biết hoặc có thể được cung cấp thông tin truy cập hợp lệ để mở chúng.
- Thiết bị mục tiêu có thể khác nhau về mức hỗ trợ cửa sổ thu nhỏ và hành vi phát nền, nên ứng dụng cần phản hồi theo khả năng thực tế của thiết bị.
- Feature tập trung vào phát trực tiếp và tính liên tục của trải nghiệm xem nghe, không bao gồm quản lý thư viện mạng dài hạn hoặc lưu trữ vĩnh viễn thông tin truy cập.
- Khi người dùng khóa hướng màn hình, lựa chọn đó được hiểu là áp dụng cho phiên xem hiện tại thay vì là cài đặt toàn cục cho toàn bộ ứng dụng.