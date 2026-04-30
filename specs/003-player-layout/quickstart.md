# Quickstart: Playback Screen Layout

## Mục tiêu

Hoàn thành task 1.4 bằng cách thay `activity_player.xml` từ một surface trống thành màn hình player fullscreen có top bar, timeline và transport controls, sẵn sàng cho các task hành vi 1.5 và 1.6.

## Cách triển khai đề xuất

1. Mở rộng `CxPlayer/app/src/main/res/layout/activity_player.xml`:
   - giữ `PlayerView` fullscreen làm lớp render nền
   - thêm top region với back button, title, overflow button
   - thêm bottom region với current time, seek control, duration và hàng transport actions
2. Cập nhật `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` để:
   - bind các view mới
   - áp dụng insets cho top/bottom overlay
   - chuẩn bị callback chạm cơ bản hoặc no-op wiring an toàn cho các action sẽ hoàn thiện ở task sau
3. Bổ sung resource hỗ trợ nếu cần:
   - `CxPlayer/app/src/main/res/values/strings.xml` cho content description và fallback title
   - `CxPlayer/app/src/main/res/drawable/` cho icon transport nếu repo chưa có icon phù hợp
4. Mở rộng validation ở `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt` hoặc tách thêm test layout nếu assertions UI trở nên nhiều.

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
.\gradlew.bat testDebugUnitTest
.\gradlew.bat connectedDebugAndroidTest
```

## Manual Verification

1. Mở video cục bộ và xác nhận top bar, timeline, transport row đều nhìn thấy trên màn hình đầu tiên.
2. Mở video HTTP và xác nhận khi metadata chưa sẵn sàng, bố cục không giật và control không nhảy vị trí.
3. Xoay portrait sang landscape rồi quay lại, xác nhận mọi control chính vẫn còn trong viewport và chạm được.
4. Dùng video có tiêu đề dài hoặc thiếu tiêu đề, xác nhận back button và overflow vẫn giữ được vị trí, title xuống cấp gọn gàng.
5. Kiểm tra fullscreen immersive để bảo đảm system bars không che lên top/bottom controls.

## Out of Scope For This Feature

- Logic hoàn chỉnh cho play/pause, seek bar và seek ±10 giây của task 1.5-1.6
- Menu settings hoặc volume panel chi tiết phía sau các điểm vào action
- Tablet-specific layout hoặc split-screen optimizations
- Rebuild toàn bộ player screen sang Compose