# Feature Specification: AI Subtitle Generation

**Feature Branch**: `011-ai-subtitle-generation`  
**Created**: 2026-05-01  
**Status**: Draft  
**Input**: User description: "Tự động tạo subtitle từ audio video bằng Soniox API, hỗ trợ dịch real-time. Port từ dự án my-translator."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Tạo phụ đề tự động khi xem video (Priority: P1)

Người dùng đang xem một video có tiếng nói (phim, bài giảng, podcast video) và muốn có phụ đề tự động hiển thị real-time mà không cần file subtitle có sẵn. Họ nhấn nút 🤖 AI trên thanh điều khiển, ứng dụng tự động kết nối dịch vụ nhận dạng giọng nói, trích xuất âm thanh từ video đang phát và hiển thị phụ đề trực tiếp lên màn hình trong thời gian thực.

**Why this priority**: Đây là chức năng cốt lõi, mang lại giá trị chính của tính năng. Không có nhận dạng giọng nói thì không có phụ đề AI.

**Independent Test**: Có thể kiểm tra bằng cách mở video có tiếng nói, bật AI subtitle và xác nhận text phụ đề xuất hiện real-time trên overlay.

**Acceptance Scenarios**:

1. **Given** video đang phát có tiếng nói, **When** người dùng nhấn nút 🤖 AI, **Then** hệ thống hiển thị trạng thái "Đang kết nối...", sau đó phụ đề bắt đầu xuất hiện trong vòng 3 giây.
2. **Given** AI subtitle đang hoạt động, **When** video đang phát với người nói, **Then** phụ đề gốc (original) hiển thị real-time trên overlay, cập nhật liên tục theo lời nói.
3. **Given** AI subtitle đang hoạt động, **When** người dùng tạm dừng video, **Then** phụ đề dừng cập nhật; khi tiếp tục phát, phụ đề hoạt động trở lại.
4. **Given** AI subtitle đang hoạt động, **When** người dùng nhấn nút 🤖 lần nữa, **Then** AI subtitle tắt, phụ đề AI không còn hiển thị.

---

### User Story 2 - Dịch phụ đề sang ngôn ngữ khác (Priority: P2)

Người dùng xem video tiếng nước ngoài (tiếng Anh, Nhật, Hàn...) và muốn xem bản dịch tiếng Việt. Khi bật AI subtitle, hệ thống tự động nhận dạng ngôn ngữ nguồn và hiển thị phụ đề. Người dùng có thể chọn chế độ hiển thị: chỉ phụ đề gốc, chỉ bản dịch, hoặc cả hai song song.

**Why this priority**: Dịch thuật là giá trị gia tăng quan trọng nhất sau nhận dạng giọng nói, đặc biệt hữu ích cho người dùng Việt xem nội dung nước ngoài.

**Independent Test**: Mở video tiếng Anh, bật AI subtitle, chuyển đổi giữa 3 chế độ hiển thị và xác nhận phụ đề thay đổi tương ứng.

**Acceptance Scenarios**:

1. **Given** AI subtitle đang bật với video tiếng Anh ở chế độ "Cả hai", **When** dịch vụ nhận dạng hoàn tất một câu, **Then** hiển thị dòng phụ đề gốc (tiếng Anh) và dòng dịch (tiếng Việt) ngay bên dưới.
2. **Given** AI subtitle đang bật, **When** người dùng chuyển chế độ sang "Chỉ bản dịch", **Then** chỉ hiển thị dòng dịch tiếng Việt, ẩn phụ đề gốc.
3. **Given** AI subtitle đang bật, **When** người dùng chuyển chế độ sang "Chỉ phụ đề gốc", **Then** chỉ hiển thị phụ đề ngôn ngữ gốc, ẩn bản dịch.
4. **Given** AI subtitle đang bật, **When** video có nhiều ngôn ngữ xen kẽ, **Then** hệ thống tự động nhận dạng ngôn ngữ đang nói và dịch tương ứng.

---

### User Story 3 - Xuất phụ đề ra file SRT (Priority: P3)

Sau khi xem xong video với AI subtitle, người dùng muốn lưu lại phụ đề đã tạo thành file SRT để sử dụng lại hoặc chia sẻ. Khi tắt AI subtitle, ứng dụng hỏi người dùng có muốn xuất file SRT không.

**Why this priority**: Xuất file là tính năng tiện ích bổ sung, không ảnh hưởng đến trải nghiệm chính nhưng tăng giá trị sử dụng lâu dài.

