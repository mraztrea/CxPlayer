# Data Model: Track Selector UI

## Overview

Feature này không thêm persistence. Mô hình dữ liệu tập trung vào runtime state cần để dựng popup selector, biểu diễn trạng thái audio/subtitle hiện tại và gửi yêu cầu đổi track cho phiên phát đang active.

## Entities

### AudioTrackOption

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | String | Yes | Mã ổn định của audio track trong phiên hiện tại |
| `groupIndex` | Int | Yes | Vị trí audio group trong `player.currentTracks.groups` |
| `trackIndex` | Int | Yes | Vị trí track bên trong audio group |
| `label` | String | Yes | Nhãn hiển thị cho user, ví dụ ngôn ngữ hoặc kiểu audio |
| `languageTag` | String? | No | Mã ngôn ngữ nếu Media3 format cung cấp |
| `isSelected` | Boolean | Yes | Có đang là audio track active không |
| `isSelectable` | Boolean | Yes | Track có thể chọn được ở thời điểm hiện tại không |

**Validation rules**

- `groupIndex` và `trackIndex` luôn không âm.
- Trong một lần snapshot chỉ có tối đa một `AudioTrackOption` có `isSelected = true`.
- `label` phải rơi về một fallback dễ hiểu nếu metadata gốc trống hoặc lặp.

### SubtitleTrackOption

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | String | Yes | Mã subtitle source ổn định dùng để gọi lại `SubtitleManager` |
| `kind` | Enum | Yes | `Off`, `Embedded`, hoặc `External` |
| `label` | String | Yes | Nhãn hiển thị cho user |
| `languageTag` | String? | No | Ngôn ngữ subtitle nếu có |
| `isAutoDetected` | Boolean | Yes | Có phải subtitle ngoài tự dò được hay không |
| `isSelected` | Boolean | Yes | Có đang là subtitle active không |

**Validation rules**

- Luôn tồn tại đúng một lựa chọn `Off` trong section subtitle.
- `kind = Off` luôn có `languageTag = null` và `isAutoDetected = false`.
- Trong một lần snapshot chỉ có tối đa một `SubtitleTrackOption` có `isSelected = true`.

### TrackSelectorSectionState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `sectionType` | Enum | Yes | `Audio` hoặc `Subtitle` |
| `title` | String | Yes | Tiêu đề section trong popup |
| `options` | List | Yes | Danh sách lựa chọn hiển thị trong section |
| `emptyStateLabel` | String? | No | Thông điệp hiển thị nếu section không có lựa chọn hữu ích |
| `selectedOptionId` | String? | No | ID của lựa chọn đang active trong section |

**Validation rules**

- `options` có thể rỗng chỉ khi `emptyStateLabel` được cung cấp.
- `selectedOptionId` phải khớp một option hiện có nếu section có lựa chọn active.
- Section subtitle phải vẫn hiển thị được trạng thái `Off` ngay cả khi không có embedded/external subtitle khác.

### TrackSelectorSnapshot

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `audioSection` | TrackSelectorSectionState | Yes | Section audio render tại thời điểm popup mở |
| `subtitleSection` | TrackSelectorSectionState | Yes | Section subtitle render tại thời điểm popup mở |
| `playbackItemLabel` | String? | No | Nhãn media item hiện tại nếu cần hiển thị ngữ cảnh |
| `canLoadExternalSubtitle` | Boolean | Yes | Có giữ entry point riêng để nạp phụ đề ngoài hay không |

**Validation rules**

- Snapshot phải được tạo mới từ player state mỗi lần popup mở.
- `audioSection` và `subtitleSection` luôn phản ánh cùng một media item active.
- Snapshot không được lưu qua lifecycle như nguồn sự thật lâu dài; nó chỉ là render state tạm thời.

### TrackSelectionRequest

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `sectionType` | Enum | Yes | Người dùng đang chọn audio hay subtitle |
| `optionId` | String | Yes | ID của lựa chọn người dùng chạm vào |
| `groupIndex` | Int? | No | Cần cho audio hoặc embedded subtitle khi selection đi qua override |
| `trackIndex` | Int? | No | Cần cho audio hoặc embedded subtitle khi selection đi qua override |

**Validation rules**

- Audio request luôn phải có `groupIndex` và `trackIndex` hợp lệ.
- Subtitle request với nguồn `External` hoặc `Off` không cần `groupIndex`/`trackIndex`.
- Một request thất bại không được làm mất snapshot playback hiện hành.

## Relationships

- `TrackSelectorSnapshot` bao gồm hai `TrackSelectorSectionState` và được dựng từ `AudioTrackOption` + `SubtitleTrackOption`.
- `TrackSelectionRequest` tham chiếu một option từ snapshot hiện tại và được route tới `TrackSelectorSessionController` hoặc `SubtitleManager`.
- `SubtitleTrackOption` dựa trên `SubtitleManager.availableSubtitleSources()`, trong khi `AudioTrackOption` dựa trên `player.currentTracks.groups`.

## State Transitions

### Popup lifecycle

`Closed` -> `Opening`

- User chạm `playerSettingsButton` khi playback screen có session active.

`Opening` -> `Visible`

- Snapshot audio/subtitle được dựng thành công và popup bám vào anchor view.

`Visible` -> `Closed`

- User chọn một option, tap ra ngoài popup hoặc playback screen bị recreate.

### Audio selection lifecycle

`AudioASelected` -> `AudioBSelected`

- User chọn một audio track khác; controller áp override mới và state active đổi tương ứng.

`AudioSelected` -> `AudioSelected`

- User chạm lại đúng audio track đang active; selector có thể đóng mà không đổi player state.

### Subtitle selection lifecycle

`SubtitleOff` -> `SubtitleSelected`

- User chọn embedded subtitle hoặc external subtitle đã có trong session.

`SubtitleSelected` -> `SubtitleOff`

- User chọn mục `Off`; text track bị disable nhưng audio selection giữ nguyên.

`SubtitleASelected` -> `SubtitleBSelected`

- User đổi giữa external subtitle và embedded subtitle hoặc giữa hai embedded tracks; chỉ một subtitle source còn active.