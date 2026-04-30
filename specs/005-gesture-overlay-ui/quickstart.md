# Quickstart: Gesture Overlay UI

## Mục tiêu

Triển khai overlay phản hồi cử chỉ cho màn hình phát để người dùng nhìn thấy ngay trạng thái volume, brightness, seek delta và fast-forward 2x trong khi thao tác. Overlay phải chỉ có một card hiển thị tại một thời điểm, xuất hiện nhanh, tự ẩn đúng lúc và không làm hỏng touch flow của `PlayerView`.

## Cách triển khai đề xuất

1. Cập nhật `CxPlayer/app/src/main/res/layout/activity_player.xml`:
   - thêm một overlay container nằm trên `PlayerView`
   - overlay card có cue trực quan và vùng text giá trị
   - đặt cấu hình để overlay không nuốt touch của người dùng
2. Cập nhật `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`:
   - bind các view overlay mới từ `ActivityPlayerBinding`
   - dựng helper để hiển thị volume percent, brightness percent, seek delta và fast-forward 2x từ callback gesture hiện có
   - lên lịch tự ẩn overlay bằng cơ chế UI-thread delay có thể reset khi nhận update mới
   - cleanup overlay khi activity dừng hoặc `gestureController.release()` được gọi
3. Chỉ mở rộng `GestureController.kt` nếu implementation thực tế thiếu tín hiệu để biết lifecycle show or hide của overlay; mặc định ưu tiên không đổi constructor vì callback hiện tại đã đủ cho 4 loại feedback trong scope
4. Bổ sung resource nếu cần:
   - background drawable hoặc shape cho overlay card
   - strings hoặc dimens cho label và spacing
5. Bổ sung test:
   - host-side test cho mapper hoặc formatter overlay state
   - instrumentation trong `PlayerActivityPlaybackTest.kt` cho show, replace và auto-dismiss lifecycle của overlay

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.ui.player.GestureControllerTest
.\gradlew.bat compileDebugAndroidTestKotlin
.\gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest
```

Ghi chú:

- Nếu overlay formatter được tách ra file test riêng, thay filter `--tests` bằng class test thực tế của overlay.
- Nếu chưa có emulator hoặc thiết bị thật, `compileDebugAndroidTestKotlin` là bước sanity-check tối thiểu cho phần androidTest.
- Nếu chạy trên thiết bị thật và gặp `INSTALL_FAILED_ABORTED`, cần mở màn hình thiết bị và chấp nhận prompt cài test app trước khi chạy lại instrumentation.

## Manual Verification

1. Phát video và vuốt dọc nửa phải; xác nhận overlay volume xuất hiện gần như tức thời, hiển thị phần trăm hiện tại và tự ẩn sau khi ngừng vuốt.
2. Vuốt dọc nửa trái; xác nhận overlay brightness xuất hiện đúng loại, không còn overlay volume cũ chồng lên.
3. Vuốt ngang sang trái hoặc phải; xác nhận overlay seek hiển thị đúng dấu `+` hoặc `-` cùng delta thời gian dễ đọc.
4. Nhấn giữ để kích hoạt 2x; xác nhận overlay fast-forward hiện xuyên suốt thời gian giữ và biến mất ngay sau khi thả hoặc cancel.
5. Thực hiện volume rồi seek liên tiếp trước khi overlay đầu tiên tự ẩn; xác nhận card hiện tại được thay nội dung tại chỗ thay vì có hai overlay.
6. Đưa volume hoặc brightness về biên tối đa hoặc tối thiểu rồi tiếp tục vuốt theo cùng hướng; xác nhận overlay vẫn hiển thị giá trị biên thực tế, không vượt phạm vi.
7. Rời activity hoặc rotate nếu test scenario yêu cầu; xác nhận overlay không bị kẹt lại sau cleanup lifecycle.

## Out of Scope For This Feature

- Feedback overlay cho double tap play/pause hoặc seek cố định ±10 giây
- Feedback overlay cho pinch zoom
- Speed selector của task 2.9
- Aspect ratio toggle của task 2.10
- Repeat mode của task 2.11