**Independent Test**: Xem video với AI subtitle ít nhất 1 phút, tắt AI subtitle, chọn "Export SRT", kiểm tra file SRT được tạo và có nội dung đúng định dạng.

**Acceptance Scenarios**:

1. **Given** AI subtitle đã hoạt động và có dữ liệu phụ đề, **When** người dùng tắt AI subtitle, **Then** hệ thống hỏi "Xuất file SRT?" với các lựa chọn Có/Không.
2. **Given** người dùng chọn "Có" khi được hỏi xuất SRT, **When** hệ thống xử lý, **Then** file SRT được lưu với tên trùng tên video, nội dung đúng chuẩn SRT (index, timestamp, text).
3. **Given** không có dữ liệu phụ đề nào, **When** người dùng tắt AI subtitle, **Then** hệ thống không hỏi xuất SRT.

---

### User Story 4 - Tải phụ đề từ bộ nhớ đệm (Priority: P4)

Người dùng xem lại video đã từng bật AI subtitle trước đó. Thay vì gọi API nhận dạng giọng nói lại (tốn chi phí), hệ thống tự động tải phụ đề từ bộ nhớ đệm cục bộ.

**Why this priority**: Giúp tiết kiệm chi phí API và cải thiện trải nghiệm khi xem lại. Phụ thuộc vào các user story trước hoạt động ổn.

**Independent Test**: Xem video lần đầu với AI subtitle, đóng video, mở lại và bật AI subtitle — phụ đề hiển thị ngay từ cache mà không cần kết nối mạng.

**Acceptance Scenarios**:

1. **Given** video đã có phụ đề AI trong cache, **When** người dùng bật AI subtitle cho video đó, **Then** phụ đề tải từ cache và hiển thị ngay, không gọi API.
2. **Given** video đã có cache nhưng người dùng muốn tạo mới, **When** người dùng chọn "Tạo lại", **Then** hệ thống xóa cache cũ và tạo phụ đề mới từ API.

---

### Edge Cases

- Người dùng bật AI subtitle khi không có kết nối mạng → Hiển thị thông báo lỗi rõ ràng "Cần kết nối internet để sử dụng AI subtitle".
- API key không hợp lệ hoặc hết hạn → Hiển thị thông báo "API key không hợp lệ" và hướng dẫn cấu hình.
- Mất kết nối giữa chừng → Tự động thử kết nối lại (tối đa 3 lần, delay tăng dần 2s/4s/6s), hiển thị trạng thái "Đang kết nối lại...".
- Video không có tiếng nói (nhạc thuần, video im lặng) → Phụ đề trống, không hiển thị gì bất thường.
- Chuyển video khác khi AI subtitle đang bật → Đóng kết nối cũ, mở kết nối mới cho video mới.
- Phiên WebSocket vượt quá 3 phút → Tự động reset phiên mới (make-before-break) mà không gián đoạn phụ đề.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống PHẢI trích xuất dữ liệu âm thanh PCM từ luồng phát video đang hoạt động mà không ảnh hưởng đến chất lượng phát âm thanh ra loa.
- **FR-002**: Hệ thống PHẢI chuyển đổi âm thanh trích xuất sang định dạng 16kHz mono PCM (pcm_s16le) trước khi gửi tới dịch vụ nhận dạng giọng nói.
- **FR-003**: Hệ thống PHẢI kết nối tới dịch vụ nhận dạng giọng nói qua WebSocket và truyền dữ liệu âm thanh theo thời gian thực.
- **FR-004**: Hệ thống PHẢI nhận và phân tích kết quả nhận dạng giọng nói, phân biệt giữa phụ đề gốc (original), bản dịch (translation), và phụ đề tạm (provisional).
- **FR-005**: Hệ thống PHẢI hiển thị phụ đề lên overlay video theo thời gian thực với độ trễ không quá 3 giây từ lúc phát âm.
- **FR-006**: Hệ thống PHẢI hỗ trợ dịch tự động phụ đề sang ngôn ngữ đích (mặc định tiếng Việt), hiển thị song song phụ đề gốc và bản dịch.
- **FR-007**: Hệ thống PHẢI tự động nhận dạng ngôn ngữ nguồn của âm thanh.
- **FR-008**: Hệ thống PHẢI cung cấp nút bật/tắt AI subtitle trên giao diện trình phát video.
- **FR-009**: Hệ thống PHẢI quản lý phiên kết nối WebSocket, tự động reset mỗi 3 phút theo cơ chế make-before-break để đảm bảo không gián đoạn.
- **FR-010**: Hệ thống PHẢI duy trì kết nối bằng tín hiệu keepalive mỗi 15 giây khi không có dữ liệu âm thanh.
- **FR-011**: Hệ thống PHẢI cho phép xuất phụ đề đã tạo ra file SRT chuẩn khi người dùng tắt AI subtitle.
- **FR-012**: Hệ thống PHẢI lưu phụ đề đã tạo vào bộ nhớ đệm cục bộ để tránh gọi API khi xem lại cùng video.
- **FR-013**: Hệ thống PHẢI xử lý lỗi kết nối (mất mạng, API key sai, rate limit) với thông báo rõ ràng cho người dùng.
- **FR-014**: Hệ thống PHẢI tự động kết nối lại khi mất kết nối (tối đa 3 lần, delay tăng dần).
- **FR-015**: Hệ thống PHẢI truyền context từ phiên trước (500 ký tự dịch gần nhất) sang phiên mới để cải thiện chất lượng nhận dạng.
- **FR-016**: Hệ thống PHẢI cho phép người dùng chọn chế độ hiển thị phụ đề: chỉ phụ đề gốc, chỉ bản dịch, hoặc cả hai song song. Tùy chọn này có thể thay đổi trong khi AI subtitle đang hoạt động.

