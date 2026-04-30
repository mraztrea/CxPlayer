# Contract: Player Lifecycle Management

## Purpose

Định nghĩa contract vận hành vòng đời cho màn hình player ở Phase 1, bao gồm ownership của session phát, dữ liệu snapshot được phép lưu, ranh giới thay thế session khi nhận intent mới và các điều kiện cần giữ nhất quán qua recreate hoặc foreground/background ngắn hạn.

## Session Ownership Contract

- `PlayerActivity` là owner của luồng lifecycle cho phiên playback hiện tại.
- `CxPlayerManager` là owner duy nhất của player session cụ thể, chịu trách nhiệm tạo, bind, export snapshot và release.
- Mỗi activity instance chỉ được gắn với tối đa một session active tại một thời điểm.
- `PlayerView` chỉ render session đang active trong manager; khi session bị release, view không được giữ tham chiếu player cũ.

## Activity Callback Contract

### `onCreate()`

- Inflate layout, bind view và parse request đầu vào.
- Restore snapshot đã được lưu trong `savedInstanceState` nếu có.
- Không tạo session playback lâu dài ở bước này.

### `onStart()`

- Nếu có request hợp lệ đang chờ, attach `PlayerView` vào manager và load session.
- Nếu có snapshot hợp lệ cho request hiện hành, snapshot phải được ưu tiên hơn start position mặc định của request.

### `onSaveInstanceState()`

- Capture snapshot từ session hiện tại trước khi gọi `super.onSaveInstanceState(...)`.
- Chỉ lưu dữ liệu tối thiểu đủ để khôi phục continuity: item index, position, play/pause intent.

### `onStop()`

- Capture snapshot gần nhất cho phiên hiện hành.
- Release session player sạch sẽ để không còn audio hoặc session tồn đọng ngoài foreground.

### `onNewIntent()`

- Request mới thay thế request hiện hành.
- Snapshot đang chờ của request cũ không được dùng để resume nội dung mới.
- Activity phải có khả năng bắt đầu lại session cho request mới mà không tạo activity instance thứ hai.

### `onDestroy()`

- Release phải idempotent: có thể gọi lại mà không tạo lỗi hoặc đổi trạng thái sai.

## Snapshot Contract

- Snapshot gồm đúng ba giá trị lifecycle: `currentIndex`, `currentPositionMs`, `playWhenReady`.
- `currentIndex` phải hợp lệ với playlist của request hiện hành trước khi được áp dụng.
- `currentPositionMs` luôn là giá trị không âm.
- `playWhenReady` phải phản ánh ý định cuối cùng của người dùng trước khi gián đoạn.

## Restore and Replacement Rules

- Với gián đoạn tạm thời hoặc recreate, player phải khôi phục cùng nội dung và cùng ý định play/pause nếu request gốc vẫn hợp lệ.
- Với `onNewIntent()`, player phải thay sang request mới thay vì hồi sinh session cũ.
- Với hành động kết thúc phiên xem, player phải ở trạng thái released hoàn toàn và không tự khôi phục nếu chưa có request hợp lệ mới.

## Failure Handling Rules

- Nếu request hiện hành không còn nguồn phát hợp lệ khi restore, activity phải đi vào luồng lỗi rõ ràng thay vì phát sai nội dung.
- Nếu snapshot không hợp lệ với request hiện hành, request defaults được dùng làm fallback duy nhất.
- Không được tồn tại hai nguồn sự thật cạnh tranh cho vị trí phát; snapshot và request phải được áp theo thứ tự ưu tiên đã định nghĩa ở contract này.

## Validation Hooks

- `CxPlayerManagerTest` phải chứng minh single-session semantics, snapshot precedence và release/reload consistency.
- `PlayerActivityPlaybackTest` phải chứng minh recreate, foreground/background ngắn hạn và continuity của play/pause intent.
- Contract này được xem là pass khi các test trên đi qua và manual verification không cho thấy audio/session leak sau khi thoát player.