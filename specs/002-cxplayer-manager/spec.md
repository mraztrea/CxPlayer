# Feature Specification: Playback Session Manager

**Feature Branch**: `[002-cxplayer-manager]`  
**Created**: 2026-04-29  
**Status**: Draft  
**Input**: User description: "thực hiện task 1.3 CxPlayerManager trong phase-1-core-player.md"

## Clarifications

### Session 2026-04-29

- Q: Chính sách xử lý yêu cầu phát không hợp lệ (danh sách rỗng, startIndex ngoài phạm vi, startPosition âm hoặc vượt duration)? → A: Chỉ báo lỗi khi không có nguồn phát hợp lệ; nếu danh sách còn dùng được thì đưa startIndex về phần tử hợp lệ gần nhất và đặt startPosition không hợp lệ về 0.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Start Playback Reliably (Priority: P1)

Người xem mở một nguồn video hợp lệ từ danh sách phát hoặc từ một liên kết được hỗ trợ và phiên phát được khởi tạo ngay trên mục đã chọn, tại đúng vị trí bắt đầu mong muốn.

**Why this priority**: Nếu không khởi tạo và bắt đầu phát ổn định, player không tạo ra giá trị sử dụng ở Phase 1.

**Independent Test**: Có thể kiểm thử độc lập bằng cách cung cấp một hoặc nhiều nguồn video hợp lệ, yêu cầu phát từ một mục và vị trí xác định, sau đó xác nhận mục được chọn được chuẩn bị và đi vào trạng thái phát sẵn sàng mà không cần thao tác bổ sung.

**Acceptance Scenarios**:

1. **Given** một danh sách nguồn video hợp lệ và một phiên phát đã được khởi tạo, **When** màn hình yêu cầu phát từ mục chỉ định và vị trí chỉ định, **Then** mục tương ứng được chuẩn bị và phát từ vị trí yêu cầu.
2. **Given** một nguồn video cục bộ hợp lệ, **When** người dùng mở màn hình phát, **Then** phiên phát tự động bắt đầu và cung cấp trạng thái hiện tại để giao diện hiển thị.

---

### User Story 2 - Restore Session After Lifecycle Changes (Priority: P2)

Người xem rời ứng dụng tạm thời hoặc xoay màn hình và khi quay lại, phiên phát tiếp tục từ gần đúng vị trí trước đó với mục đang xem và ý định phát trước đó được giữ nguyên.

**Why this priority**: Trải nghiệm xem video bị gián đoạn nếu trạng thái phát bị mất khi vòng đời màn hình thay đổi.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát video, tạo gián đoạn vòng đời tạm thời, rồi xác nhận mục hiện tại, vị trí phát và trạng thái phát được phục hồi chính xác.

**Acceptance Scenarios**:

1. **Given** một video đang phát ở giữa nội dung, **When** màn hình được tạo lại do thay đổi cấu hình, **Then** phiên phát khôi phục đúng mục đang xem và tiếp tục từ gần đúng vị trí trước đó.
2. **Given** người dùng đã tạm dừng video trước khi ứng dụng bị gián đoạn tạm thời, **When** màn hình quay lại nền trước, **Then** phiên phát vẫn giữ trạng thái tạm dừng thay vì tự ý phát lại.

---

### User Story 3 - Use Core Transport Controls Consistently (Priority: P3)

Người xem sử dụng các điều khiển cơ bản như phát, tạm dừng và tua tiến hoặc lùi nhanh theo bước cố định và luôn nhận được kết quả nhất quán trên các nguồn video được hỗ trợ.

**Why this priority**: Điều khiển phát là phần tối thiểu để người dùng tương tác được với video sau khi phiên phát đã chạy.

**Independent Test**: Có thể kiểm thử độc lập bằng cách gửi lệnh phát, tạm dừng, tua tiến và tua lùi trên một phiên phát đang hoạt động rồi xác nhận trạng thái và vị trí phát thay đổi đúng kỳ vọng.

**Acceptance Scenarios**:

1. **Given** một phiên phát đang hoạt động, **When** người dùng chọn tua tiến hoặc tua lùi, **Then** vị trí phát thay đổi theo bước 10 giây hoặc được chặn về biên hợp lệ gần nhất.
2. **Given** một phiên phát đang hoạt động, **When** người dùng chuyển giữa phát và tạm dừng, **Then** trạng thái phát thay đổi ngay và giao diện nhận được trạng thái mới để hiển thị.

### Edge Cases

