# Feature Specification: Player Lifecycle Management

**Feature Branch**: `[004-player-lifecycle]`  
**Created**: 2026-04-30  
**Status**: Draft  
**Input**: User description: "thực hiện task \"1.5 Lifecycle\" trong phase-1-core-player.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Continue Playback After Temporary Interruptions (Priority: P1)

Người xem đang phát video nhưng tạm thời rời khỏi màn hình hoặc đưa ứng dụng xuống nền, sau đó quay lại và tiếp tục đúng nội dung đang xem mà không phải mở lại thủ công.

**Why this priority**: Tính liên tục khi chuyển giữa foreground và background là kỳ vọng cơ bản của một video player; nếu mất ngữ cảnh ở đây, trải nghiệm xem bị gián đoạn ngay trong luồng chính.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát một video, đưa ứng dụng ra nền trong thời gian ngắn, quay lại và xác nhận người dùng vẫn ở đúng nội dung với trạng thái phát phù hợp trước khi rời màn hình.

**Acceptance Scenarios**:

1. **Given** người dùng đang phát một video hợp lệ, **When** ứng dụng bị gián đoạn tạm thời rồi quay lại, **Then** cùng nội dung được khôi phục và người dùng tiếp tục gần đúng vị trí trước đó mà không cần chọn lại nguồn phát.
2. **Given** người dùng đã chủ động tạm dừng video trước khi ứng dụng bị gián đoạn, **When** màn hình phát xuất hiện lại, **Then** video vẫn giữ trạng thái tạm dừng tại vị trí đã lưu thay vì tự phát ngoài ý muốn.

---

### User Story 2 - Preserve Watching Context Through Screen Recreation (Priority: P2)

Người xem xoay màn hình hoặc gặp tình huống giao diện phải được tạo lại, nhưng vẫn giữ được nội dung đang xem và tiến trình theo dõi để tiếp tục mà không bị mất mạch xem.

**Why this priority**: Thay đổi cấu hình thiết bị là thao tác rất thường gặp trên mobile; nếu player không giữ được ngữ cảnh, người dùng sẽ xem đây là lỗi nghiêm trọng.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát video, đổi chiều màn hình hoặc kích hoạt tạo lại giao diện, rồi xác nhận nội dung hiện hành, tiến trình và trạng thái phát vẫn được bảo toàn.

**Acceptance Scenarios**:

1. **Given** người dùng đang xem một video trong player, **When** thiết bị đổi chiều hiển thị và màn hình phát được tạo lại, **Then** người dùng quay lại đúng nội dung đang xem với tiến trình gần đúng vị trí trước khi thay đổi.
2. **Given** phiên xem bắt đầu từ một danh sách hoặc tập nội dung có thứ tự, **When** màn hình phát được khôi phục sau khi tạo lại, **Then** người dùng vẫn ở đúng mục nội dung đang xem thay vì bị trả về mục đầu tiên hoặc nội dung khác.

---

### User Story 3 - Exit the Player Cleanly (Priority: P3)

Người xem rời hẳn màn hình phát và mong muốn video dừng gọn gàng, không còn âm thanh tiếp tục chạy ngầm hoặc phát sinh phiên phát trùng lặp khi quay lại.

**Why this priority**: Một player không đóng sạch sẽ sẽ tạo cảm giác lỗi, gây nhiễu âm thanh và làm suy giảm độ tin cậy của toàn bộ ứng dụng.

**Independent Test**: Có thể kiểm thử độc lập bằng cách phát video, thoát hẳn khỏi player, rồi xác nhận nội dung không tiếp tục chạy ngoài ý muốn và không có phiên phát cũ còn bám lại khi mở lại player.

**Acceptance Scenarios**:

1. **Given** người dùng đang phát video, **When** người dùng đóng màn hình phát bằng hành động thoát dứt khoát, **Then** phát lại phải dừng hoàn toàn và không còn âm thanh tiếp tục sau khi rời màn hình.
2. **Given** người dùng quay lại player sau khi đã thoát hẳn phiên xem trước đó, **When** player mở lại, **Then** hệ thống không để hai trạng thái phát chồng lấn hoặc khôi phục nhầm một phiên đã kết thúc.

### Edge Cases

