# Feature Specification: Subtitle Manager

**Feature Branch**: `[008-subtitle-manager]`  
**Created**: 2026-04-30  
**Status**: Draft  
**Input**: User description: "Thực hiện task \"3.2 SubtitleManager\" trong kế hoạch @file:phase-3-advanced-media.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Xem video kèm phụ đề ngoài ngay lập tức (Priority: P1)

Người xem muốn mở video và thấy phụ đề ngoài hiển thị ngay nếu đã có file phụ đề phù hợp đi kèm, hoặc có thể nạp phụ đề ngoài trong lúc xem mà không phải thoát ra mở lại video.

**Why this priority**: Đây là giá trị trực tiếp nhất của SubtitleManager. Nếu ứng dụng chưa giúp người dùng xem được video với phụ đề ngoài theo cách nhanh và ít thao tác, phần subtitle của phase này chưa tạo ra lợi ích rõ ràng.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở một video có file phụ đề cùng tên đặt cạnh video, hoặc chọn một file phụ đề ngoài hợp lệ trong lúc phát, rồi xác nhận phụ đề xuất hiện trong phiên xem hiện tại mà không làm gián đoạn phát video.

**Acceptance Scenarios**:

1. **Given** người dùng mở một video có sẵn một file phụ đề cùng tên trong thư mục lân cận và thuộc định dạng được hỗ trợ, **When** phiên xem bắt đầu, **Then** phụ đề phải được bật tự động trong chính phiên phát đó.
2. **Given** người dùng đang xem một video chưa có phụ đề đang hoạt động, **When** người dùng chọn một file phụ đề ngoài hợp lệ, **Then** phụ đề phải xuất hiện mà không buộc người dùng mở lại video.

---

### User Story 2 - Chọn đúng nguồn phụ đề cần xem (Priority: P2)

Người xem muốn chuyển giữa phụ đề ngoài, phụ đề nhúng trong video và trạng thái tắt phụ đề để chọn đúng nội dung phù hợp với ngôn ngữ và sở thích xem của mình.

**Why this priority**: Sau khi phụ đề có thể được nạp vào, người dùng cần quyền kiểm soát nguồn phụ đề đang hiển thị. Nếu không thể chuyển đổi rõ ràng, trải nghiệm subtitle sẽ nhanh chóng trở nên khó dùng khi video có nhiều lựa chọn.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát một video có cả phụ đề nhúng và phụ đề ngoài, rồi lần lượt chuyển giữa từng lựa chọn và trạng thái tắt phụ đề để xác nhận nội dung hiển thị đổi đúng theo lựa chọn mới.

**Acceptance Scenarios**:

1. **Given** video hiện có nhiều lựa chọn phụ đề khả dụng, **When** người dùng chọn một nguồn phụ đề khác, **Then** hệ thống phải chuyển sang nguồn mới trong phiên xem hiện tại.
2. **Given** một phụ đề đang hiển thị, **When** người dùng chọn tắt phụ đề, **Then** toàn bộ chữ trên màn hình phải biến mất nhưng video vẫn tiếp tục phát bình thường.

---

### User Story 3 - Tùy chỉnh phụ đề để dễ đọc hơn (Priority: P3)

Người xem muốn điều chỉnh cách hiển thị phụ đề như kích thước chữ, độ đậm, màu chữ và kiểu viền để đọc rõ trên nhiều loại nội dung sáng hoặc tối khác nhau.

**Why this priority**: Phụ đề chỉ hữu ích khi người dùng đọc được thoải mái. Tùy chỉnh hiển thị giúp feature phục vụ nhiều điều kiện xem thực tế hơn mà không làm thay đổi nội dung video.

**Independent Test**: Có thể kiểm thử độc lập bằng cách bật một phụ đề đang hiển thị, thay đổi từng thiết lập hiển thị chính và xác nhận kết quả trên màn hình đổi ngay trong phiên xem hiện tại.

**Acceptance Scenarios**:

1. **Given** phụ đề đang hiển thị trên video, **When** người dùng thay đổi một thiết lập kiểu chữ được hỗ trợ, **Then** phụ đề phải cập nhật theo kiểu mới ngay trong lúc phát.
2. **Given** người dùng đang xem một cảnh có nền sáng hoặc tương phản thấp, **When** người dùng áp dụng màu chữ hoặc kiểu viền phù hợp hơn, **Then** phụ đề phải trở nên dễ đọc hơn mà không che khuất nội dung chính một cách quá mức.

### Edge Cases

