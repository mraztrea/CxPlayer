# Data Model: Playback Screen Layout

## Overview

Feature này không tạo persistence layer mới. Mô hình dữ liệu ở đây là runtime UI model cho player chrome, timeline và profile hiển thị để implementation giữ bố cục ổn định qua portrait/landscape và khi metadata chưa sẵn sàng.

## Entities

### PlayerChromeState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `titleText` | String | Yes | Nhãn nội dung đang phát hoặc fallback title |
| `backEnabled` | Boolean | Yes | Cho biết vùng điều hướng quay lại có thể thao tác |
| `overflowEnabled` | Boolean | Yes | Cho biết điểm vào hành động phụ đang hiển thị/khả dụng |
| `controlsVisible` | Boolean | Yes | Có đang hiển thị chrome hay không |
| `immersiveModeActive` | Boolean | Yes | Màn hình có đang ở fullscreen immersive hay không |

**Validation rules**

- `titleText` không được rỗng hoàn toàn khi chrome đang hiển thị; nếu metadata thiếu phải dùng fallback text ngắn, trung tính.
- `backEnabled` phải luôn là `true` khi `PlayerActivity` còn active.

### PlaybackTimelineState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `currentPositionText` | String | Yes | Chuỗi thời gian hiện tại hiển thị cho người dùng |
| `durationText` | String | Yes | Chuỗi thời lượng tổng hoặc placeholder ổn định |
| `seekEnabled` | Boolean | Yes | Có cho phép tương tác với thanh tiến trình hay không |
| `positionMs` | Long | Yes | Giá trị thời gian hiện tại dùng cho binding |
| `durationMs` | Long | Yes | Giá trị thời lượng tổng; có thể là `0` khi chưa sẵn sàng |

**Validation rules**

- `positionMs` và `durationMs` luôn không âm.
- Khi `durationMs == 0`, timeline vẫn phải render ổn định và không làm nhảy vị trí các control còn lại.

### TransportControlsState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `playPauseState` | Enum (`Play`, `Pause`) | Yes | Trạng thái biểu tượng/hành vi của nút chính |
| `seekBackEnabled` | Boolean | Yes | Cho biết nút tua lùi có khả dụng |
| `seekForwardEnabled` | Boolean | Yes | Cho biết nút tua tiến có khả dụng |
| `volumeActionVisible` | Boolean | Yes | Có hiển thị điểm vào điều chỉnh âm thanh |
| `settingsActionVisible` | Boolean | Yes | Có hiển thị điểm vào cài đặt |

**Validation rules**

- Năm hành động chính phải luôn giữ thứ tự trái sang phải cố định: seek back, play/pause, seek forward, volume, settings.
- `playPauseState` là control ưu tiên cao nhất trong cụm transport và không được bị đẩy khỏi viewport.

### LayoutViewportProfile

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `orientation` | Enum (`Portrait`, `Landscape`) | Yes | Hướng hiển thị hiện tại của activity |
| `topInsetPx` | Int | Yes | Khoảng an toàn do system bars ở phía trên |
| `bottomInsetPx` | Int | Yes | Khoảng an toàn do system bars ở phía dưới |
| `availableHeightPx` | Int | Yes | Chiều cao còn lại cho layout sau khi tính hệ điều hành |
| `controlsNeedCompactSpacing` | Boolean | Yes | Có cần spacing chặt hơn để giữ đủ control trong viewport hay không |

**Validation rules**

- `topInsetPx`, `bottomInsetPx` và `availableHeightPx` luôn không âm.
- `controlsNeedCompactSpacing` chỉ được bật khi chiều cao khả dụng không đủ cho spacing mặc định, nhưng không được làm thay đổi thứ tự control.

## Relationships

- Một `PlayerChromeState` bao bọc một `PlaybackTimelineState` và một `TransportControlsState` để tạo thành chrome hoàn chỉnh của màn hình player.
- Một `LayoutViewportProfile` chi phối cách `PlayerChromeState` được render nhưng không thay đổi thứ tự logic của control.
- `PlaybackTimelineState` và `TransportControlsState` cùng tiêu thụ playback state hiện có từ `PlayerActivity`/`CxPlayerManager` mà không sở hữu player trực tiếp.

## State Transitions

### Metadata and chrome readiness

`MetadataPending` -> `MetadataResolved`

- `MetadataPending`: title và duration chưa đầy đủ, UI dùng fallback text/placeholder.
- `MetadataResolved`: title và timeline bind được dữ liệu thật, nhưng không dịch chuyển vị trí nhóm control.

### Orientation reflow

`PortraitLayout` <-> `LandscapeLayout`

- Chuyển đổi giữa hai trạng thái phải giữ nguyên vùng video fullscreen và không làm biến mất top region hoặc bottom region.

### Chrome visibility

`Hidden` <-> `Visible`

- Khi `Visible`, top region và bottom region phải nằm trong safe area từ `LayoutViewportProfile`.
- Khi `Hidden`, video giữ toàn bộ không gian nhìn thấy; contract bố cục vẫn giữ id và hierarchy ổn định cho lần hiện tiếp theo.