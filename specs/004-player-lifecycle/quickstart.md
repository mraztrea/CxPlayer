# Quickstart: Player Lifecycle Management

## Mục tiêu

Hoàn thành feature lifecycle cho player bằng cách làm chắc việc attach/load/release session trong `PlayerActivity`, bảo toàn đúng nội dung và ý định phát qua recreate hoặc foreground/background ngắn hạn, đồng thời bảo đảm không còn session hoặc audio rò rỉ khi người dùng kết thúc phiên xem.

## Cách triển khai đề xuất

1. Cập nhật `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`:
   - giữ `onCreate()` cho inflate layout, parse intent và restore snapshot
   - tinh chỉnh `onStart()` để bắt đầu hoặc khôi phục session đúng request hiện hành
   - capture snapshot trước khi activity rời foreground và release session theo boundary đã chọn
   - giữ `onNewIntent()` như ranh giới thay thế session, không resume nhầm snapshot của request cũ
2. Điều chỉnh `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt` nếu cần:
   - giữ một session owner duy nhất
   - bảo đảm `load(snapshot=...)` ưu tiên snapshot hợp lệ hơn request defaults
   - giữ `release()` idempotent và trạng thái manager nhất quán sau stop/destroy
3. Mở rộng validation host-side ở `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt` cho các trường hợp release rồi reload, snapshot precedence và single-session semantics.
4. Mở rộng instrumentation ở `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt` cho:
   - `scenario.recreate()` giữ item hiện tại và play/pause intent
   - foreground/background ngắn hạn qua `moveToState()`
   - clean release khi activity kết thúc và không khôi phục nhầm session cũ

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
.\gradlew.bat testDebugUnitTest --tests "com.cxplayer.player.CxPlayerManagerTest" --tests "com.cxplayer.ui.player.PlayerActivityLaunchParserTest"
.\gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest
```

## Manual Verification

1. Mở video local, tạm dừng, tua tới vị trí khác rồi trigger recreate; xác nhận item hiện tại, vị trí và ý định pause vẫn được giữ.
2. Mở video HTTP, đưa app về trạng thái nền ngắn hạn rồi quay lại; xác nhận cùng nội dung được khôi phục và không nhảy về item khác.
3. Mở một video khác khi `PlayerActivity` đang tồn tại; xác nhận player thay sang request mới thay vì resume snapshot của video cũ.
4. Thoát hẳn khỏi player trong khi đang phát; xác nhận audio dừng sạch và mở lại player không kéo theo session cũ.

## Out of Scope For This Feature

- Background playback service, media notification hoặc MediaSession cho phát dài hạn ngoài player screen
- Picture-in-Picture, playback controls ngoài activity hoặc tích hợp với system media controls
- Resume session sau process death dài hạn bằng persistent storage
- Thay đổi manifest/navigation model vượt quá nhu cầu lifecycle của Phase 1