### Key Entities

- **SubtitleEvent**: Đại diện cho một sự kiện phụ đề đơn lẻ, bao gồm loại (gốc/dịch/tạm), nội dung text, và ngôn ngữ nguồn. Liên kết với một phiên AI subtitle.
- **SrtEntry**: Đại diện cho một mục trong file SRT, bao gồm số thứ tự, thời gian bắt đầu, thời gian kết thúc, và nội dung text. Thuộc về một bản xuất SRT.
- **SubtitleCache**: Bản ghi lưu trữ phụ đề đã tạo cho một video cụ thể, bao gồm định danh video, danh sách mục phụ đề, ngôn ngữ, và thời gian tạo. Mỗi video có tối đa một bản cache.
- **AiSubtitleSession**: Phiên AI subtitle đang hoạt động, bao gồm trạng thái kết nối, cấu hình ngôn ngữ, và danh sách SubtitleEvent đã nhận. Vòng đời gắn liền với việc bật/tắt AI subtitle.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Phụ đề AI xuất hiện trên màn hình trong vòng 3 giây kể từ khi người nói phát âm, cho video có tiếng nói rõ ràng.
- **SC-002**: Người dùng có thể bật và xem phụ đề AI thành công trong vòng 5 giây sau khi nhấn nút 🤖.
- **SC-003**: Bản dịch tiếng Việt hiển thị song song với phụ đề gốc cho ít nhất 70 ngôn ngữ nguồn.
- **SC-004**: Phiên AI subtitle hoạt động liên tục ít nhất 1 giờ mà không gián đoạn, bao gồm qua các lần reset phiên 3 phút.
- **SC-005**: File SRT xuất ra đúng chuẩn định dạng và có thể mở được bằng bất kỳ trình phát video nào hỗ trợ SRT.
- **SC-006**: Video đã có cache phụ đề hiển thị phụ đề ngay lập tức (dưới 1 giây) mà không cần kết nối mạng.
- **SC-007**: Khi mất kết nối, hệ thống tự động kết nối lại thành công trong vòng 10 giây và tiếp tục hiển thị phụ đề.
- **SC-008**: Chất lượng phát âm thanh ra loa không bị ảnh hưởng khi AI subtitle đang hoạt động (không có hiện tượng delay, méo tiếng, hay giảm chất lượng).

## Assumptions

- Người dùng có kết nối internet ổn định khi sử dụng tính năng AI subtitle (ít nhất cho lần đầu tạo phụ đề).
- Người dùng tự cung cấp API key Soniox hợp lệ và cấu hình trong ứng dụng trước khi sử dụng.
- Dịch vụ Soniox STT API khả dụng và ổn định, sử dụng WebSocket endpoint `wss://stt-rt.soniox.com/transcribe-websocket`.
- Hệ thống phụ đề cơ bản (subtitle overlay, SubtitleManager) từ Phase 3 đã hoạt động ổn định.
- Trình phát media (ExoPlayer) từ Phase 1 hỗ trợ inject AudioProcessor tùy chỉnh.
- Chi phí sử dụng API Soniox (~$0.12/giờ) do người dùng chịu trách nhiệm.
- Ngôn ngữ đích dịch thuật mặc định là tiếng Việt, có thể thay đổi trong cài đặt sau này.
- Bộ nhớ đệm phụ đề sử dụng cơ sở dữ liệu cục bộ trên thiết bị (Room DB).
