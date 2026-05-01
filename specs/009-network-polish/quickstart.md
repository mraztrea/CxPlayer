# Quickstart: Network Polish

## Mục tiêu

Thêm network playback seam đủ mạnh để HTTP/LAN và SMB hoạt động ổn định, đồng thời giữ continuity của phiên phát qua PiP, background audio và orientation lock mà không phá local playback flow đang có.

## Cách triển khai đề xuất

1. Cập nhật playback core trong `CxPlayer/app/src/main/java/com/cxplayer/player/`:
   - thêm `CxLoadControl.kt` cho buffer profile LAN
   - thêm `CxMediaSourceFactory.kt` để route source theo scheme
   - chỉnh `CxPlayerManager.kt` để dùng media source factory, wake policy và session owner mới
2. Thêm datasource layer trong `CxPlayer/app/src/main/java/com/cxplayer/data/datasource/`:
   - `CxDataSourceFactory.kt` làm cầu nối `DefaultDataSource.Factory` + `OkHttpDataSource.Factory`
   - `SmbDataSource.kt` để mở read stream từ SMB theo nhu cầu playback
3. Thêm SMB browse seam trong `CxPlayer/app/src/main/java/com/cxplayer/network/SmbBrowser.kt`:
   - connect/authenticate/list directory với timeout rõ ràng
   - map file/directory sang model browser tối thiểu
   - chỉ mở read-only access cần thiết cho playback path
4. Chuyển ownership playback continuity sang `PlaybackService.kt`:
   - host `MediaSessionService` và player session dùng chung cho foreground/PiP/background
   - `PlayerActivity` chỉ attach/detach `PlayerView`, không release toàn bộ player ở `onStop`
5. Cập nhật `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` và `AndroidManifest.xml`:
   - bật PiP support, thêm lifecycle guard cho PiP
   - mở flow browse/play SMB từ UI hiện có hoặc browser dialog tối thiểu
   - thêm orientation lock controls và lưu state qua recreate
6. Bổ sung test hẹp trước khi wiring UI sâu:
   - `PlaybackRequestParserTest.kt` cho source classification, đặc biệt internal SMB launch
   - `CxPlayerManagerTest.kt` cho wake/load/media source policy
   - `SmbBrowserContractTest.kt` cho mapping browse result và lỗi auth/path
   - mở rộng `PlayerActivityPlaybackTest.kt` cho PiP/orientation/background continuity smoke

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.CxPlayerManagerTest
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.PlaybackRequestParserTest
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.SmbBrowserContractTest
.\gradlew.bat compileDebugKotlin
.\gradlew.bat compileDebugAndroidTestKotlin
.\gradlew.bat assembleDebug
```

Ghi chú:

- `CxPlayerManagerTest` là check rẻ nhất để falsify wake mode, load control và source routing trước khi chạm UI.
- `PlaybackRequestParserTest` khóa việc không regression các scheme cũ khi thêm flow SMB nội bộ.
- `compileDebugAndroidTestKotlin` phù hợp để sanity-check phần PiP/orientation smoke test nếu chưa có thiết bị chạy instrumentation.

## Manual Verification

1. Mở một video HTTP trên LAN ổn định; xác nhận bắt đầu phát nhanh, seek vẫn phản hồi và phiên phát không bị drop bất thường.
2. Mở flow SMB, nhập host/share/user/pass hợp lệ, duyệt thư mục rồi chọn video; xác nhận video phát trực tiếp mà không cần copy local trước.
3. Dùng credential sai hoặc share không tồn tại; xác nhận app báo lỗi rõ ràng và không treo playback shell.
4. Khi video đang phát, nhấn Home trên thiết bị hỗ trợ PiP; xác nhận PiP vào được và quay lại app vẫn giữ vị trí phát.
5. Khi audio đang phát, tắt màn hình hoặc đưa app xuống nền; xác nhận audio tiếp tục nếu user chưa pause.
6. Đổi orientation lock qua các trạng thái rồi recreate activity; xác nhận requested orientation và playback snapshot vẫn giữ đúng.

## Out of Scope For This Feature

- Lưu credential SMB vĩnh viễn hoặc đồng bộ nhiều server đã lưu
- Tạo thư viện media mạng đầy đủ với indexing, search hoặc thumbnail generation
- Hỗ trợ external implicit `smb://` launch từ ứng dụng khác
- Tạo notification/media controls hoàn chỉnh vượt quá nhu cầu continuity tối thiểu của background playback