# Feature Specification: FFmpeg Integration

**Feature Branch**: `[007-ffmpeg-integration]`  
**Created**: 2026-04-30  
**Status**: Draft  
**Input**: User description: "thực hiện task \"3.1 FFmpeg Integration\" trong plan @file:phase-3-advanced-media.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Mở được phim có codec nâng cao (Priority: P1)

Người xem muốn mở các file phim dùng codec âm thanh hoặc video nâng cao mà vẫn xem được ngay trong ứng dụng, thay vì gặp tình trạng có hình không tiếng, bị báo không phát được hoặc phải đổi sang trình phát khác.

**Why this priority**: Đây là giá trị cốt lõi của task 3.1. Nếu các file phim phổ biến trong thư viện cá nhân vẫn không phát được, phase Advanced Media chưa mang lại lợi ích rõ ràng cho người dùng.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở các file mẫu thuộc phạm vi codec mục tiêu như AC3, EAC3, DTS, DTS-HD, TrueHD, FLAC hoặc file H.265 cần đường phát thay thế, rồi xác nhận video bắt đầu phát với âm thanh và hình ảnh dùng được mà không cần thao tác cấu hình thêm.

**Acceptance Scenarios**:

1. **Given** người dùng mở một file MKV có track âm thanh DTS hoặc AC3 thuộc phạm vi hỗ trợ của feature, **When** ứng dụng bắt đầu phiên phát, **Then** người dùng phải nghe được âm thanh và xem được hình ảnh mà không cần chuyển sang ứng dụng khác.
2. **Given** người dùng mở một file H.265 hoặc H.264 mà thiết bị không phát ổn định bằng đường giải mã mặc định nhưng vẫn thuộc phạm vi hỗ trợ của feature, **When** ứng dụng xác lập phiên phát, **Then** video phải phát được trong cùng trải nghiệm xem hiện tại mà không yêu cầu người dùng bật chế độ thủ công.

---

### User Story 2 - Không làm hỏng các file đang phát tốt (Priority: P2)

Người xem muốn những file vốn phát ổn định từ trước vẫn hoạt động như cũ sau khi bổ sung khả năng tương thích mới, để họ không phải đánh đổi độ ổn định khi xem những định dạng thông dụng.

**Why this priority**: Mở rộng tương thích chỉ có giá trị khi không gây hồi quy cho các luồng phát hiện tại. Đây là điều kiện để phát hành an toàn.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát lại bộ mẫu hồi quy gồm các file MP4, MKV hoặc media hiện đang hoạt động tốt, rồi xác nhận thời gian bắt đầu phát, khả năng seek và điều khiển phát không xấu đi theo cách người dùng nhận thấy được.

**Acceptance Scenarios**:

1. **Given** người dùng mở một file media thông dụng đã phát tốt trong phiên bản hiện tại, **When** phiên phát được khởi tạo sau khi feature này được bật, **Then** file đó vẫn phải phát được mà không xuất hiện thêm bước xác nhận hay lựa chọn chế độ giải mã.
2. **Given** một file đang phát bình thường bằng đường tương thích sẵn có, **When** người dùng thực hiện các thao tác phát cơ bản như tạm dừng, tiếp tục và tua, **Then** trải nghiệm điều khiển phải tiếp tục hoạt động theo cách nhất quán với bản hiện tại.

---

### User Story 3 - Thất bại có kiểm soát khi file vẫn ngoài phạm vi (Priority: P3)

Người xem muốn ứng dụng phản hồi dứt khoát khi một file vẫn không thể phát được, để họ biết đây là giới hạn của file hoặc nguồn media chứ không phải ứng dụng bị treo vô thời hạn.

**Why this priority**: Feature này mở rộng đáng kể phạm vi phát được nhưng không thể bao phủ mọi file hỏng hoặc mọi codec ngoài phạm vi. Trạng thái thất bại có kiểm soát giúp trải nghiệm tin cậy hơn.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở file hỏng, file có codec ngoài phạm vi hoặc file không có đường phát khả dụng, rồi xác nhận ứng dụng không crash, không kẹt loading kéo dài và trả về trạng thái không phát được nhất quán.

**Acceptance Scenarios**:

1. **Given** người dùng mở một file có stream hỏng hoặc codec nằm ngoài phạm vi hỗ trợ của phase này, **When** ứng dụng xác định không thể phát file, **Then** ứng dụng phải kết thúc nỗ lực phát trong trạng thái ổn định thay vì treo hoặc tự thử lặp vô hạn.
2. **Given** người dùng vừa phát thành công một file thuộc phạm vi hỗ trợ rồi chuyển sang một file không thể phát, **When** file thứ hai thất bại, **Then** ứng dụng phải giữ giao diện phát ở trạng thái dùng được để người dùng có thể quay lại hoặc mở file khác ngay.

### Edge Cases

