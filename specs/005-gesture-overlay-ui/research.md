# Research: Gesture Overlay UI

## Decision 1: Giữ overlay state ở `PlayerActivity`, không mở rộng constructor của `GestureController`

- **Decision**: Overlay sẽ được điều phối trong `PlayerActivity` dựa trên các callback gesture hiện có như `onVolumeChange`, `onBrightnessChange`, `onSeekDelta`, `onFastForward` và `onFastForwardEnd` thay vì thêm một contract overlay riêng vào `GestureController`.
- **Rationale**: `GestureController` hiện đã phát đúng intent gesture, còn `PlayerActivity` mới là nơi biết trạng thái âm lượng, độ sáng cửa sổ, vị trí phát và playback speed đang áp dụng thực tế. Giữ overlay ở boundary này giúp hiển thị đúng giá trị sau khi side effect đã được áp dụng, đồng thời tránh phải lan thêm interface mới qua toàn bộ test và wiring gesture đã tồn tại.
- **Alternatives considered**:
  - Thêm callback overlay event trực tiếp từ `GestureController`: tăng coupling giữa lớp nhận diện gesture và lớp hiển thị UI, đồng thời làm contract hiện có nặng hơn dù dữ liệu hiển thị cuối cùng vẫn phải được PlayerActivity chuẩn hóa lại.
  - Tạo một controller UI riêng độc lập với activity: linh hoạt hơn nhưng quá mức cần thiết cho một overlay ngắn sống cùng vòng đời màn hình phát.

## Decision 2: Dùng một overlay card duy nhất ở giữa màn hình và thay nội dung theo loại gesture

- **Decision**: Layout sẽ có một vùng overlay trung tâm duy nhất, gồm cue trực quan và giá trị hiển thị, rồi thay nội dung theo loại gesture đang hoạt động thay vì dựng nhiều widget riêng cho volume, brightness, seek và fast-forward.
- **Rationale**: Spec yêu cầu tại mọi thời điểm chỉ có một trạng thái overlay có hiệu lực. Một card duy nhất giúp thực thi quy tắc này tự nhiên, giảm xung đột z-order với top/bottom chrome và tránh trường hợp nhiều chỉ báo chồng lấp khi người dùng thao tác liên tiếp.
- **Alternatives considered**:
  - Tạo bốn overlay view độc lập rồi bật tắt theo loại gesture: dễ dẫn tới logic show or hide rời rạc và tăng nguy cơ overlay cũ không được dọn sạch.
  - Gắn feedback trực tiếp vào từng cạnh màn hình: có thể gần logic trái phải hơn nhưng làm UI phân mảnh và khó giữ nhất quán với seek hoặc fast-forward.

## Decision 3: Tự ẩn bằng lịch hẹn lại trên UI thread, không dùng animation framework hoặc timer phức tạp

- **Decision**: Overlay được hiện ngay khi có gesture được hỗ trợ, và lịch tự ẩn sẽ được reset bằng cơ chế `postDelayed` hoặc tương đương trên view root mỗi khi nhận cập nhật mới.
- **Rationale**: Đây là mẫu phù hợp cho transient UI trong Android view system: đơn giản, không cần dependency bổ sung, và đủ kiểm soát để hủy lịch ẩn cũ khi gesture tiếp tục hoặc khi activity bị destroy. Nó cũng khớp trực tiếp với yêu cầu hiển thị dưới 0,2 giây và tự ẩn dưới 1 giây.
- **Alternatives considered**:
  - Dùng `Handler` hoặc timer tách rời: giải quyết được bài toán tương tự nhưng tăng bề mặt quản lý lifecycle mà không mang thêm lợi ích rõ rệt.
  - Giữ overlay hiện cho tới khi callback khác chủ động tắt: dễ bị kẹt trạng thái khi gesture bị hủy hoặc activity mất focus.

## Decision 4: Chuẩn hóa dữ liệu hiển thị theo giá trị thực đã clamp sau side effect

- **Decision**: Overlay phần trăm âm lượng và độ sáng sẽ lấy từ giá trị đang có hiệu lực sau khi áp dụng delta và clamp biên; overlay seek dùng delta có dấu ở định dạng thời gian ngắn; overlay fast-forward dùng thông điệp 2x cố định.
- **Rationale**: Spec yêu cầu overlay phản ánh đúng trạng thái biên thực tế và không hiển thị giá trị vượt phạm vi. Dùng giá trị sau khi áp dụng side effect tại activity là cách trực tiếp nhất để không drift giữa hành vi thật và thứ người dùng nhìn thấy.
- **Alternatives considered**:
  - Hiển thị giá trị dự đoán trước khi apply: đơn giản hơn nhưng có thể sai khi hệ thống clamp ở mức tối đa hoặc tối thiểu.
  - Hiển thị delta thuần cho volume và brightness: đúng về kỹ thuật nhưng kém trực quan hơn phần trăm hiện tại mà spec đã ưu tiên.

## Decision 5: Validation chia làm hai lớp, tách mapping hiển thị khỏi visibility integration

- **Decision**: Host-side tests sẽ khóa logic dựng overlay state hoặc formatter chuỗi hiển thị, còn instrumentation trong `PlayerActivityPlaybackTest` sẽ xác nhận overlay xuất hiện, được thay thế đúng khi gesture đổi loại và tự ẩn đúng vòng đời mong đợi trên activity thật.
- **Rationale**: Formatting phần trăm, delta thời gian và state replacement có thể kiểm thử nhanh ở host-side mà không cần dựng UI đầy đủ. Phần visibility, z-order và touch continuity lại cần instrumentation để chắc rằng overlay không phá `PlayerView` và chrome hiện có.
- **Alternatives considered**:
  - Chỉ dùng instrumentation: kiểm thử chậm và khó chẩn đoán lỗi format hoặc state mapping.
  - Chỉ dùng manual QA: không đủ để khóa regression cho các task Phase 2 kế tiếp vốn tiếp tục chạm vào cùng màn hình phát.