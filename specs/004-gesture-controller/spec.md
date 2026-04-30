# Feature Specification: Playback Gesture Controller

**Feature Branch**: `[004-gesture-controller]`  
**Created**: 2026-04-30  
**Status**: Draft  
**Input**: User description: "task \"2.2 Gesture Mapping\" trong _docs/plans/phase-2-gesture-controls.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Adjust Playback Without Leaving the Video Surface (Priority: P1)

Người xem muốn tăng giảm âm lượng, độ sáng hoặc tua nội dung trực tiếp trên vùng phát mà không cần mở thêm cụm nút điều khiển riêng.

**Why this priority**: Đây là giá trị cốt lõi của gesture controller; nếu không nhận và phân loại đúng các thao tác vuốt, toàn bộ chuỗi điều khiển cảm ứng của Phase 2 sẽ không dùng được.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát một video, thực hiện vuốt dọc ở nửa trái và nửa phải màn hình, cùng vuốt ngang trên vùng phát, rồi xác nhận mỗi thao tác chỉ tạo ra đúng một loại điều khiển mong đợi.

**Acceptance Scenarios**:

1. **Given** video đang phát và người dùng bắt đầu vuốt dọc ở nửa phải vùng phát, **When** thao tác di chuyển mỗi 150 pixel theo trục dọc, **Then** hệ thống phải diễn giải thao tác đó thành đúng một bước tăng hoặc giảm âm lượng theo cùng chiều vuốt thay vì độ sáng hoặc tua nội dung.
2. **Given** video đang phát và người dùng bắt đầu vuốt dọc ở nửa trái vùng phát, **When** thao tác di chuyển mỗi 150 pixel theo trục dọc, **Then** hệ thống phải diễn giải thao tác đó thành mức thay đổi độ sáng 0,05 theo cùng chiều vuốt thay vì âm lượng hoặc tua nội dung.
3. **Given** video đang phát và người dùng vuốt ngang trên vùng phát, **When** thao tác hoàn tất, **Then** hệ thống phải diễn giải thao tác đó thành yêu cầu tua tiến hoặc tua lùi với độ lệch thời gian bằng quãng đường vuốt nhân 100 mili giây theo hướng vuốt.

---

### User Story 2 - Trigger Common Playback Actions with Simple Touch Gestures (Priority: P2)

Người xem muốn chạm nhanh hoặc nhấn giữ trên vùng phát để phát hoặc tạm dừng, tua 10 giây hoặc kích hoạt tua nhanh tạm thời mà không phải nhắm vào nút nhỏ trên màn hình.

**Why this priority**: Các thao tác chạm nhanh và nhấn giữ rút ngắn thời gian điều khiển khi đang xem toàn màn hình, đặc biệt trong bối cảnh video đang chiếm phần lớn không gian hiển thị.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát một video và thực hiện double tap ở vùng trái, giữa, phải và thao tác nhấn giữ, rồi xác nhận mỗi vùng tạo ra đúng hành vi điều khiển đã quy định.

**Acceptance Scenarios**:

1. **Given** video đang phát hoặc tạm dừng, **When** người dùng double tap tại vùng giữa của vùng phát, **Then** hệ thống tạo đúng một yêu cầu chuyển đổi giữa phát và tạm dừng.
2. **Given** video đang phát, **When** người dùng double tap tại một phần ba bên trái hoặc một phần ba bên phải vùng phát, **Then** hệ thống tạo yêu cầu tua lùi hoặc tua tiến đúng 10 giây theo vùng đã chạm.
3. **Given** video đang phát bình thường, **When** người dùng nhấn giữ trên vùng phát và sau đó thả tay, **Then** hệ thống kích hoạt chế độ tua nhanh tạm thời ở mức gấp 2 lần trong lúc giữ và kết thúc chế độ này ngay khi thao tác kết thúc.

---

### User Story 3 - Keep Gesture Recognition Predictable During Complex Touch Input (Priority: P3)

Người xem muốn thao tác pinch để phóng to khung hình và mong hệ thống xử lý các cử chỉ chồng lấn một cách nhất quán để không kích hoạt nhầm nhiều hành động cùng lúc.

**Why this priority**: Khi người dùng chuyển từ thao tác một ngón sang hai ngón hoặc đổi hướng chạm giữa chừng, hệ thống cần ưu tiên sự nhất quán để tránh gây mất kiểm soát trải nghiệm phát video.

