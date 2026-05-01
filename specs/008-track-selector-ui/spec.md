# Feature Specification: Track Selector UI

**Feature Branch**: `[009-track-selector-ui]`  
**Created**: 2026-05-01  
**Status**: Draft  
**Input**: User description: "Thực hiện task \"3.3 Track Selector UI\" trong @file:phase-3-advanced-media.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Đổi audio track ngay trong lúc xem (Priority: P1)

Người xem muốn mở một bảng chọn track ngay trên màn hình phát để chuyển sang audio track phù hợp hơn, như ngôn ngữ khác hoặc bản âm thanh khác, mà không phải rời khỏi video đang xem.

**Why this priority**: Với các video có nhiều audio track, khả năng đổi track ngay trong phiên xem là giá trị cốt lõi nhất của feature. Nếu chưa đổi được audio thuận tiện, bảng chọn track chưa giải quyết được nhu cầu chính.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở một video có từ hai audio track trở lên, mở bảng chọn track, chọn một audio track khác và xác nhận âm thanh chuyển đúng trong phiên xem hiện tại.

**Acceptance Scenarios**:

1. **Given** video đang phát có nhiều audio track khả dụng, **When** người dùng mở bảng chọn track và chọn một audio track khác, **Then** âm thanh phải chuyển sang track mới mà video vẫn tiếp tục phát.
2. **Given** audio track hiện tại đang được dùng, **When** người dùng mở lại bảng chọn track, **Then** bảng chọn phải cho thấy rõ track nào đang được chọn.

---

### User Story 2 - Chọn phụ đề hoặc tắt phụ đề từ cùng một nơi (Priority: P2)

Người xem muốn dùng cùng một bảng chọn để chuyển giữa các lựa chọn phụ đề hiện có hoặc tắt phụ đề hoàn toàn, thay vì phải tìm ở nhiều nơi khác nhau trong giao diện.

**Why this priority**: Khi audio và subtitle đều có thể thay đổi trong lúc xem, gom chúng vào cùng một điểm truy cập giúp thao tác ngắn hơn và giảm nhầm lẫn cho người dùng.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở một video có ít nhất một lựa chọn phụ đề, mở bảng chọn track, chuyển sang một phụ đề khác hoặc chọn tắt phụ đề và xác nhận kết quả thay đổi ngay trên màn hình.

**Acceptance Scenarios**:

1. **Given** video có từ một lựa chọn phụ đề trở lên, **When** người dùng chọn một phụ đề khác trong bảng chọn, **Then** phụ đề hiển thị phải đổi theo lựa chọn mới trong phiên xem hiện tại.
2. **Given** một phụ đề đang hiển thị, **When** người dùng chọn trạng thái tắt phụ đề, **Then** phụ đề phải biến mất nhưng video và audio vẫn tiếp tục hoạt động bình thường.

---

### User Story 3 - Hiểu nhanh trạng thái track hiện tại (Priority: P3)

Người xem muốn nhìn vào bảng chọn và biết ngay hiện tại đang dùng audio nào, phụ đề nào, và mục nào không có lựa chọn phù hợp để tránh thử sai nhiều lần.

**Why this priority**: Một selector chỉ hữu ích khi người dùng hiểu ngay trạng thái hiện tại. Nếu danh sách mơ hồ hoặc không chỉ ra lựa chọn đang hoạt động, thao tác đổi track sẽ gây nhầm lẫn.

**Independent Test**: Có thể kiểm thử độc lập bằng cách mở bảng chọn trên các video có và không có nhiều lựa chọn track, rồi xác nhận người dùng luôn nhận ra lựa chọn hiện tại và tình trạng không có lựa chọn ở từng nhóm.

**Acceptance Scenarios**:

1. **Given** video có ít nhất một audio track và một nhóm phụ đề khả dụng hoặc không khả dụng, **When** người dùng mở bảng chọn, **Then** mỗi nhóm phải hiển thị trạng thái hiện tại theo cách dễ nhận biết.
2. **Given** một nhóm track không có lựa chọn bổ sung hoặc không có track nào để chọn, **When** người dùng mở bảng chọn, **Then** giao diện phải thể hiện rõ tình trạng đó mà không làm người dùng hiểu nhầm rằng ứng dụng bị lỗi.

### Edge Cases

