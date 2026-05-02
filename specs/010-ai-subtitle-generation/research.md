# Research: AI Subtitle Generation

**Date**: 2026-05-01
**Feature**: AI Subtitle Generation (Soniox)

## R-001: ExoPlayer AudioProcessor cho trích xuất PCM

**Decision**: Sử dụng `BaseAudioProcessor` từ Media3 ExoPlayer, inject vào pipeline qua `CxRenderersFactory` (đã tồn tại).

**Rationale**:
- ExoPlayer hỗ trợ chuỗi AudioProcessor native, cho phép tap vào luồng audio mà không ảnh hưởng playback.
- `BaseAudioProcessor` cung cấp `queueInput(ByteBuffer)` — copy dữ liệu PCM ra ngoài rồi pass-through nguyên bản cho output.
- `CxRenderersFactory` đã tồn tại trong project, dễ dàng thêm processor mới.

**Alternatives considered**:
- MediaCodec callback: Phức tạp hơn, phải decode riêng, có thể gây sync issues.
- AudioRecord capture: Chỉ bắt microphone, không bắt được audio từ video playback.

## R-002: Audio Resampling từ source format → 16kHz mono PCM

**Decision**: Thực hiện resampling trực tiếp trong `CxAudioProcessor.queueInput()` bằng linear interpolation.

**Rationale**:
- Soniox yêu cầu `pcm_s16le`, 16000Hz, 1 channel.
- ExoPlayer cung cấp `inputFormat` (AudioFormat) với sample rate và channel count của source.
- Linear interpolation đủ chất lượng cho speech recognition (không cần chất lượng audiophile).
- Tránh thêm dependency bên ngoài cho resampling.

**Alternatives considered**:
- FFmpeg resampler: Đã có FFmpeg extension trong project, nhưng overhead quá lớn cho task đơn giản này.
- Oboe library: Chuyên cho low-latency audio, overkill cho trường hợp này.

## R-003: WebSocket Client cho Soniox STT

**Decision**: Sử dụng OkHttp WebSocket (đã có dependency `squareup.okhttp` trong project).

**Rationale**:
- OkHttp đã là dependency của project (dùng cho media3 datasource).
- OkHttp WebSocket API đơn giản, hỗ trợ binary frames (cần cho gửi PCM data).
- Endpoint: `wss://stt-rt.soniox.com/transcribe-websocket`.
- Config JSON gửi ngay sau khi connect, sau đó stream binary PCM.

**Alternatives considered**:
- Java-WebSocket library: Thêm dependency không cần thiết khi OkHttp đã có.
- Ktor WebSocket: Phù hợp hơn cho KMP, nhưng thêm dependency lớn không cần.

## R-004: Session Management (3-phút reset, keepalive)

**Decision**: Implement make-before-break pattern với coroutine timer.

**Rationale**:
- Soniox sessions có giới hạn thời gian, cần reset định kỳ.
- Make-before-break: mở WebSocket mới trước khi đóng cũ → không gián đoạn phụ đề.
- Context carryover: giữ 500 ký tự dịch gần nhất, truyền qua `context.text` trong config.
- Keepalive `{"type": "keepalive"}` mỗi 15s khi không có audio data.

**Alternatives considered**:
- Single long-lived connection: Không khả thi vì Soniox có session timeout.
- Server-side keepalive only: Không đủ, client cũng cần gửi keepalive.

## R-005: Subtitle Cache với Room DB

**Decision**: Sử dụng Room Database để cache phụ đề đã tạo.

**Rationale**:
- Room DB là chuẩn Android cho local persistence, tích hợp tốt với Kotlin Coroutines.
- Cache theo video URI + hash → tra cứu nhanh khi xem lại.
- Lưu danh sách SrtEntry (index, startMs, endMs, text) cho mỗi video.
- Tránh gọi API lại (~$0.12/giờ tiết kiệm đáng kể).

**Alternatives considered**:
- SharedPreferences: Không phù hợp cho structured data lớn.
- File-based cache (JSON): Thiếu query capability, khó quản lý invalidation.
- DataStore: Tốt cho key-value, nhưng không phù hợp cho list data phức tạp.

## R-006: Soniox API Response Parsing

**Decision**: Parse JSON response, phân loại token theo `translation_status` và `is_final`.

**Rationale**:
- Response chứa tokens với fields: `text`, `translation_status` ("original"/"translation"/"none"), `is_final` (boolean).
- Map sang `SubtitleEvent.Original`, `.Translation`, `.Provisional` tương ứng.
- Provisional (is_final=false) dùng để hiển thị real-time, sẽ bị thay thế bởi finalized text.

**Alternatives considered**:
- Chỉ dùng finalized text: Mất tính real-time, delay lớn hơn.
- Custom parser: Không cần, JSONObject/Gson đủ parse response đơn giản.
