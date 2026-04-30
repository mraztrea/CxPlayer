# Research: Playback Gesture Controller

## Decision 1: Tách `GestureController` thành touch coordinator độc lập gắn lên `PlayerView`

- **Decision**: Tạo `GestureController` như một lớp riêng chịu trách nhiệm nhận `MotionEvent` từ `PlayerView`, nội bộ phối hợp `GestureDetector` cho tap/long press và `ScaleGestureDetector` cho pinch, sau đó phát ý định điều khiển qua callback đã đặc tả.
- **Rationale**: Spec của feature đã chốt constructor theo callback, và `PlayerActivity` hiện đã là nơi sở hữu `PlayerView` cùng playback actions cơ bản. Tách touch coordinator khỏi activity giữ code điều hướng cử chỉ cô lập, dễ test hơn, và tránh nhồi state machine cảm ứng vào màn hình phát.
- **Alternatives considered**:
  - Xử lý toàn bộ `MotionEvent` trực tiếp trong `PlayerActivity`: nhanh lúc đầu nhưng làm activity phình to và khó kiểm soát xung đột gesture.
  - Dựa vào controller mặc định của `PlayerView`: không đáp ứng mapping gesture tùy biến của Phase 2 và xung đột với việc repo đang giữ `app:use_controller="false"`.

## Decision 2: Khóa vùng điều khiển ở `ACTION_DOWN` và chỉ chốt hướng sau khi vượt ngưỡng nhận diện

- **Decision**: Vùng gesture được xác định từ vị trí chạm đầu tiên trên `PlayerView` và giữ nguyên suốt gesture session; hướng xử lý chỉ được chốt khi khoảng di chuyển vượt ngưỡng đủ lớn để phân biệt vuốt dọc hay vuốt ngang.
- **Rationale**: Spec yêu cầu vuốt dọc nửa trái/phải mang nghĩa khác nhau và edge case đã nêu rõ không được đổi ngữ nghĩa khi ngón tay kéo qua ranh giới giữa chừng. Cách khóa zone sớm nhưng khóa axis muộn giúp tránh false positive khi người dùng mới bắt đầu chạm.
- **Alternatives considered**:
  - Tính zone theo vị trí hiện tại của ngón tay ở mọi frame: dễ gây đổi âm lượng sang độ sáng hoặc ngược lại giữa chừng.
  - Chốt axis ngay từ những pixel đầu tiên: làm tăng nguy cơ nhận nhầm giữa seek ngang và vuốt dọc ở thao tác chưa ổn định.

## Decision 3: Ưu tiên pinch và bảo đảm một gesture session chỉ phát ra một loại outcome đang hoạt động

- **Decision**: Khi `ScaleGestureDetector` nhận đủ tín hiệu pinch, session chuyển sang chế độ zoom và chặn diễn giải vuốt một ngón từ cùng chuỗi chạm; long press được xem là trạng thái tạm thời có cặp callback bắt đầu/kết thúc riêng.
- **Rationale**: Android guidance cho touch listener trên surface media/camera khuyến nghị đưa `ScaleGestureDetector` vào trước và chỉ giao tiếp cho detector còn lại khi pinch không còn in progress. Điều này khớp với requirement FR-009 và FR-011 về tránh outcome mâu thuẫn trong cùng một chuỗi chạm.
- **Alternatives considered**:
  - Cho pinch và swipe cùng xử lý song song: tăng nguy cơ vừa zoom vừa seek/brightness trong cùng một tương tác.
  - Tự viết state machine multi-touch hoàn toàn thủ công: linh hoạt hơn nhưng phức tạp quá mức so với API detector Android đã có.

## Decision 4: Giữ side effect hệ thống ở `PlayerActivity`, `GestureController` chỉ phát ý định điều khiển

- **Decision**: `GestureController` không trực tiếp thay đổi âm lượng, độ sáng hay player state; mọi side effect vẫn đi qua callback để `PlayerActivity` hoặc lớp tích hợp hiện có áp dụng bằng `CxPlayerManager`, `AudioManager` và `Window` brightness.
- **Rationale**: Constructor spec đã định nghĩa callback boundary rõ ràng. Giữ controller ở mức phát ý định giúp test được logic gesture mà không cần dựng toàn bộ Android service, đồng thời không buộc lớp này phụ thuộc vào playback manager hoặc window APIs.
- **Alternatives considered**:
  - Để `GestureController` tự gọi thẳng `AudioManager` và chỉnh `LayoutParams.screenBrightness`: thuận tiện ngắn hạn nhưng tăng coupling với Activity context và khó mock/test.
  - Chuyển logic volume/brightness sang `CxPlayerManager`: không phù hợp vì đây là side effect UI/device-level chứ không phải media engine core.

## Decision 5: Validation dùng kết hợp unit test cho threshold math và instrumentation cho surface integration

- **Decision**: Tách phần tính zone/axis/threshold đủ độc lập để có thể unit test ở `src/test`, đồng thời mở rộng `PlayerActivityPlaybackTest` hoặc thêm instrumentation test để xác nhận `PlayerView` nhận touch listener, callback wiring hoạt động, và các gesture không phá playback session hiện có.
- **Rationale**: Feature này vừa có phần tính toán thuần, vừa có phần phụ thuộc thực vào Android touch dispatch. Chỉ dùng instrumentation sẽ chậm và khó pinpoint lỗi phân loại; chỉ dùng unit test sẽ bỏ sót rủi ro tích hợp với `PlayerView` và lifecycle của activity.
- **Alternatives considered**:
  - Chỉ manual QA: không đủ để khóa regression cho các task 2.2-2.7 nối tiếp.
  - Chỉ instrumentation: kiểm tra được end-to-end nhưng phản hồi chậm và khó cô lập lỗi threshold/zone math.