- Khi danh sách nguồn phát rỗng hoặc mọi nguồn đều không hợp lệ: Hệ thống phải báo lỗi có thể phục hồi mà không bắt đầu phát.
- Khi chỉ số mục bắt đầu vượt ngoài phạm vi danh sách phát: Chỉ số được clamp về phần tử hợp lệ gần nhất (index cuối cùng nếu overflow, 0 nếu underflow) và phát bắt đầu từ đó.
- Khi vị trí bắt đầu âm hoặc lớn hơn tổng thời lượng: Vị trí được đặt về 0 và phát từ đầu nội dung.
- Khi vòng đời màn hình gọi khởi tạo hoặc giải phóng lặp lại nhiều lần: Hệ thống phải bỏ qua duplicate callback và chỉ quản lý phiên phát duy nhất.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST tạo tối đa một phiên phát chủ động cho mỗi màn hình phát đang hiển thị.
- **FR-002**: Hệ thống MUST chấp nhận một danh sách có thứ tự gồm một hoặc nhiều nguồn video phát được, cùng với mục bắt đầu và vị trí bắt đầu tùy chọn; nếu mục bắt đầu nằm ngoài phạm vi danh sách hợp lệ, phải clamp về index gần nhất; nếu vị trí bắt đầu âm hoặc vượt tổng thời lượng, phải reset về 0.
- **FR-003**: Hệ thống MUST chuẩn bị mục được chọn và tự động bắt đầu phát khi đầu vào hợp lệ và ý định phát không bị vô hiệu hóa.
- **FR-004**: Hệ thống MUST hỗ trợ phát, tạm dừng, tua đến vị trí cụ thể, tua tiến và tua lùi theo bước cố định 10 giây.
- **FR-005**: Hệ thống MUST giữ lại đủ trạng thái để khôi phục mục đang xem, vị trí phát và trạng thái phát sau các gián đoạn vòng đời tạm thời.
- **FR-006**: Hệ thống MUST giải phóng toàn bộ tài nguyên phát khi màn hình không còn sở hữu phiên phát để tránh rò rỉ phát nền ngoài ý muốn.
- **FR-007**: Hệ thống MUST cung cấp trạng thái hiện tại cho giao diện, bao gồm trạng thái phát, vị trí hiện tại, thời lượng và chỉ số mục đang hoạt động.
- **FR-008**: Hệ thống MUST trả về lỗi có thể phục hồi khi yêu cầu phát không có nguồn hợp lệ để giao diện có thể thông báo cho người dùng.
- **FR-009**: Hệ thống MUST không tạo thêm phiên phát song song khi cùng một màn hình nhận lặp lại các callback vòng đời tương đương.
- **FR-010**: Hệ thống MUST giữ nguyên thứ tự danh sách phát do bên gọi cung cấp khi có nhiều nguồn video.

### Key Entities *(include if feature involves data)*

- **Playback Session**: Đại diện cho một phiên phát đang hoạt động, bao gồm danh sách phát hiện thời, mục đang xem, vị trí phát, trạng thái phát và quyền sở hữu bởi màn hình hiện tại.
- **Playback Request**: Đại diện cho yêu cầu bắt đầu phát với danh sách nguồn video, mục khởi đầu và vị trí khởi đầu tùy chọn.
- **Playback Snapshot**: Đại diện cho trạng thái tối thiểu cần lưu để phục hồi phiên phát sau gián đoạn, gồm mục đang xem, vị trí phát và ý định phát trước đó.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Với 95% yêu cầu mở video hợp lệ, phiên phát bắt đầu hoặc chuyển sang trạng thái sẵn sàng phát trong tối đa 3 giây đối với nguồn cục bộ và 5 giây đối với nguồn mạng thông thường.
- **SC-002**: Trong 95% trường hợp màn hình bị tạo lại hoặc quay lại nền trước, vị trí phát được khôi phục sai lệch không quá 1 giây so với vị trí đã lưu gần nhất.
- **SC-003**: 100% thao tác phát, tạm dừng, tua tiến 10 giây và tua lùi 10 giây hoạt động không gây crash trong bộ kiểm thử chấp nhận của Phase 1.
- **SC-004**: Trong kiểm thử chấp nhận với các nguồn cục bộ và từ xa được hỗ trợ, ít nhất 95% yêu cầu phát hợp lệ không cần người dùng thử lại lần hai.
- **SC-005**: 100% yêu cầu phát với startIndex ngoài phạm vi hoặc startPosition không hợp lệ được normalize thành giá trị hợp lệ mà không báo lỗi, miễn là danh sách phát còn nguồn hợp lệ.

## Assumptions

- Việc chuẩn hóa dữ liệu đầu vào thành danh sách nguồn video có thứ tự được xử lý trước hoặc ngay tại ranh giới gọi vào bộ quản lý phát.
- Giao diện người dùng chịu trách nhiệm hiển thị control và thông báo lỗi; tính năng này chỉ cần cung cấp trạng thái phiên phát và lỗi có thể phục hồi.
- Phạm vi Phase 1 chỉ hỗ trợ một phiên phát foreground trên một thiết bị tại một thời điểm.
- Các nguồn phát được cung cấp đã có quyền truy cập hợp lệ và thuộc nhóm định dạng video nằm trong phạm vi hỗ trợ của Phase 1.