- Khi không tồn tại file phụ đề cùng tên cạnh video, ứng dụng không được trì hoãn phát video chỉ vì quá trình tự dò phụ đề không tìm thấy kết quả.
- Khi file phụ đề ngoài bị lỗi, sai định dạng hoặc không đọc được, video vẫn phải tiếp tục xem được và người dùng vẫn có thể thử chọn nguồn phụ đề khác hoặc tắt phụ đề.
- Khi video đồng thời có phụ đề nhúng và một phụ đề ngoài được nạp thêm, hệ thống phải chỉ giữ một nguồn phụ đề hoạt động tại một thời điểm để tránh chồng chữ.
- Khi người dùng tắt phụ đề sau khi hệ thống đã tự dò được phụ đề ngoài, lựa chọn tắt phải được tôn trọng cho tới khi người dùng chủ động chọn lại một nguồn phụ đề.
- Khi thư mục cạnh video có nhiều file phụ đề khác tên gốc hoặc có hậu tố ngôn ngữ khác nhau, hệ thống không được tự chọn sai một file không khớp tên cơ bản của video.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST cho phép người dùng nạp phụ đề ngoài cho video đang xem bằng các định dạng phụ đề phổ biến nằm trong phạm vi feature này, bao gồm SRT, ASS/SSA và VTT.
- **FR-002**: Hệ thống MUST tự dò và kích hoạt phụ đề ngoài khi người dùng mở video có một file phụ đề nằm cạnh video và trùng tên cơ bản với video trong một định dạng được hỗ trợ.
- **FR-003**: Hệ thống MUST không chặn hoặc làm hỏng phiên phát khi không tìm thấy phụ đề tự dò hoặc khi người dùng không chọn phụ đề ngoài.
- **FR-004**: Hệ thống MUST hỗ trợ sử dụng các track phụ đề đã nhúng sẵn trong video nếu video cung cấp các lựa chọn này.
- **FR-005**: Hệ thống MUST cho phép người dùng chọn nguồn phụ đề đang hoạt động giữa phụ đề ngoài, phụ đề nhúng khả dụng và trạng thái tắt phụ đề.
- **FR-006**: Hệ thống MUST áp dụng thay đổi lựa chọn phụ đề ngay trong phiên xem hiện tại mà không yêu cầu người dùng đóng và mở lại video.
- **FR-007**: Hệ thống MUST đảm bảo tại mọi thời điểm chỉ có một nguồn phụ đề hoạt động trên màn hình.
- **FR-008**: Hệ thống MUST cho phép người dùng điều chỉnh kiểu hiển thị phụ đề, tối thiểu gồm kích thước chữ, độ đậm, màu chữ và cách tạo viền hoặc độ nổi để tăng khả năng đọc.
- **FR-009**: Hệ thống MUST áp dụng thay đổi kiểu hiển thị phụ đề ngay lên phụ đề đang xuất hiện trong phiên xem hiện tại.
- **FR-010**: Hệ thống MUST giữ video ở trạng thái xem được khi file phụ đề ngoài không hợp lệ, không được hỗ trợ hoặc không thể đọc, đồng thời không làm mất khả năng chọn một nguồn phụ đề khác.
- **FR-011**: Hệ thống MUST giới hạn tự dò phụ đề vào các file cùng tên cơ bản với video; các file phụ đề khác trong cùng thư mục nhưng không khớp tên cơ bản chỉ được dùng khi người dùng tự chọn.
- **FR-012**: Hệ thống MUST giới hạn phạm vi feature này ở quản lý và hiển thị phụ đề cho một video đang mở; chọn audio track, playlist, shuffle và cơ chế giải mã media nằm ngoài phạm vi của feature.

### Key Entities *(include if feature involves data)*

- **Video Playback Item**: Nội dung video mà người dùng đang xem, là ngữ cảnh gắn với toàn bộ lựa chọn phụ đề của phiên phát hiện tại.
- **Subtitle Source**: Một nguồn phụ đề khả dụng cho video, có thể là phụ đề ngoài, phụ đề nhúng hoặc trạng thái tắt phụ đề.
- **Subtitle Selection State**: Trạng thái hiện hành xác định nguồn phụ đề nào đang được hiển thị trên màn hình ở thời điểm hiện tại.
- **Subtitle Presentation Preference**: Tập thiết lập hiển thị mà người dùng điều chỉnh để phụ đề dễ đọc hơn, gồm kích thước, độ đậm, màu và cách tạo viền/độ nổi.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Trong bộ kiểm thử đại diện cho các video có file phụ đề cùng tên hợp lệ, ít nhất 95% trường hợp hiển thị phụ đề tự động trong vòng 2 giây kể từ khi video bắt đầu phát.
- **SC-002**: Trong 100% kịch bản kiểm thử có nhiều lựa chọn phụ đề, người dùng chuyển được giữa một nguồn phụ đề khả dụng khác hoặc trạng thái tắt trong không quá 3 thao tác và thấy kết quả thay đổi trong vòng 2 giây.
- **SC-003**: Trong ít nhất 95% mẫu phụ đề ngoài hợp lệ thuộc phạm vi hỗ trợ của feature, phụ đề hiển thị đủ rõ để người đánh giá theo dõi được lời thoại ngay từ dòng xuất hiện đầu tiên sau khi bật phụ đề.
- **SC-004**: Trong 100% kịch bản dùng file phụ đề lỗi, hỏng hoặc ngoài phạm vi hỗ trợ, video vẫn tiếp tục xem được và người dùng vẫn có thể tắt phụ đề hoặc chọn lại nguồn phụ đề khác mà không cần khởi động lại ứng dụng.
- **SC-005**: Trong kiểm thử khả dụng nội bộ, ít nhất 90% người tham gia có thể tự điều chỉnh phụ đề thành trạng thái dễ đọc trên cả nền sáng và nền tối trong vòng 30 giây.

## Assumptions

- Feature này áp dụng cho trải nghiệm xem một video tại một thời điểm; các tính năng playlist, next/previous, shuffle và audio track selector sẽ được xử lý ở feature khác.
- Tự dò phụ đề chỉ áp dụng cho file phụ đề nằm cạnh video và trùng tên cơ bản với video; các biến thể tên có hậu tố ngôn ngữ hoặc quy ước đặt tên khác không thuộc phạm vi tự dò mặc định của phiên bản này.
- Người dùng có thể truy cập và chọn các file phụ đề ngoài mà ứng dụng đã được cấp quyền đọc trong ngữ cảnh sử dụng hiện tại.
- Một phiên xem chỉ cần một nguồn phụ đề hoạt động cùng lúc; việc hiển thị nhiều lớp phụ đề đồng thời không thuộc phạm vi feature.
- Feature này chỉ yêu cầu thay đổi kiểu hiển thị có hiệu lực ngay trong phiên xem hiện tại; đồng bộ cài đặt giữa nhiều thiết bị hoặc nhiều hồ sơ người dùng không nằm trong phạm vi.