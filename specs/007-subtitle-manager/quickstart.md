# Quickstart: Subtitle Manager

## Mục tiêu

Thêm quản lý subtitle vào playback screen hiện tại mà không đổi ownership của `CxPlayerManager`: hỗ trợ auto-detect subtitle ngoài cùng tên, nạp subtitle ngoài trong lúc phát, chọn/tắt embedded subtitle, và đổi style subtitle ngay trên `PlayerView`.

## Cách triển khai đề xuất

1. Tạo `CxPlayer/app/src/main/java/com/cxplayer/player/SubtitleManager.kt`:
   - nhận `ExoPlayer` và `PlayerView` hoặc một seam đủ nhỏ để thao tác `MediaItem`, `TrackSelectionParameters` và `subtitleView`
   - expose các thao tác ở mức feature như `autoDetectExternalSubtitle`, `loadExternalSubtitle`, `selectSubtitleSource`, `disableSubtitles`, `applySubtitleStyle`
2. Giữ `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt` làm session owner:
   - không mở public API mới nếu không thực sự cần
   - nếu cần lộ seam cho subtitle, ưu tiên lộ player collaborator ở mức internal thay vì nhét toàn bộ subtitle logic vào manager
3. Cập nhật `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`:
   - tạo `SubtitleManager` gắn với `playerView` và player session đang active
   - chạy auto-detect sau khi `beginPlaybackSession()` hoàn tất và đã có media source hiện hành
   - nối action từ settings hoặc overflow button sang subtitle actions tối thiểu của feature này
4. Nếu cần thêm label hoặc state UI tối thiểu, chỉnh `CxPlayer/app/src/main/res/layout/activity_player.xml` và resource strings liên quan, nhưng tránh mở popup selector đầy đủ của task 3.8 trong feature này.
5. Bổ sung test:
   - `CxPlayer/app/src/test/java/com/cxplayer/player/SubtitleManagerTest.kt` cho auto-detect, mime mapping, state transitions và style snapshot
   - cập nhật `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt` hoặc test đồng cấp để xác nhận playback screen không crash khi subtitle action xảy ra
6. Chuẩn bị manual verification:
   - `video.mp4` + `video.srt`
   - sample `.ass` hoặc `.vtt`
   - sample MKV/MP4 có embedded subtitle
   - một subtitle lỗi hoặc unsupported để xác nhận graceful failure

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.SubtitleManagerTest
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.CxPlayerManagerTest
.\gradlew.bat compileDebugAndroidTestKotlin
.\gradlew.bat assembleDebug
```

Ghi chú:

- `SubtitleManagerTest` là test hẹp nhất để khóa basename detection, source selection và style mapping.
- `CxPlayerManagerTest` nên tiếp tục pass để chứng minh subtitle feature không làm hỏng playback session contract hiện có.
- `compileDebugAndroidTestKotlin` là sanity-check phù hợp nếu playback screen androidTest được chạm nhưng chưa sẵn sample media automation hoàn chỉnh.

## Manual Verification

1. Mở `video.mp4` có `video.srt` đặt cạnh; xác nhận subtitle tự hiện trong vòng 2 giây sau khi video bắt đầu phát.
2. Khi đang phát video không có subtitle active, nạp một file `.ass` hoặc `.vtt`; xác nhận subtitle xuất hiện mà video không restart từ đầu.
3. Mở sample có embedded subtitle; chọn một track nhúng rồi tắt subtitle; xác nhận mỗi lần chỉ có một nguồn active hoặc hoàn toàn tắt.
4. Đổi font size, bold, màu chữ và kiểu viền; xác nhận thay đổi thấy ngay trên `PlayerView`.
5. Nạp subtitle lỗi hoặc unsupported; xác nhận video tiếp tục xem được và người dùng vẫn đổi hoặc tắt subtitle được.
6. Sau một thao tác subtitle thành công hoặc thất bại, dùng play/pause/seek; xác nhận playback controls vẫn hoạt động như cũ.

## Out of Scope For This Feature

- Popup track selector riêng cho audio/subtitle
- Audio track selection
- Playlist, next/previous, shuffle
- Đồng bộ cài đặt subtitle giữa nhiều phiên hoặc nhiều thiết bị
- Quét tự động subtitle cho `content://` hoặc media remote ngoài contract basename local file