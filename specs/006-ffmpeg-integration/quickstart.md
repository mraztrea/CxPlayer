# Quickstart: FFmpeg Integration

## Mục tiêu

Mở rộng playback stack hiện tại để Media3 có thể ưu tiên FFmpeg decoder cho các codec mục tiêu của phase 3, trong khi vẫn giữ nguyên trải nghiệm mở file và API `CxPlayerManager` đã có.

## Cách triển khai đề xuất

1. Cập nhật dependency management trong `CxPlayer/gradle/libs.versions.toml` và `CxPlayer/app/build.gradle.kts`:
   - thêm alias cho `androidx.media3:media3-decoder-ffmpeg`
   - dùng cùng `version.ref = "media3"` với các module Media3 hiện có
2. Thêm `CxPlayer/app/src/main/java/com/cxplayer/player/CxRenderersFactory.kt`:
   - kế thừa `DefaultRenderersFactory`
   - cấu hình extension renderer mode ở mức ưu tiên extension
   - bật decoder fallback để giảm hard failure khi codec hợp lệ cần đường thay thế
3. Cập nhật `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`:
   - chỉ thay ở `ExoPlayerSessionFactory.create()` để truyền `CxRenderersFactory` vào `ExoPlayer.Builder`
   - giữ nguyên seek increments, lifecycle và public API của `CxPlayerManager`
4. Bổ sung test tại `CxPlayer/app/src/test/java/com/cxplayer/player/`:
   - khóa việc session factory tiếp tục giữ seek increments cũ sau khi wiring renderers factory mới
   - khóa các regression dễ thấy ở public contract của `CxPlayerManager` nếu test seam hiện có cho phép
5. Chuẩn bị manual verification với sample media:
   - một file MKV có DTS hoặc AC3
   - một file H.265 cần fallback hợp lệ
   - một regression sample MP4 hoặc MKV đang phát tốt từ phase trước
   - một sample hỏng hoặc ngoài phạm vi để xác nhận fail ổn định

## Validation Commands

Từ thư mục `CxPlayer/`:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.CxPlayerManagerTest
.\gradlew.bat assembleDebug
.\gradlew.bat compileDebugAndroidTestKotlin
```

Ghi chú:

- `assembleDebug` là kiểm tra hữu ích cho task này vì nó xác nhận cả Gradle dependency mới lẫn Kotlin compile của wiring player.
- `compileDebugAndroidTestKotlin` là sanity-check tối thiểu nếu có chạm vào smoke test playback; không bắt buộc sửa androidTest trong task 3.1.
- Nếu cần chạy instrumentation trên thiết bị thật, repo note hiện tại cho biết có thể gặp `INSTALL_FAILED_ABORTED` nếu chưa chấp nhận prompt cài test app trên thiết bị.

## Manual Verification

1. Mở file MKV có DTS hoặc AC3; xác nhận video phát với cả hình và tiếng trong cùng ứng dụng.
2. Mở file H.265 thuộc sample mục tiêu; xác nhận file vào trạng thái phát ổn định mà không yêu cầu user setting mới.
3. Mở regression sample MP4 hoặc MKV từng phát tốt; xác nhận không có bước chọn decoder và playback controls vẫn hoạt động như cũ.
4. Tua tiến, tua lùi, tạm dừng và phát tiếp trên sample pass; xác nhận wiring mới không làm hỏng playback controls cơ bản.
5. Mở sample hỏng hoặc ngoài phạm vi; xác nhận ứng dụng không crash, không treo loading vô thời hạn và vẫn cho phép quay lại hoặc mở file khác.
6. Mở một file unsupported như `.txt` hoặc URI có mime type không phải video; xác nhận màn hình phát tự kết thúc sạch, sau đó mở lại sample MP4 hoặc MKV hợp lệ và phiên phát mới vẫn hoạt động.

## Implementation Note

- `CxRenderersFactory` hiện đã được nối vào `ExoPlayer.Builder` và cấu hình `EXTENSION_RENDERER_MODE_PREFER` cùng decoder fallback.
- Tài liệu chính thức của Media3 xác nhận `decoder_ffmpeg` không được publish qua Google Maven hoặc Maven Central; muốn FFmpeg thực sự được dùng ở runtime thì repo phải cung cấp một FFmpeg extension module local đã build sẵn trên classpath của app.
- Repo hiện có dấu vết native FFmpeg dưới `video_player_module/`, nhưng chưa có module Android tương thích Media3 để `:app` phụ thuộc trực tiếp. Vì vậy validation compile và unit test hiện khóa được playback policy và regression behavior, còn manual codec matrix chỉ pass đầy đủ sau khi FFmpeg extension local được tích hợp thật.

## Out of Scope For This Feature

- Chọn track audio hoặc subtitle
- Tự động phát hiện subtitle ngoài hoặc embedded subtitle selection
- Playlist, next hoặc previous, shuffle
- UI cho decoder setting hoặc diagnostic chooser