- Khi video chỉ có một audio track, bảng chọn vẫn phải mở được nhưng không được tạo cảm giác rằng có thêm lựa chọn audio khác để chuyển.
- Khi video không có phụ đề khả dụng, người dùng vẫn phải thấy rõ rằng hiện không có phụ đề để chọn thay vì một danh sách trống khó hiểu.
- Khi metadata của track không đủ rõ ràng hoặc nhiều track có tên giống nhau, hệ thống phải hiển thị nhãn đủ phân biệt để người dùng chọn đúng hơn.
- Khi người dùng mở bảng chọn trong lúc phát video có nhiều track nhưng một track vừa trở nên không còn khả dụng, việc chọn track đó không được làm gián đoạn phiên xem hiện tại.
- Khi đang có phụ đề ngoài hoặc phụ đề nhúng hoạt động, bảng chọn phải luôn cung cấp trạng thái tắt phụ đề như một lựa chọn rõ ràng.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST cho phép người dùng mở một bảng chọn track từ trải nghiệm phát video hiện tại mà không cần rời khỏi màn hình xem.
- **FR-002**: Hệ thống MUST trình bày lựa chọn audio và lựa chọn phụ đề theo hai nhóm riêng biệt trong cùng một bảng chọn.
- **FR-003**: Hệ thống MUST hiển thị cho mỗi lựa chọn một nhãn dễ hiểu để người dùng phân biệt giữa các track khả dụng.
- **FR-004**: Hệ thống MUST thể hiện rõ audio track nào đang được dùng tại thời điểm người dùng mở bảng chọn.
- **FR-005**: Hệ thống MUST cho phép người dùng chuyển sang một audio track khác đang khả dụng ngay trong phiên xem hiện tại.
- **FR-006**: Hệ thống MUST thể hiện rõ phụ đề nào đang hoạt động, bao gồm cả trạng thái đang tắt phụ đề.
- **FR-007**: Hệ thống MUST cho phép người dùng chọn một phụ đề khả dụng hoặc chọn tắt phụ đề từ cùng bảng chọn.
- **FR-008**: Hệ thống MUST áp dụng thay đổi audio track hoặc phụ đề trong phiên xem hiện tại mà không buộc người dùng mở lại video.
- **FR-009**: Hệ thống MUST giữ phiên phát tiếp tục xem được nếu người dùng chọn một track không thể kích hoạt thành công; lựa chọn hiện đang hoạt động trước đó không được mất đi một cách mơ hồ.
- **FR-010**: Hệ thống MUST hiển thị trạng thái rõ ràng cho các nhóm không có lựa chọn khả dụng hoặc chỉ có một lựa chọn duy nhất.
- **FR-011**: Hệ thống MUST phản ánh đúng các nguồn phụ đề hiện có cho video đang xem, bao gồm phụ đề đã được hệ thống nạp hoặc phát hiện trước đó trong cùng phiên xem.
- **FR-012**: Hệ thống MUST cập nhật nội dung bảng chọn theo trạng thái track hiện hành của video mỗi khi người dùng mở bảng chọn.
- **FR-013**: Hệ thống MUST giới hạn phạm vi feature này ở chọn audio track và subtitle track cho một video đang mở; tải phụ đề ngoài, chỉnh kiểu subtitle, playlist, shuffle và điều khiển next/previous nằm ngoài phạm vi của feature.

### Key Entities *(include if feature involves data)*

- **Playback Item**: Video hiện đang phát, là ngữ cảnh chứa toàn bộ lựa chọn audio và phụ đề mà người dùng có thể thao tác.
- **Track Option**: Một lựa chọn audio hoặc phụ đề cụ thể mà người dùng có thể chọn trong bảng selector, cùng với nhãn hiển thị và trạng thái khả dụng của nó.
- **Track Group View**: Nhóm lựa chọn cùng loại được hiển thị cho người dùng, như nhóm audio hoặc nhóm phụ đề, kèm trạng thái hiện tại của nhóm đó.
- **Track Selection State**: Trạng thái đang hoạt động cho audio và phụ đề tại thời điểm hiện tại của phiên xem.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Trong 100% kịch bản kiểm thử với video có nhiều audio track hoặc subtitle track, người dùng mở được bảng chọn track và nhìn thấy trạng thái đang chọn của từng nhóm trong không quá 2 thao tác từ màn hình phát.
- **SC-002**: Trong ít nhất 95% kịch bản kiểm thử với các track hợp lệ, việc chuyển audio track hoặc subtitle track có hiệu lực trong vòng 2 giây kể từ lúc người dùng xác nhận lựa chọn.
- **SC-003**: Trong 100% kịch bản kiểm thử với các video không có subtitle hoặc chỉ có một audio track, bảng chọn vẫn hiển thị trạng thái rõ ràng về lựa chọn hiện có mà không làm gián đoạn video đang phát.
- **SC-004**: Trong kiểm thử khả dụng nội bộ, ít nhất 90% người tham gia xác định đúng audio track hiện tại và trạng thái subtitle hiện tại ngay trong lần mở đầu tiên của bảng chọn mà không cần hướng dẫn thêm.
- **SC-005**: Trong 100% kịch bản chọn nhầm hoặc chọn một track không áp dụng được, video vẫn tiếp tục xem được và người dùng vẫn nhận biết được trạng thái lựa chọn đang thực sự có hiệu lực.

## Assumptions

- Khả năng phát hiện danh sách audio track và subtitle track khả dụng đã được cung cấp bởi tầng playback hiện có; feature này tập trung vào cách trình bày và thao tác chọn trong giao diện người dùng.
- Các phụ đề ngoài đã được nạp hoặc tự phát hiện trước đó trong cùng phiên xem sẽ xuất hiện như một lựa chọn phụ đề bình thường trong selector nếu còn khả dụng.
- Feature này chỉ áp dụng cho một video đang mở tại thời điểm hiện tại; không bao phủ chọn track hàng loạt cho playlist hoặc cho nhiều mục phát liên tiếp.
- Người dùng truy cập bảng chọn từ bộ điều khiển phát hiện có; việc bổ sung một màn hình cài đặt riêng cho track không nằm trong phạm vi feature này.
- Nếu metadata của track không đầy đủ, ứng dụng vẫn có thể dùng nhãn thay thế dễ hiểu để giúp người dùng phân biệt các lựa chọn.