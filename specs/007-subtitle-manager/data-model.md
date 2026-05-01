# Data Model: Subtitle Manager

## Overview

Feature này không thêm persistence. Mô hình dữ liệu tập trung vào runtime state cần để phát hiện, chọn và style subtitle cho một video đang mở trong cùng phiên player.

## Entities

### PlaybackSubtitleContext

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `mediaUri` | String | Yes | URI của media item đang phát |
| `mediaScheme` | Enum | Yes | Loại source hiện tại như `File`, `Content`, `Http`, `Https` |
| `displayLabel` | String? | No | Nhãn người dùng nhìn thấy của media hiện tại |
| `currentPositionMs` | Long | Yes | Vị trí phát cần được giữ khi reload subtitle ngoài |
| `playWhenReady` | Boolean | Yes | Trạng thái phát hiện hành cần preserve khi rebuild media item |

**Validation rules**

- `currentPositionMs` luôn phải không âm.
- `mediaScheme` quyết định có được chạy auto-detect hay không.
- `PlaybackSubtitleContext` chỉ đại diện cho media item đang active, không cho playlist nhiều item.

### SubtitleSourceDescriptor

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | String | Yes | Mã ổn định của nguồn subtitle trong phiên hiện tại |
| `kind` | Enum | Yes | `Embedded`, `External`, hoặc `Off` |
| `label` | String | Yes | Nhãn hiển thị cho người dùng, ví dụ tên file hoặc label track |
| `languageTag` | String? | No | Ngôn ngữ subtitle nếu có |
| `mimeType` | String? | No | MIME type của subtitle ngoài hoặc text track |
| `uriValue` | String? | No | URI của subtitle ngoài; null với embedded/off |
| `isAutoDetected` | Boolean | Yes | Có phải subtitle được tìm tự động hay không |
| `isCurrentlySelected` | Boolean | Yes | Có đang là nguồn subtitle hoạt động không |

**Validation rules**

- `kind = Off` luôn có `uriValue = null` và `isAutoDetected = false`.
- Chỉ một `SubtitleSourceDescriptor` có thể có `isCurrentlySelected = true` trong một thời điểm.
- `mimeType` phải có mặt với subtitle ngoài đã được nhận diện hợp lệ.

### SubtitleDetectionResult

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `status` | Enum | Yes | `Found`, `NotFound`, `UnsupportedSource`, hoặc `Unreadable` |
| `matchedUri` | String? | No | Subtitle path tìm thấy khi `status = Found` |
| `matchedMimeType` | String? | No | MIME type tương ứng của file subtitle được tìm thấy |
| `attemptedExtensions` | List<String> | Yes | Danh sách extension đã thử trong auto-detect |

**Validation rules**

- `matchedUri` và `matchedMimeType` chỉ có khi `status = Found`.
- `UnsupportedSource` xảy ra khi source hiện tại không thể suy ra sibling file theo contract của feature.

### SubtitleSelectionState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `activeSourceId` | String | Yes | ID của subtitle source đang hoạt động |
| `textTrackDisabled` | Boolean | Yes | Cờ biểu diễn trạng thái tắt toàn bộ subtitle |
| `requiresMediaItemReload` | Boolean | Yes | Có cần rebuild `MediaItem` cho thao tác hiện tại không |
| `preservedPositionMs` | Long | Yes | Vị trí phát sẽ được giữ qua thao tác đổi subtitle |
| `preservedPlayWhenReady` | Boolean | Yes | Trạng thái phát sẽ được giữ qua thao tác đổi subtitle |

**Validation rules**

- `textTrackDisabled = true` khi và chỉ khi `activeSourceId` trỏ tới nguồn `Off`.
- `requiresMediaItemReload = true` với subtitle ngoài mới hoặc khi cần gắn lại subtitle configuration.
- `preservedPositionMs` luôn phản ánh state trước khi thao tác subtitle làm đổi player internals.

### SubtitleStyleState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `fontSizeSp` | Int | Yes | Kích thước chữ subtitle theo sp |
| `isBold` | Boolean | Yes | Có dùng kiểu chữ đậm không |
| `foregroundColor` | String | Yes | Màu chữ đang áp dụng |
| `edgeMode` | Enum | Yes | Kiểu viền hoặc outline đang dùng |
| `edgeColor` | String | Yes | Màu của viền/độ nổi |

**Validation rules**

- `fontSizeSp` phải nằm trong dải đọc được do feature định nghĩa.
- `foregroundColor` và `edgeColor` phải được chuyển được sang `CaptionStyleCompat`.
- Style chỉ cần tồn tại trong phiên hiện tại; không bắt buộc sync qua restart app.

## Relationships

- `PlaybackSubtitleContext` là đầu vào cho `SubtitleDetectionResult` và `SubtitleSelectionState`.
- `SubtitleSourceDescriptor` là danh mục lựa chọn mà `SubtitleSelectionState` tham chiếu bằng `activeSourceId`.
- `SubtitleStyleState` độc lập với nguồn subtitle nhưng chỉ có hiệu lực khi `PlayerView.subtitleView` đang render text cues.

## State Transitions

### External subtitle detection lifecycle

`Idle` -> `Found`

- Source hiện tại là local file và có subtitle cùng tên cơ bản trong một extension hỗ trợ.

`Idle` -> `NotFound`

- Source hợp lệ cho auto-detect nhưng không có file subtitle phù hợp.

`Idle` -> `UnsupportedSource`

- Source là `content://`, `http://`, `https://` hoặc URI khác không có contract sibling file trong feature này.

### Subtitle selection lifecycle

`Off` -> `EmbeddedSelected`

- Người dùng bật một embedded track qua track selection parameters.

`Off` -> `ExternalSelected`

- Auto-detect hoặc thao tác chọn file gắn một subtitle ngoài vào media item đang phát.

`EmbeddedSelected` -> `ExternalSelected`

- External subtitle mới thay thế text track nhúng đang hoạt động; chỉ một nguồn được giữ active.

`AnySelected` -> `Off`

- User tắt subtitle; text track bị disable và overlay chữ biến mất nhưng playback session vẫn tiếp tục.

### Style application lifecycle

`DefaultStyle` -> `CustomStyleApplied`

- User đổi ít nhất một thuộc tính style và `PlayerView.subtitleView` áp dụng ngay trong session hiện tại.

`CustomStyleApplied` -> `DefaultStyle`

- User hoặc feature reset về style mặc định của phiên phát.