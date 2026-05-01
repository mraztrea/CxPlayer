# Quickstart: Track Selector UI

## Mục tiêu

Thêm popup selector cho audio/subtitle trên playback screen hiện tại, dùng cùng player session đang active, giữ nguyên khả năng nạp phụ đề ngoài đã có và không làm gián đoạn các transport controls hiện hữu.

## Cách triển khai đề xuất

1. Tạo `CxPlayer/app/src/main/java/com/cxplayer/player/TrackSelectorSessionController.kt`:
   - bọc `Player.currentTracks.groups` để trích audio track options ở mức runtime
   - expose thao tác `currentAudioTracks()` và `selectAudioTrack(groupIndex, trackIndex)` qua `TrackSelectionParameters`/`TrackSelectionOverride`
   - chuẩn hóa fallback label khi metadata audio không đủ rõ
2. Tạo `CxPlayer/app/src/main/java/com/cxplayer/ui/controls/TrackSelector.kt`:
   - dựng `PopupWindow` bám vào anchor view
   - render hai section `Audio` và `Subtitles`
   - nhận snapshot/runtime callbacks thay vì tự giữ nguồn state riêng
3. Cập nhật `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`:
   - đổi tap của `playerSettingsButton` sang mở selector popup
   - giữ đường vào file picker phụ đề ngoài bằng `playerOverflowButton`
   - nối callback audio/subtitle selection về `TrackSelectorSessionController` và `SubtitleManager`
   - đảm bảo popup tự dismiss an toàn khi activity recreate hoặc playback session không còn active
4. Thêm resource tối thiểu:
   - `popup_track_selector.xml` cho container popup
   - `item_track_selector_option.xml` cho mỗi dòng lựa chọn
   - string cho section titles, trạng thái empty và feedback message nếu cần
5. Bổ sung test:
   - `TrackSelectorSessionControllerTest.kt` cho audio track mapping, selected state và override routing
   - cập nhật `PlayerActivityPlaybackTest.kt` để xác nhận selector mở được, selection không làm hỏng playback snapshot, và overflow vẫn giữ capability nạp subtitle ngoài

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.TrackSelectorSessionControllerTest
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.SubtitleManagerTest
.\gradlew.bat compileDebugAndroidTestKotlin
.\gradlew.bat assembleDebug
```

Ghi chú:

- `TrackSelectorSessionControllerTest` là kiểm tra hẹp nhất cho mapping audio options và route override đúng.
- `SubtitleManagerTest` cần tiếp tục pass để chứng minh selector không làm lệch contract subtitle vừa có.
- `compileDebugAndroidTestKotlin` là sanity-check phù hợp khi playback screen và instrumentation smoke bị chạm.

## Manual Verification

1. Mở video có từ hai audio track trở lên; chạm nút settings; xác nhận popup hiện hai section và audio track hiện tại được đánh dấu rõ.
2. Chọn audio track khác; xác nhận âm thanh đổi trong vòng 2 giây và video vẫn tiếp tục phát.
3. Với video đã có embedded subtitle hoặc external subtitle đã nạp, mở popup và chọn subtitle khác; xác nhận subtitle đổi đúng.
4. Chọn `Off` trong section subtitle; xác nhận chữ biến mất nhưng audio track vừa chọn vẫn giữ nguyên.
5. Chạm `overflow` để mở file picker phụ đề ngoài; xác nhận capability nạp subtitle ngoài không bị regression sau khi settings button đổi nhiệm vụ.
6. Recreate activity hoặc đổi orientation sau khi selector từng được mở; xác nhận playback screen vẫn phục hồi bình thường và popup không để lại state rác.

## Out of Scope For This Feature

- Tạo dialog chỉnh style subtitle hoàn chỉnh
- Playlist, next/previous, shuffle
- Track selector cho nhiều media item trong queue
- Persistence lựa chọn audio/subtitle giữa nhiều phiên phát
- Thay đổi logic auto-detect hoặc MIME mapping của subtitle ngoài ngoài mức cần để hiển thị trong selector