- Khi ứng dụng bị đưa xuống nền trong lúc video đang tải dở: hệ thống vẫn phải khôi phục đúng nội dung và quay lại trạng thái xem hợp lệ thay vì khởi tạo một phiên mới mơ hồ.
- Khi hệ thống buộc phải tạo lại màn hình phát sau một gián đoạn tạm thời: tiến trình xem gần nhất vẫn phải được dùng làm điểm tiếp tục nếu nguồn phát còn truy cập được.
- Khi nguồn phát không còn sẵn sàng hoặc quyền truy cập đã thay đổi trong lúc khôi phục: người dùng phải thấy trạng thái lỗi rõ ràng và không bị phát lại sai nội dung.
- Khi người dùng thoát player rất nhanh sau một lần tua hoặc đổi trạng thái phát: hành động cuối cùng của người dùng vẫn phải được phản ánh nhất quán trong lần khôi phục kế tiếp nếu phiên xem chưa kết thúc.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST lưu được ngữ cảnh xem hiện tại trước các gián đoạn tạm thời có thể làm gián đoạn phiên phát.
- **FR-002**: Hệ thống MUST khôi phục đúng nội dung đang xem, vị trí theo dõi gần nhất và trạng thái phát hoặc tạm dừng khi người dùng quay lại từ một gián đoạn tạm thời.
- **FR-003**: Hệ thống MUST bảo toàn ngữ cảnh xem khi màn hình phát bị tạo lại do thay đổi cấu hình hoặc vòng đời màn hình mà không buộc người dùng chọn lại nội dung.
- **FR-004**: Hệ thống MUST phân biệt giữa gián đoạn tạm thời và hành động thoát dứt khoát để quyết định khôi phục phiên xem hay kết thúc hoàn toàn.
- **FR-005**: Hệ thống MUST dừng hoàn toàn phát lại khi người dùng rời player theo cách kết thúc phiên xem.
- **FR-006**: Hệ thống MUST ngăn việc tạo ra nhiều phiên phát đồng thời cho cùng một luồng thao tác của người dùng.
- **FR-007**: Hệ thống MUST áp dụng hành vi lifecycle nhất quán cho cả nguồn phát cục bộ và nguồn phát mạng được hỗ trợ trong Phase 1.
- **FR-008**: Hệ thống MUST phản ánh đúng hành động gần nhất của người dùng trước khi gián đoạn, bao gồm việc vừa tua hoặc vừa chuyển giữa phát và tạm dừng.
- **FR-009**: Hệ thống MUST hiển thị trạng thái phục hồi rõ ràng khi không thể tiếp tục phiên xem thay vì tự khởi động lại một cách khó hiểu hoặc phát sai nội dung.

### Key Entities

- **Playback Session**: Phiên xem hiện hành của người dùng, bao gồm nội dung đang mở, thứ tự nội dung hiện tại nếu có nhiều mục, tiến trình xem và ý định phát hoặc tạm dừng.
- **Lifecycle Snapshot**: Bản ghi trạng thái đủ để tiếp tục phiên xem sau gián đoạn tạm thời, bao gồm dữ liệu cần thiết để nhận diện đúng nội dung và tiếp tục gần đúng vị trí trước đó.
- **Session Transition**: Sự kiện làm thay đổi trạng thái của màn hình phát, chẳng hạn gián đoạn tạm thời, tạo lại giao diện hoặc thoát dứt khoát, dùng để quyết định khôi phục hay kết thúc phiên xem.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Trong kiểm thử foreground/background ngắn hạn, 100% lần quay lại player đưa người dùng về đúng nội dung đang xem và trong sai số không quá 1 giây so với vị trí đã lưu gần nhất.
- **SC-002**: Trong ít nhất 95% kịch bản xoay màn hình hoặc tạo lại giao diện, người dùng tiếp tục được phiên xem hiện tại mà không cần mở lại nguồn phát thủ công.
- **SC-003**: Trong 100% kịch bản thoát dứt khoát khỏi player, phát lại dừng hoàn toàn trong vòng 1 giây và không xuất hiện âm thanh nền còn sót lại.
- **SC-004**: Trong kiểm thử với cả nguồn phát cục bộ và nguồn phát mạng của Phase 1, người kiểm thử hoàn tất toàn bộ kịch bản lifecycle cốt lõi mà không gặp lỗi mất ngữ cảnh nghiêm trọng.

## Assumptions

- Phase 1 chỉ cần hỗ trợ một phiên xem chủ động tại một thời điểm trên màn hình player.
- Nếu nguồn phát vẫn còn truy cập được, hệ thống có thể dùng lại ngữ cảnh xem gần nhất để tiếp tục trải nghiệm thay vì buộc người dùng chọn lại từ đầu.
- Các chế độ phát nền dài hạn, picture-in-picture hoặc phát ngoài màn hình chính không nằm trong phạm vi đặc tả lifecycle này.
- Đặc tả này tập trung vào tính liên tục của nội dung, tiến trình và trạng thái phát cốt lõi; các tuỳ chọn nâng cao ngoài luồng xem cơ bản sẽ được xử lý ở các hạng mục sau nếu cần.