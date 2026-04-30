# Research: FFmpeg Integration

## Decision 1: Khai báo FFmpeg decoder bằng version catalog hiện có, không hardcode phiên bản mới trong module build file

- **Decision**: Thêm alias cho `androidx.media3:media3-decoder-ffmpeg` vào `CxPlayer/gradle/libs.versions.toml` và dùng alias đó từ `CxPlayer/app/build.gradle.kts`, bám cùng `version.ref = "media3"` đang dùng cho các Media3 module còn lại.
- **Rationale**: Repo đã chuẩn hóa dependency qua version catalog. Giữ FFmpeg decoder cùng phiên bản `media3 = 1.10.0` giúp tránh mismatch giữa core ExoPlayer và extension decoder, đồng thời giảm rủi ro lệch API khi nâng cấp sau này.
- **Alternatives considered**:
  - Hardcode chuỗi dependency trực tiếp trong `app/build.gradle.kts`: nhanh hơn lúc đầu nhưng phá pattern dependency management hiện tại của repo.
  - Tạo version riêng cho FFmpeg decoder: không cần thiết khi feature này chỉ dùng extension cùng họ Media3 đã có.

## Decision 2: Thêm `CxRenderersFactory` kế thừa `DefaultRenderersFactory` và bật `EXTENSION_RENDERER_MODE_PREFER`

- **Decision**: Tạo `CxRenderersFactory` dưới `com.cxplayer.player`, kế thừa `DefaultRenderersFactory`, cấu hình `setExtensionRendererMode(EXTENSION_RENDERER_MODE_PREFER)` và bật decoder fallback.
- **Rationale**: Tài liệu Media3 xác nhận FFmpeg module được kích hoạt thông qua `DefaultRenderersFactory` với `EXTENSION_RENDERER_MODE_ON` hoặc `PREFER`, trong đó `PREFER` phù hợp hơn với spec phase 3 vì ưu tiên codec mở rộng khi có mặt và giảm trường hợp file movie audio như DTS, EAC3 hoặc TrueHD vẫn rơi về đường mặc định không đáp ứng tốt. `setEnableDecoderFallback(true)` bổ sung khả năng fail over gọn hơn khi decoder ưu tiên không nhận stream cụ thể.
- **Alternatives considered**:
  - Dùng `EXTENSION_RENDERER_MODE_ON`: an toàn hơn cho hardware-first, nhưng không đáp ứng rõ ý định “prefer FFmpeg over MediaCodec” đã được ghi trong plan phase 3.
  - Tự override `buildAudioRenderers` để chèn renderer thủ công: linh hoạt nhưng quá mức cần thiết cho task 3.1 và tăng bề mặt bảo trì.

## Decision 3: Cắm renderers factory tại `ExoPlayerSessionFactory.create()` và giữ nguyên API `CxPlayerManager`

- **Decision**: Truyền `CxRenderersFactory(context)` vào `ExoPlayer.Builder(context)` ngay trong `ExoPlayerSessionFactory.create()`, giữ nguyên constructor công khai `CxPlayerManager(context)` và seam test `PlayerSessionFactory` hiện có.
- **Rationale**: Code hiện tại chỉ có một nơi dựng `ExoPlayer`, nên đây là điểm tích hợp rẻ nhất và dễ kiểm soát nhất. Giữ nguyên public API tránh ripple sang `PlayerActivity`, parser intent và các test hiện tại không liên quan đến decoder policy.
- **Alternatives considered**:
  - Cho `CxPlayerManager` nhận thêm tham số cấu hình decoder từ ngoài: tăng độ linh hoạt không cần thiết cho task đầu tiên của phase 3.
  - Đưa renderers factory xuống `PlayerActivity`: sai abstraction boundary vì UI không nên biết chi tiết decoder selection.

## Decision 4: Giữ scope validation ở mức session wiring và sample playback, chưa ép instrumentation tự động cho codec chuyên biệt

- **Decision**: Validation chính gồm unit tests quanh playback session wiring và manual verification bằng sample media thật cho AC3, DTS, H.265, cùng regression sample đang phát tốt. Android instrumentation chỉ đóng vai trò sanity-check compile hoặc smoke test nếu playback screen bị ảnh hưởng gián tiếp.
- **Rationale**: Codec-specific playback phụ thuộc sample media và decoder availability trên thiết bị thực, nên test tự động hoàn toàn trong repo hiện tại chưa phải đường đi ít rủi ro nhất. Unit test vẫn đủ để khóa regression ở mức player builder policy và contract của `CxPlayerManager`.
- **Alternatives considered**:
  - Viết instrumentation phát sample codec thật ngay lập tức: hấp dẫn về độ bao phủ nhưng đòi hỏi asset test lớn, thiết bị phù hợp và thêm nhiều hạ tầng ngoài scope của task 3.1.
  - Chỉ kiểm thử thủ công: không đủ để khóa regression ở seam player builder sau các phase tiếp theo.

## Decision 5: Mô hình hóa feature như một playback compatibility policy, không như user-facing toggle

- **Decision**: Data model và contract của feature được mô tả ở mức `PlaybackDecoderPolicy`, `MediaCompatibilityProfile` và `PlaybackCompatibilityResult`, thay vì thêm một setting mới cho người dùng bật hoặc tắt FFmpeg.
- **Rationale**: Spec nhấn mạnh người dùng không cần biết tên codec hay chọn tay chế độ giải mã. Vì vậy thiết kế tốt nhất là policy nội bộ, chạy tự động và chỉ biểu hiện ra ngoài bằng kết quả phát thành công hoặc thất bại có kiểm soát.
- **Alternatives considered**:
  - Thêm nút bật hoặc tắt FFmpeg trong UI: trái với yêu cầu trải nghiệm liền mạch và làm tăng support burden.
  - Thêm cờ cấu hình debug-only trong task này: có thể hữu ích cho dev nhưng không phải điều kiện để giao feature lõi.
