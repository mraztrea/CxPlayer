# Data Model: FFmpeg Integration

## Overview

Feature này không thêm persistence. Mô hình dữ liệu tập trung vào policy runtime quyết định cách dựng playback session và cách diễn giải kết quả tương thích phát của một media file trong phạm vi task 3.1.

## Entities

### PlaybackDecoderPolicy

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `extensionRendererMode` | Enum | Yes | Chính sách ưu tiên renderer extension hay chỉ bật fallback |
| `decoderFallbackEnabled` | Boolean | Yes | Có cho phép fallback sang decoder khác khi decoder ưu tiên không dùng được hay không |
| `isAutomatic` | Boolean | Yes | Khẳng định người dùng không phải chọn tay decoder policy |
| `supportedAudioFamilies` | List<String> | Yes | Nhóm codec âm thanh mục tiêu của feature như AC3, EAC3, DTS, DTS-HD, TrueHD, FLAC |
| `supportedVideoFallbackFamilies` | List<String> | Yes | Nhóm codec video được phép dùng đường phát thay thế như H.264 và H.265 |

**Validation rules**

- `extensionRendererMode` phải phản ánh đúng yêu cầu phase 3 là ưu tiên renderer extension khi có mặt.
- `isAutomatic` luôn phải là `true` trong phạm vi feature này.
- Danh sách codec mục tiêu chỉ mô tả phạm vi compatibility; không tự động kéo theo UI chọn codec.

### MediaCompatibilityProfile

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `containerName` | String | Yes | Container cấp cao của file như MP4 hoặc MKV |
| `primaryVideoCodec` | String? | No | Codec video chính nếu đọc được |
| `primaryAudioCodec` | String? | No | Codec âm thanh chính nếu đọc được |
| `requiresExtensionDecoder` | Boolean | Yes | File này có cần renderer extension để đạt trạng thái phát mong muốn hay không |
| `hasPlayableTrackCombination` | Boolean | Yes | Có ít nhất một tổ hợp hình và tiếng khả dụng để bắt đầu xem hay không |

**Validation rules**

- `requiresExtensionDecoder = true` chỉ khi đường phát hiện có không đủ để đạt outcome mong muốn của feature.
- `hasPlayableTrackCombination = true` chỉ khi người dùng có thể nhận cả hình và tiếng hoặc ít nhất outcome được spec chấp nhận.

### PlaybackCompatibilityResult

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `status` | Enum | Yes | `PlayableDefault`, `PlayableWithExtension`, hoặc `Unsupported` |
| `selectedDecoderPath` | String | No | Mô tả đường decoder cuối cùng được dùng ở mức planning, ví dụ mặc định hoặc extension |
| `failureReason` | String? | No | Lý do cấp cao khi file vẫn không phát được |
| `userActionRequired` | Boolean | Yes | Người dùng có cần thao tác thêm để xem tiếp hay không |

**Validation rules**

- `userActionRequired` phải là `false` cho mọi trường hợp phát thành công.
- `failureReason` chỉ được có khi `status = Unsupported`.
- `PlayableWithExtension` phải phản ánh đúng giá trị người dùng mong đợi là xem được trong cùng ứng dụng, không phải đổi app.

### PlayerSessionConfiguration

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `renderersFactoryClass` | String | Yes | Loại renderers factory được dùng để dựng player session |
| `seekBackIncrementMs` | Long | Yes | Bước tua lùi hiện có của player |
| `seekForwardIncrementMs` | Long | Yes | Bước tua tiến hiện có của player |
| `preservesCurrentManagerApi` | Boolean | Yes | Khẳng định wiring mới không làm đổi public API của `CxPlayerManager` |

**Validation rules**

- `renderersFactoryClass` phải trỏ tới factory mới của feature này khi session thật được tạo.
- Các seek increment hiện có phải được giữ nguyên sau khi cắm FFmpeg integration.
- `preservesCurrentManagerApi` phải giữ `true` ở toàn bộ design của task 3.1.

## Relationships

- `PlaybackDecoderPolicy` định hình cách `PlayerSessionConfiguration` dựng `ExoPlayer`.
- `MediaCompatibilityProfile` được đánh giá dưới `PlaybackDecoderPolicy` để sinh ra `PlaybackCompatibilityResult`.
- `PlaybackCompatibilityResult` quyết định người dùng nhận được phiên phát thành công hay thất bại có kiểm soát mà không cần toggle UI mới.

## State Transitions

### Compatibility evaluation lifecycle

`Unclassified` -> `PlayableDefault` -> `Playing`

- Xảy ra khi file đã phát tốt bằng decoder path hiện có.

`Unclassified` -> `PlayableWithExtension` -> `Playing`

- Xảy ra khi media cần renderer extension để đạt outcome mong muốn nhưng vẫn phát được trong cùng session.

`Unclassified` -> `Unsupported`

- Xảy ra khi file vẫn không có tổ hợp phát khả dụng sau khi áp dụng policy của feature.

### Session wiring lifecycle

`SessionFactoryReady` -> `PlayerBuiltWithCustomRenderers` -> `MediaPrepared`

- Feature này chỉ chèn thêm policy vào lúc build player; mọi trạng thái playback phía sau tiếp tục đi theo vòng đời `CxPlayerManager` đang có.