**Independent Test**: Có thể kiểm thử độc lập bằng cách thực hiện pinch trên vùng phát, thử chuyển từ vuốt sang pinch và kiểm tra các trường hợp chạm không dứt khoát, rồi xác nhận hệ thống không phát sinh hành động mâu thuẫn.

**Acceptance Scenarios**:

1. **Given** người dùng đặt hai ngón tay trên vùng phát, **When** thực hiện thao tác pinch in hoặc pinch out, **Then** hệ thống diễn giải thao tác đó thành yêu cầu thay đổi mức thu phóng của video trong dải từ 1,0x đến 3,0x.
2. **Given** người dùng đang thực hiện một thao tác hai ngón để thu phóng, **When** thao tác còn hiệu lực, **Then** hệ thống không đồng thời tạo thêm yêu cầu vuốt âm lượng, độ sáng hoặc tua nội dung từ cùng chuỗi chạm đó.
3. **Given** người dùng bắt đầu một thao tác nhưng không đủ điều kiện để xác định rõ loại cử chỉ, **When** thao tác kết thúc, **Then** hệ thống bỏ qua hoặc hủy thao tác đó thay vì phát ra lệnh điều khiển sai.

### Edge Cases

- Khi người dùng bắt đầu vuốt ở một nửa màn hình rồi kéo sang nửa còn lại: loại điều khiển phải được cố định theo vùng bắt đầu của thao tác để tránh đổi ngữ nghĩa giữa chừng.
- Khi người dùng chuyển từ thao tác một ngón sang hai ngón: hệ thống phải ưu tiên xử lý pinch và hủy các diễn giải vuốt còn dang dở nếu cần thiết.
- Khi người dùng thả tay rất nhanh sau nhấn giữ: hệ thống không được để trạng thái tua nhanh tạm thời bị kẹt sau khi thao tác kết thúc.
- Khi người dùng double tap gần ranh giới giữa các vùng trái, giữa và phải: hệ thống phải áp dụng cùng một quy tắc phân vùng nhất quán trong mọi lần nhận diện.
- Khi video đang ở trạng thái không thể tua hoặc không thể thay đổi mức phát: gesture controller vẫn phải phát ra cùng loại ý định điều khiển một cách nhất quán để lớp xử lý phía sau quyết định có áp dụng hay không.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST cung cấp một lớp điều phối cử chỉ tập trung cho vùng phát video để mọi thao tác cảm ứng trên bề mặt phát được diễn giải theo cùng một bộ quy tắc.
- **FR-002**: Hệ thống MUST phân loại thao tác vuốt dọc bắt đầu ở nửa phải vùng phát thành yêu cầu điều chỉnh âm lượng với tỷ lệ một bước âm lượng cho mỗi 150 pixel dịch chuyển theo trục dọc.
- **FR-003**: Hệ thống MUST phân loại thao tác vuốt dọc bắt đầu ở nửa trái vùng phát thành yêu cầu điều chỉnh độ sáng với tỷ lệ 0,05 cho mỗi 150 pixel dịch chuyển theo trục dọc.
- **FR-004**: Hệ thống MUST phân loại thao tác vuốt ngang trên vùng phát thành yêu cầu tua tiến hoặc tua lùi theo hướng thao tác với độ lệch thời gian bằng quãng đường vuốt nhân 100 mili giây.
- **FR-005**: Hệ thống MUST diễn giải double tap tại vùng giữa thành yêu cầu chuyển đổi giữa phát và tạm dừng.
- **FR-006**: Hệ thống MUST diễn giải double tap tại một phần ba bên trái thành yêu cầu tua lùi 10 giây và tại một phần ba bên phải thành yêu cầu tua tiến 10 giây.
- **FR-007**: Hệ thống MUST kích hoạt chế độ tua nhanh tạm thời ở mức 2x trong suốt thời gian người dùng nhấn giữ và MUST kết thúc chế độ này ngay khi thao tác giữ chấm dứt.
- **FR-008**: Hệ thống MUST diễn giải thao tác pinch thành yêu cầu thay đổi mức thu phóng video trong dải từ 1,0x đến 3,0x.
- **FR-009**: Hệ thống MUST bảo đảm rằng tại một thời điểm, một chuỗi chạm chỉ phát sinh một loại kết quả điều khiển có hiệu lực, trừ khi quy tắc của chính thao tác đó yêu cầu bắt đầu và kết thúc một trạng thái tạm thời.
- **FR-010**: Hệ thống MUST cố định vùng điều khiển của thao tác vuốt theo vị trí bắt đầu chạm, không đổi loại điều khiển chỉ vì ngón tay di chuyển qua ranh giới vùng sau đó.
- **FR-011**: Hệ thống MUST ưu tiên cử chỉ hai ngón cho thu phóng khi có đủ tín hiệu nhận diện và MUST ngăn các cử chỉ một ngón cùng chuỗi chạm phát sinh hành động mâu thuẫn.
- **FR-012**: Hệ thống MUST bỏ qua các thao tác không đạt ngưỡng nhận diện rõ ràng thay vì phát ra yêu cầu điều khiển sai loại.
- **FR-013**: Hệ thống MUST phát ra kết quả điều khiển theo cách nhất quán ngay cả khi lớp xử lý phía sau có thể từ chối áp dụng thao tác do trạng thái phát hiện tại.

