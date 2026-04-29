# Data Model: Playback Session Manager

## Overview

Feature này không thêm persistence layer, nhưng nó tạo một mô hình runtime rõ ràng cho request phát, phiên phát đang hoạt động và snapshot cần cho restore vòng đời.

## Entities

### PlayableSource

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `uriValue` | String | Yes | URI chuẩn hóa được chuyển cho player |
| `scheme` | Enum (`http`, `https`, `content`, `file`) | Yes | Scheme đã được xác thực là nằm trong phạm vi hỗ trợ |
| `mimeType` | String? | No | MIME type gốc nếu caller cung cấp |
| `displayLabel` | String? | No | Nhãn thân thiện để hiển thị hoặc log |

**Validation rules**

- Chỉ giữ source có scheme/định dạng được hỗ trợ và truy cập được.
- Một `PlaybackRequest` hợp lệ phải chứa ít nhất một `PlayableSource`.

### PlaybackRequest

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `sources` | List<PlayableSource> | Yes | Danh sách nguồn phát theo đúng thứ tự caller cung cấp |
| `requestedStartIndex` | Int | Yes | Chỉ số caller mong muốn trước khi normalize |
| `normalizedStartIndex` | Int | Yes | Chỉ số sẽ được áp dụng thực tế sau normalize |
| `requestedStartPositionMs` | Long | Yes | Vị trí caller yêu cầu trước khi normalize |
| `normalizedStartPositionMs` | Long | Yes | Vị trí áp dụng thực tế; luôn là giá trị hợp lệ không âm |
| `origin` | Enum (`ExternalImplicit`, `InternalExplicit`) | Yes | Nguồn gốc request |
| `rawAction` | String? | No | Giá trị action gốc của intent nếu có |

**Validation rules**

- Reject request nếu `sources` rỗng sau bước lọc/chuẩn hóa.
- Clamp `normalizedStartIndex` về phần tử hợp lệ gần nhất nếu `requestedStartIndex` ngoài phạm vi.
- Reset `normalizedStartPositionMs` về `0` khi giá trị yêu cầu âm hoặc không áp dụng được cho media item đang chọn.

### PlaybackSession

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `playlist` | List<PlayableSource> | Yes | Playlist hiện hành của phiên phát |
| `currentIndex` | Int | Yes | Media item đang active |
| `currentPositionMs` | Long | Yes | Vị trí hiện tại của phiên phát |
| `playWhenReady` | Boolean | Yes | Ý định phát hay tạm dừng |
| `state` | Enum (`Idle`, `Initialized`, `Prepared`, `Playing`, `Paused`, `Ended`, `Error`, `Released`) | Yes | Trạng thái runtime của player |
| `attachedSurface` | Boolean | Yes | Đã gắn vào `PlayerView` hay chưa |

**Validation rules**

- Mỗi `PlayerActivity` chỉ sở hữu tối đa một `PlaybackSession` active.
- `Released` là trạng thái terminal; muốn phát lại phải tạo session mới từ request hoặc snapshot.

### PlaybackSnapshot

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `currentIndex` | Int | Yes | Mục đang xem khi snapshot được tạo |
| `currentPositionMs` | Long | Yes | Vị trí phát đã biết gần nhất |
| `playWhenReady` | Boolean | Yes | Cần auto-play hay giữ paused khi restore |

**Validation rules**

- Snapshot chỉ hợp lệ khi `currentIndex` tham chiếu được vào playlist hiện hành.
- `currentPositionMs` phải là giá trị không âm; nếu không áp dụng được khi restore thì manager phải rơi về `0`.

## Relationships

- Một `PlaybackRequest` chứa từ `1..n` `PlayableSource`.
- Một `PlaybackRequest` tạo ra tối đa một `PlaybackSession` cho một `PlayerActivity`.
- Một `PlaybackSession` có thể phát sinh nhiều `PlaybackSnapshot` trong vòng đời của nó.
- Một `PlaybackSnapshot` chỉ có ý nghĩa khi gắn với đúng playlist/request đã tạo session.

## State Transitions

### Request normalization

`Received` -> `Validated` -> `Normalized` -> (`Accepted` | `Rejected`)

- `Rejected`: không còn nguồn phát hợp lệ.
- `Accepted`: ít nhất một nguồn hợp lệ, index/position đã được đưa về giá trị dùng được.

### Session lifecycle

`Idle` -> `Initialized` -> `Prepared` -> (`Playing` | `Paused`) -> (`Ended` | `Error` | `Released`)

- `Initialized`: `ExoPlayer` đã được tạo và cấu hình seek increments/wake mode.
- `Prepared`: playlist đã được set và gọi `prepare()`.
- `Playing` / `Paused`: phản ánh `playWhenReady` + state hiện hành.
- `Released`: tài nguyên đã được giải phóng và không còn surface gắn kèm.