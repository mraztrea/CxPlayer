# Data Model: Player Lifecycle Management

## Overview

Feature này không thêm persistence layer mới. Mô hình dữ liệu tập trung vào runtime contract giữa request đầu vào, session playback đang hoạt động, snapshot tạm thời dùng cho restore và các transition lifecycle quyết định khi nào khôi phục hoặc kết thúc phiên xem.

## Entities

### PlaybackRequestContext

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `sources` | List<MediaSourceRef> | Yes | Danh sách nguồn phát đã được parser chấp nhận cho phiên xem hiện tại |
| `startIndex` | Int | Yes | Vị trí item ban đầu mà request muốn phát |
| `startPositionMs` | Long | Yes | Thời điểm bắt đầu mong muốn trong item đã chọn |
| `origin` | Enum | Yes | Nguồn khởi phát request, ví dụ implicit external hoặc internal explicit |
| `rawAction` | String? | No | Action gốc của intent nếu có |

**Validation rules**

- `sources` không được rỗng khi request được đưa vào phiên playback.
- `startIndex` phải được clamp vào phạm vi hợp lệ của `sources` trước khi bắt đầu session.
- `startPositionMs` luôn không âm.

### PlaybackSessionState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `currentIndex` | Int | Yes | Item hiện đang được phát hoặc đang giữ vị trí tạm dừng |
| `currentPositionMs` | Long | Yes | Vị trí playback hiện tại đã được chuẩn hoá |
| `durationMs` | Long | Yes | Thời lượng hiện biết của item hiện tại |
| `playWhenReady` | Boolean | Yes | Ý định phát hay tạm dừng của phiên xem |
| `sessionState` | Enum | Yes | Trạng thái session hiện tại: idle, initialized, prepared, playing, paused, ended, error, released |
| `hasActiveSession` | Boolean | Yes | Có session player đang tồn tại trong manager hay không |

**Validation rules**

- `currentIndex` phải luôn nằm trong phạm vi playlist đang active.
- `currentPositionMs` và `durationMs` luôn không âm.
- Tại một thời điểm chỉ được có một `PlaybackSessionState` với `hasActiveSession = true` cho activity hiện tại.

### LifecycleSnapshot

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `currentIndex` | Int | Yes | Item cần khôi phục sau gián đoạn tạm thời hoặc recreate |
| `currentPositionMs` | Long | Yes | Vị trí đã lưu gần nhất để tiếp tục xem |
| `playWhenReady` | Boolean | Yes | Ý định phát/tạm dừng cần giữ lại sau restore |

**Validation rules**

- Snapshot chỉ được áp dụng khi `currentIndex` hợp lệ với request hiện hành.
- `currentPositionMs` luôn được chuẩn hoá về giá trị không âm trước khi lưu và khi restore.
- Snapshot của phiên cũ không được áp vào request mới nhận qua `onNewIntent()`.

### SessionTransition

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `event` | Enum | Yes | Sự kiện lifecycle hoặc navigation: InitialLaunch, TemporaryStop, Recreate, NewIntent, FinalExit |
| `captureSnapshot` | Boolean | Yes | Có cần chụp snapshot trước khi rời session hiện tại hay không |
| `reuseRequest` | Boolean | Yes | Có tiếp tục dùng `PlaybackRequestContext` hiện tại khi quay lại hay không |
| `releaseSession` | Boolean | Yes | Có phải release session player ở cuối transition hay không |
| `expectedOutcome` | Enum | Yes | ResumeSameContent, ReplaceWithNewContent, FullyReleased, ShowError |

**Validation rules**

- `TemporaryStop` và `Recreate` phải dẫn tới `reuseRequest = true` nếu request hiện hành còn hợp lệ.
- `NewIntent` phải dẫn tới `reuseRequest = false` đối với snapshot cũ.
- `FinalExit` luôn yêu cầu `releaseSession = true`.

## Relationships

- Một `PlaybackRequestContext` có thể tạo ra tối đa một `PlaybackSessionState` active trong một `PlayerActivity` instance.
- Một `PlaybackSessionState` có thể xuất ra một `LifecycleSnapshot` để dùng lại sau `TemporaryStop` hoặc `Recreate`.
- `SessionTransition` quyết định liệu `LifecycleSnapshot` sẽ được dùng để restore hay bị loại bỏ để nhường chỗ cho request mới.

## State Transitions

### Launch and restore

`PendingLaunch` -> `SessionAttached` -> `PreparedOrPlaying`

- `PendingLaunch`: activity đã parse request nhưng chưa bind session vào `PlayerView`.
- `SessionAttached`: manager đã attach view và load request.
- `PreparedOrPlaying`: session vào trạng thái prepared, playing hoặc paused tùy `playWhenReady`.

### Temporary interruption

`PreparedOrPlaying` -> `SnapshotCaptured` -> `ReleasedForStop` -> `RestoredFromSnapshot`

- Trước khi activity rời foreground, snapshot được capture từ session hiện tại.
- Session được release sạch để tránh audio/session leak.
- Khi activity trở lại với cùng request, snapshot được áp lại để tiếp tục cùng nội dung.

### Session replacement

`PreparedOrPlaying` -> `NewIntentReceived` -> `PreviousSnapshotInvalidated` -> `PreparedOrPlaying`

- Intent mới thay thế context phát hiện tại.
- Snapshot của request cũ không được dùng để resume nội dung mới.

### Final exit

`PreparedOrPlaying` -> `ReleasedForExit`

- Player bị release hoàn toàn.
- Không có session cũ nào được tự hồi sinh nếu chưa có request phát hợp lệ mới.