### Key Entities *(include if feature involves data)*

- **Gesture Session**: Một chuỗi chạm liên tục từ lúc người dùng đặt tay lên vùng phát cho đến khi thao tác kết thúc, dùng để xác định loại cử chỉ và bảo đảm chỉ một kết quả điều khiển được phát ra cho chuỗi đó.
- **Gesture Zone**: Vùng khởi tạo thao tác trên bề mặt phát, bao gồm nửa trái, nửa phải, một phần ba bên trái, vùng giữa và một phần ba bên phải.
- **Gesture Outcome**: Kết quả điều khiển được suy ra từ một gesture session, như điều chỉnh âm lượng, điều chỉnh độ sáng, tua theo hướng, chuyển phát hoặc tạm dừng, tua 10 giây, tua nhanh tạm thời hoặc thay đổi thu phóng.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Trong bộ kiểm thử chấp nhận bao phủ toàn bộ mapping đã đặc tả, 100% thao tác vuốt dọc ở nửa phải với mỗi mốc 150 pixel được ánh xạ đúng thành một bước tăng hoặc giảm âm lượng theo chiều vuốt.
- **SC-002**: Trong cùng bộ kiểm thử, 100% thao tác vuốt dọc ở nửa trái với mỗi mốc 150 pixel được ánh xạ đúng thành thay đổi độ sáng 0,05 theo chiều vuốt.
- **SC-003**: Trong 100% thao tác vuốt ngang hợp lệ, độ lệch tua được phát ra khớp với công thức quãng đường vuốt nhân 100 mili giây và đúng chiều tua mong đợi.
- **SC-004**: Trong 100% kịch bản double tap trái, giữa và phải cùng nhấn giữ hợp lệ, hệ thống chỉ phát ra đúng một hành động điều khiển tương ứng, trong đó double tap cạnh biên tạo seek đúng 10 giây và nhấn giữ kích hoạt đúng mức 2x rồi kết thúc trong không quá 0,5 giây sau khi thả tay.
- **SC-005**: Trong bộ kiểm thử pinch và xung đột cử chỉ gồm chuyển vùng giữa chừng, đổi từ một ngón sang hai ngón và thao tác không đủ ngưỡng, 100% trường hợp giữ mức thu phóng trong dải 1,0x đến 3,0x và không tạo ra hai kết quả điều khiển mâu thuẫn từ cùng một chuỗi chạm.

## Assumptions

- Đặc tả này chỉ bao phủ bộ điều phối cử chỉ cho màn hình phát video; phần hiển thị overlay trực quan cho gesture nằm ở mục 2.8 và không thuộc phạm vi tài liệu này.
- Màn hình phát đã có sẵn các lớp phía sau để nhận kết quả điều khiển và quyết định áp dụng thay đổi vào phát video, âm lượng, độ sáng hoặc thu phóng.
- Tốc độ tua nhanh tạm thời mặc định và duy nhất trong phạm vi tài liệu này là 2x; các lựa chọn tốc độ phát cố định khác thuộc phạm vi riêng của speed selector.
- Một bước âm lượng được hiểu là một đơn vị điều chỉnh chuẩn mà thiết bị phát hiện tại hỗ trợ; tài liệu này chỉ chốt tỷ lệ gesture sang bước thay đổi, không chốt thang âm lượng tuyệt đối của từng thiết bị.
- Tính năng này ưu tiên thiết bị cảm ứng điện thoại; các tương tác bằng chuột, bút cảm ứng chuyên dụng hoặc điều khiển từ xa không nằm trong phạm vi đặc tả hiện tại.