- Khi file có video đọc được nhưng track âm thanh chính chỉ phát được qua đường tương thích mở rộng, phiên phát vẫn phải cho ra âm thanh thay vì coi như phát thành công trong trạng thái im lặng.
- Khi file dùng codec vẫn nằm ngoài phạm vi feature hoặc bị hỏng cấu trúc container, ứng dụng không được crash, không được treo loading vô thời hạn và không được làm hỏng phiên phát kế tiếp.
- Khi người dùng mở liên tiếp một file cần tương thích mở rộng rồi một file thông dụng đang được hỗ trợ sẵn, phiên phát thứ hai vẫn phải khởi tạo bình thường mà không cần khởi động lại ứng dụng.
- Khi một file đã có đường phát khả dụng sẵn từ trước, hệ thống không được buộc người dùng xác nhận thủ công hay thay đổi cài đặt chỉ để tiếp tục xem file đó.
- Khi file có độ dài lớn hoặc bitrate cao nhưng vẫn nằm trong phạm vi định dạng mục tiêu, ứng dụng phải ưu tiên kết quả phát ổn định thay vì từ chối chỉ vì đường phát mặc định không dùng được.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST mở rộng khả năng phát cho các file media có codec âm thanh hoặc video nâng cao thuộc phạm vi của feature này, để người dùng có thể xem trực tiếp trong ứng dụng.
- **FR-002**: Hệ thống MUST hỗ trợ các định dạng âm thanh trọng tâm của phase này gồm AC3, EAC3, DTS, DTS-HD, TrueHD và FLAC khi file chứa chúng vẫn nằm trong container và nguồn media mà trình phát hiện tại có thể đọc.
- **FR-003**: Hệ thống MUST hỗ trợ đường phát thay thế cho H.264 và H.265 trong những trường hợp đường phát hiện tại của thiết bị không đáp ứng được nhưng nội dung vẫn thuộc phạm vi media mục tiêu.
- **FR-004**: Hệ thống MUST tự quyết định đường phát khả dụng phù hợp cho từng file media mà không yêu cầu người dùng chọn tay chế độ giải mã trước khi xem.
- **FR-005**: Hệ thống MUST giữ nguyên trải nghiệm mở file đối với các media vốn đã phát tốt trước khi feature này được bổ sung.
- **FR-006**: Hệ thống MUST cho phép người dùng bắt đầu xem với cả hình và tiếng khi file mở ra có ít nhất một đường video khả dụng và một track âm thanh chính thuộc phạm vi hỗ trợ của feature.
- **FR-007**: Hệ thống MUST duy trì các thao tác phát cơ bản đang có như phát, tạm dừng, tiếp tục và tua khi file được phát qua đường tương thích mở rộng.
- **FR-008**: Hệ thống MUST không yêu cầu người dùng biết tên codec, đổi ứng dụng hay bật một cài đặt ẩn chỉ để phát các file thuộc phạm vi hỗ trợ.
- **FR-009**: Hệ thống MUST đưa người dùng về trạng thái thất bại ổn định khi file vẫn không thể phát được sau khi đã thử các đường phát nằm trong phạm vi feature.
- **FR-010**: Hệ thống MUST làm rõ phạm vi của task này là khả năng phát media ở mức một file đang mở; chọn track audio, subtitle, playlist và các tối ưu phase tiếp theo không nằm trong feature này.

### Key Entities *(include if feature involves data)*

- **Media File Profile**: Hồ sơ cấp cao của file người dùng mở, gồm container, các stream âm thanh và video chính, cùng mức độ tương thích phát trong phạm vi feature.
- **Playback Compatibility Result**: Kết quả xác định liệu file có thể phát thành công ngay, cần đường phát tương thích mở rộng hay phải trả về trạng thái không phát được.
- **Playback Session State**: Trạng thái phiên phát mà người dùng nhìn thấy, gồm đang tải, đang phát ổn định hoặc thất bại có kiểm soát.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Trong bộ kiểm thử chấp nhận đại diện cho các codec mục tiêu của feature, ít nhất 95% file hợp lệ bắt đầu phát với cả hình và tiếng trong vòng 5 giây kể từ lúc người dùng mở file.
- **SC-002**: Trong 100% bộ mẫu hồi quy gồm các file đã phát tốt trước đó, người dùng vẫn mở và xem được file mà không cần thêm bước cấu hình mới.
- **SC-003**: Trong 100% bộ mẫu file hỏng hoặc nằm ngoài phạm vi hỗ trợ, ứng dụng không crash và trả về trạng thái không phát được ổn định trong vòng 5 giây sau khi xác định thất bại.
- **SC-004**: Trong kiểm thử nội bộ với người dùng lần đầu, ít nhất 90% người tham gia có thể mở một file phim thuộc phạm vi codec mục tiêu và bắt đầu xem mà không cần dùng ứng dụng phát khác.
- **SC-005**: Trong ít nhất 95% mẫu media mục tiêu phát thành công, người đánh giá không quan sát thấy lỗi lệch hình tiếng rõ rệt trong 10 phút đầu phát.

## Assumptions

- Feature này áp dụng cho luồng mở một file media trong trình phát hiện tại; subtitle, chọn track và playlist sẽ được xử lý ở các task phase 3 tiếp theo.
- Phạm vi ưu tiên là các file phim và video cá nhân mà người dùng mong đợi ứng dụng có thể phát trực tiếp từ nguồn media hiện đã hỗ trợ.
- Ứng dụng hiện đã có cơ chế mở media, hiển thị trạng thái phát và xử lý lỗi ở mức đủ để biểu diễn thành công hoặc thất bại của phiên phát.
- Bộ kiểm thử chấp nhận sẽ có sẵn mẫu đại diện cho các codec trọng tâm của task này để xác nhận tương thích thực tế.
- Người dùng không cần biết chi tiết kỹ thuật của codec; tiêu chí thành công của họ là file mở được, xem được ổn định và không phải đổi sang trình phát khác.
