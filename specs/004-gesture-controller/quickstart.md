# Quickstart: Playback Gesture Controller

## Mục tiêu

Triển khai và validate feature gesture playback với mapping định lượng của task 2.2: volume `±1 / 150px` ở nửa phải, brightness `±0,05 / 150px` ở nửa trái, seek `distance * 100ms`, double tap giữa để play/pause, double tap hai bên để seek `±10s`, long press để giữ `2x`, và pinch zoom trong dải `1,0x -> 3,0x` mà không cần thay đổi controller mặc định của Media3.

## Cách triển khai đề xuất

1. Tạo `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt`:
   - nhận `PlayerView` và toàn bộ callback theo spec
   - nội bộ phối hợp `GestureDetector` và `ScaleGestureDetector`
   - gom toàn bộ hằng số mapping vào một threshold profile thống nhất: `150px`, `1f`, `0.05f`, `100ms`, `10000ms`, `2f`, `1f`, `3f`
   - khóa zone từ lúc chạm bắt đầu, khóa axis khi vượt ngưỡng, và bảo đảm mỗi gesture session chỉ có một outcome đang hoạt động
2. Cập nhật `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` để:
   - khởi tạo `GestureController` sau khi `playerView` đã sẵn sàng
   - map callback vào `pausePlayback()`, `playPlayback()`, `seekToPosition()`, `seekBack()`, `seekForward()` hoặc API tương đương theo delta
   - áp dụng volume qua `AudioManager` và brightness qua `window.attributes.screenBrightness` ở activity thay vì trong controller
3. Bổ sung test:
   - `CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt` cho zone math, axis lock, threshold profile và callback sequencing
   - mở rộng `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt` hoặc thêm test instrumentation để xác nhận `PlayerView` được gắn gesture listener và gesture không phá playback session
4. Giữ phạm vi giới hạn:
   - chưa thêm overlay UI cho volume/brightness/seek
   - chưa thêm speed selector, aspect ratio hoặc repeat mode

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.ui.player.GestureControllerTest
.\gradlew.bat compileDebugAndroidTestKotlin
.\gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest
```

Ghi chú:

- Nếu chưa có emulator hoặc thiết bị thật, `compileDebugAndroidTestKotlin` là bước sanity-check tối thiểu cho androidTest.
- Nếu chạy trên thiết bị thật và gặp `INSTALL_FAILED_ABORTED`, cần mở màn hình thiết bị và chấp nhận prompt cài test app trước khi chạy lại instrumentation.

## Manual Verification

1. Mở một video và vuốt dọc nửa phải `PlayerView` khoảng `300px`, xác nhận âm lượng tăng tương đương 2 bước; vuốt xuống `150px`, xác nhận âm lượng giảm 1 bước.
2. Vuốt dọc nửa trái `150px`, xác nhận độ sáng thay đổi khoảng `0,05` theo chiều vuốt và không phát callback volume.
3. Vuốt ngang sang phải `250px`, xác nhận delta seek xấp xỉ `+25000ms`; vuốt sang trái cùng quãng đường, xác nhận delta seek xấp xỉ `-25000ms`.
4. Double tap vùng giữa, xác nhận play/pause toggle đúng một lần cho mỗi thao tác.
5. Double tap trái/phải, xác nhận phát sinh seek delta cố định ±10 giây.
6. Nhấn giữ rồi thả, xác nhận callback bắt đầu/kết thúc fast forward xuất hiện thành cặp và không bị kẹt trạng thái.
7. Pinch in/pinch out, xác nhận callback zoom nhận scale factor trong dải `1,0x -> 3,0x` và không đồng thời phát seek/brightness/volume từ cùng session.

## Out of Scope For This Feature

- Overlay UI cho feedback gesture ở task 2.8
- Menu chỉnh tốc độ phát của task 2.9
- Aspect ratio toggle của task 2.10
- Repeat mode của task 2.11
- Tối ưu riêng cho tablet, TV hoặc non-touch input devices