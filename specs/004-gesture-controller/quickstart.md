# Quickstart: Playback Gesture Controller

## Mục tiêu

Triển khai task 2.1 bằng cách thêm `GestureController` làm touch listener tổng hợp cho `PlayerView`, cho phép `PlayerActivity` nhận callback volume, brightness, seek, play/pause, fast forward tạm thời và zoom mà không cần thay đổi controller mặc định của Media3.

## Cách triển khai đề xuất

1. Tạo `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt`:
   - nhận `PlayerView` và toàn bộ callback theo spec
   - nội bộ phối hợp `GestureDetector` và `ScaleGestureDetector`
   - khóa zone từ lúc chạm bắt đầu, khóa axis khi vượt ngưỡng, và bảo đảm mỗi gesture session chỉ có một outcome đang hoạt động
2. Cập nhật `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` để:
   - khởi tạo `GestureController` sau khi `playerView` đã sẵn sàng
   - map callback vào `pausePlayback()`, `playPlayback()`, `seekToPosition()`, `seekBack()`, `seekForward()` hoặc API tương đương theo delta
   - áp dụng volume qua `AudioManager` và brightness qua `window.attributes.screenBrightness` ở activity thay vì trong controller
3. Bổ sung test:
   - `CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt` cho zone math, axis lock, threshold và callback sequencing
   - mở rộng `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt` hoặc thêm test instrumentation để xác nhận `PlayerView` được gắn gesture listener và gesture không phá playback session
4. Giữ phạm vi giới hạn:
   - chưa thêm overlay UI cho volume/brightness/seek
   - chưa thêm speed selector, aspect ratio hoặc repeat mode

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.ui.player.GestureControllerTest
.\gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest
```

## Manual Verification

1. Mở một video và vuốt dọc nửa phải `PlayerView`, xác nhận chỉ callback volume được kích hoạt.
2. Vuốt dọc nửa trái, xác nhận chỉ callback brightness được kích hoạt.
3. Vuốt ngang trên vùng phát, xác nhận delta seek có dấu đúng theo hướng kéo.
4. Double tap vùng giữa, xác nhận play/pause toggle đúng một lần cho mỗi thao tác.
5. Double tap trái/phải, xác nhận phát sinh seek delta cố định ±10 giây.
6. Nhấn giữ rồi thả, xác nhận callback bắt đầu/kết thúc fast forward xuất hiện thành cặp và không bị kẹt trạng thái.
7. Pinch in/pinch out, xác nhận callback zoom nhận scale factor và không đồng thời phát seek/brightness/volume từ cùng session.

## Out of Scope For This Feature

- Overlay UI cho feedback gesture ở task 2.8
- Menu chỉnh tốc độ phát của task 2.9
- Aspect ratio toggle của task 2.10
- Repeat mode của task 2.11
- Tối ưu riêng cho tablet, TV hoặc non-touch input devices