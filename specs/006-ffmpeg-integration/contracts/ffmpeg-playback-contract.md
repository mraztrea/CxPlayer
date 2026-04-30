# Playback Contract: FFmpeg Integration

## Purpose

Tài liệu này mô tả contract cấp feature giữa media input profile, chính sách decoder của player và outcome playback mà người dùng nhìn thấy sau khi tích hợp FFmpeg cho task 3.1.

## Surface

- Điểm vào chính: `CxPlayerManager`
- Điểm tạo player session: `ExoPlayerSessionFactory.create()`
- Điểm cấu hình decoder policy: `CxRenderersFactory`
- Kết quả hiển thị ra ngoài: file phát được trong cùng ứng dụng hoặc thất bại có kiểm soát

## Dependency Contract

| Concern | Contract |
|---------|----------|
| Media3 version alignment | Playback policy hiện bám Media3 `1.10.0`; nếu bổ sung FFmpeg extension local trong tương lai thì extension đó phải tương thích cùng phiên bản Media3 đang dùng |
| Module scope | Tích hợp thêm Android library module `CxPlayer/ffmpeg-extension` để bọc native FFmpeg có sẵn mà không đổi public API của `CxPlayer/app` |
| User-facing settings | Không tạo toggle UI mới để người dùng bật hoặc tắt FFmpeg |
| FFmpeg packaging | FFmpeg decoder không có sẵn qua Maven repo chuẩn của dự án; runtime FFmpeg hiện đi qua local module `:ffmpeg-extension` và reuse native libs từ `video_player_module/native_libs` |

## Renderer Selection Contract

| Condition | Expected Behavior |
|-----------|-------------------|
| File phát tốt bằng decoder path hiện có | Player session vẫn phát được mà không làm đổi user flow |
| File cần renderer extension để đạt outcome mong muốn | Session ưu tiên renderer extension theo decoder policy của feature |
| Decoder ưu tiên không dùng được nhưng có path thay thế hợp lệ | Session cho phép fallback theo policy thay vì kết thúc ngay bằng hard failure |
| File vẫn ngoài phạm vi sau mọi path trong policy | Session trả về outcome không phát được ổn định |

## Session Wiring Contract

1. `CxPlayerManager(context)` vẫn là entry point công khai để màn hình phát tạo session player.
2. `ExoPlayerSessionFactory.create()` phải tiếp tục giữ seek increments hiện có khi dựng `ExoPlayer`.
3. Wiring FFmpeg integration không được làm đổi contract của `PlaybackRequest`, `PlaybackSnapshot` hoặc `PlaybackStateSnapshot`.
4. Player session thành công vẫn phải hỗ trợ play, pause và seek như trước.

## User Outcome Contract

| Input Scenario | Expected Outcome |
|----------------|------------------|
| MKV có DTS hoặc AC3 nằm trong sample hỗ trợ | Người dùng nghe được âm thanh và xem được hình trong cùng app |
| H.265 hoặc H.264 cần đường phát thay thế hợp lệ | Người dùng bắt đầu xem mà không phải đổi app hoặc bật setting ẩn |
| Sample MP4 hoặc MKV vốn phát tốt từ phase trước | User flow mở file và điều khiển playback giữ nhất quán |
| File hỏng hoặc ngoài phạm vi | Ứng dụng không crash và trả về trạng thái thất bại có kiểm soát |

## Validation Mapping

| Validation | Contract Being Verified |
|------------|-------------------------|
| Unit test cho `CxPlayerManager` hoặc seam session factory | Wiring mới không làm đổi public playback contract và giữ increment hiện có |
| `assembleDebug` | Dependency FFmpeg mới và wiring Kotlin compile đúng trong module app |
| Manual playback sample codec pass | Outcome contract cho AC3, DTS, H.265 đạt được |
| Manual playback sample fail | Ứng dụng fail ổn định khi media ngoài phạm vi |

## Current Limitation

- Implementation hiện tại đã đưa local module `:ffmpeg-extension` lên app classpath để `DefaultRenderersFactory` có thể nạp `androidx.media3.decoder.ffmpeg.FfmpegAudioRenderer` thật.
- Điều chưa được chứng minh xong là manual codec matrix trên sample mục tiêu: compile pass và classpath wiring đã ổn, nhưng vẫn cần test runtime với media AC3, DTS, H.265 hoặc sample fallback thực tế để xác nhận bridge JNI hoạt động đúng với mọi codec mục tiêu.
