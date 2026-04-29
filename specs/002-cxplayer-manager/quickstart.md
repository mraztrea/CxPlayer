# Quickstart: Playback Session Manager

## Mục tiêu

Hoàn thành task 1.3 bằng cách đưa ownership của `ExoPlayer` vào `CxPlayerManager` và giữ `PlayerActivity` ở vai trò orchestration UI + launch intent boundary.

## Cách triển khai đề xuất

1. Tạo `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt` với các trách nhiệm tối thiểu:
   - tạo/release `ExoPlayer`
   - attach/detach `PlayerView`
   - set playlist từ `PlaybackRequest` đã normalize
   - expose play/pause/seek ±10s/snapshot state
2. Refactor `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` để:
   - giữ parser launch hiện tại
   - ủy quyền toàn bộ ownership của player cho manager
   - dùng `savedInstanceState` để restore `PlaybackSnapshot`
   - release ở callback lifecycle đối xứng theo API level
3. Thêm hoặc cập nhật unit test:
   - `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt`
   - `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
4. Thêm smoke test instrumentation nếu implementation chạm vào lifecycle/wiring của activity:
   - `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
.\gradlew.bat testDebugUnitTest
.\gradlew.bat connectedDebugAndroidTest
```

## Manual Verification

1. Mở một file MP4 cục bộ từ file manager và xác nhận player phát được.
2. Mở một URL `http` hoặc `https` hợp lệ và xác nhận player prepare/phát được.
3. Cho request với `startIndex` ngoài phạm vi nhưng còn nguồn phát hợp lệ, xác nhận player fallback về item hợp lệ gần nhất mà không báo lỗi.
4. Xoay màn hình trong lúc đang phát và xác nhận vị trí restore lệch không quá 1 giây.
5. Gọi play/pause/seek ±10 giây và xác nhận không crash, không tạo thêm player session thứ hai.

## Out of Scope For This Feature

- Background playback service hoặc `MediaSession`
- Playlist persistence vượt quá `savedInstanceState`
- Thiết kế full control bar/UI polish của các task 1.4-1.6
- DI hoàn chỉnh bằng Hilt cho player flow nếu chưa cần để hoàn thành manager