# Data Model: Playback Gesture Controller

## Overview

Feature này không thêm persistence. Mô hình dữ liệu tập trung vào runtime gesture state và threshold profile để `GestureController` phân loại chính xác thao tác trên `PlayerView` và phát đúng callback theo mapping định lượng của spec.

## Entities

### GestureSession

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `startX` | Float | Yes | Tọa độ X tại thời điểm bắt đầu chạm |
| `startY` | Float | Yes | Tọa độ Y tại thời điểm bắt đầu chạm |
| `pointerCount` | Int | Yes | Số điểm chạm hiện có trong session |
| `lockedZone` | GestureZone | Yes | Vùng điều khiển được khóa từ lúc bắt đầu session |
| `lockedAxis` | GestureAxis? | No | Trục đang được nhận diện sau khi vượt ngưỡng |
| `activeOutcome` | GestureOutcomeType? | No | Outcome đang có hiệu lực trong session |
| `longPressActive` | Boolean | Yes | Có đang ở trạng thái tua nhanh tạm thời hay không |
| `pinchInProgress` | Boolean | Yes | Session có đang được ưu tiên cho pinch/zoom hay không |

**Validation rules**

- `lockedZone` phải được xác định ngay khi session bắt đầu và không đổi trong suốt session.
- `activeOutcome` chỉ được chứa tối đa một loại outcome đang hoạt động tại một thời điểm.
- Khi `pinchInProgress == true`, `lockedAxis` và outcome một ngón không được phát sinh thêm từ cùng session.

### GestureThresholdProfile

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `directionLockDistancePx` | Float | Yes | Ngưỡng tối thiểu để khóa hướng vuốt |
| `volumeStepDistancePx` | Float | Yes | Khoảng cách pixel tương ứng một bước âm lượng |
| `volumeStepAmount` | Float | Yes | Giá trị delta volume phát ra cho mỗi bước |
| `brightnessStepDistancePx` | Float | Yes | Khoảng cách pixel tương ứng một bước độ sáng |
| `brightnessStepAmount` | Float | Yes | Giá trị delta brightness phát ra cho mỗi bước |
| `seekMsPerPixel` | Long | Yes | Tỷ lệ chuyển đổi giữa vuốt ngang và delta seek |
| `doubleTapSeekMs` | Long | Yes | Giá trị tua cố định cho double tap vùng trái/phải |
| `fastForwardSpeed` | Float | Yes | Tốc độ tua nhanh tạm thời khi long press |
| `minZoom` | Float | Yes | Mức zoom nhỏ nhất được chấp nhận |
| `maxZoom` | Float | Yes | Mức zoom lớn nhất được chấp nhận |

**Validation rules**

- Tất cả giá trị khoảng cách và thời gian phải dương.
- `minZoom` phải nhỏ hơn hoặc bằng `maxZoom`.
- `volumeStepAmount` phải bằng `1.0` và `brightnessStepAmount` phải bằng `0.05` cho feature hiện tại.
- `doubleTapSeekMs` phải bằng `10000`, `fastForwardSpeed` phải bằng `2.0`, `minZoom` phải bằng `1.0`, và `maxZoom` phải bằng `3.0` cho contract hiện hành.

**Default contract values for this feature**

| Property | Value | Source |
|----------|-------|--------|
| `volumeStepDistancePx` | `150` | FR-002 |
| `volumeStepAmount` | `1.0` | FR-002 |
| `brightnessStepDistancePx` | `150` | FR-003 |
| `brightnessStepAmount` | `0.05` | FR-003 |
| `seekMsPerPixel` | `100` | FR-004 |
| `doubleTapSeekMs` | `10000` | FR-006 |
| `fastForwardSpeed` | `2.0` | FR-007 |
| `minZoom` | `1.0` | FR-008 |
| `maxZoom` | `3.0` | FR-008 |

### GestureZone

| Value | Description |
|-------|-------------|
| `LeftHalf` | Nửa trái vùng phát cho vuốt dọc điều chỉnh độ sáng |
| `RightHalf` | Nửa phải vùng phát cho vuốt dọc điều chỉnh âm lượng |
| `LeftThird` | Một phần ba bên trái cho double tap tua lùi |
| `CenterThird` | Một phần ba giữa cho double tap play/pause |
| `RightThird` | Một phần ba bên phải cho double tap tua tiến |

**Validation rules**

- Việc suy ra `GestureZone` phải dựa trên kích thước hiện tại của `PlayerView` tại thời điểm chạm bắt đầu.
- Các third-zone cho double tap phải bao phủ toàn bộ bề ngang mà không chồng lấn nhau.

### GestureOutcome

| Variant | Payload | Description |
|---------|---------|-------------|
| `VolumeDelta` | `Float` | Delta âm lượng phát ra từ vuốt dọc bên phải |
| `BrightnessDelta` | `Float` | Delta độ sáng phát ra từ vuốt dọc bên trái |
| `SeekDelta` | `Long` | Delta tua tiến/lùi phát ra từ vuốt ngang hoặc double tap trái/phải |
| `TogglePlayPause` | None | Yêu cầu chuyển trạng thái phát/tạm dừng |
| `FastForwardStart` | `Float` | Bắt đầu tua nhanh tạm thời với tốc độ chỉ định |
| `FastForwardEnd` | None | Kết thúc trạng thái tua nhanh tạm thời |
| `ZoomFactor` | `Float` | Scale factor phát ra từ pinch |
| `Ignored` | None | Session không đủ điều kiện nhận diện và bị bỏ qua |

**Validation rules**

- `VolumeDelta`, `BrightnessDelta` và `SeekDelta` phải giữ đúng dấu theo hướng thao tác; với contract hiện tại, vuốt lên là delta dương cho volume/brightness và vuốt sang phải là delta dương cho seek.
- `FastForwardEnd` chỉ hợp lệ sau khi đã có `FastForwardStart` trong cùng session.
- `Ignored` được dùng cho thao tác không đủ ngưỡng hoặc bị hủy, không được phát kèm outcome khác.

## Relationships

- Một `GestureSession` tiêu thụ một `GestureThresholdProfile` để suy ra đúng một `GestureOutcome` đang hoạt động tại mỗi thời điểm.
- `GestureZone` được tính từ kích thước `PlayerView` và gắn với `GestureSession` ngay từ lúc bắt đầu.
- `GestureOutcome` được chuyển ra ngoài qua callback contract thay vì tự áp dụng side effect trong model.

## State Transitions

### Session lifecycle

`Idle` -> `TrackingSingleTouch` -> (`VerticalAdjusting` | `HorizontalSeeking` | `AwaitingTapResolution` | `LongPressActive` | `PinchZooming`) -> `Completed`

- `TrackingSingleTouch`: đã có `ACTION_DOWN`, zone được khóa nhưng axis có thể chưa chốt.
- `VerticalAdjusting`: session đã vượt ngưỡng và đang phát delta volume/brightness.
- `HorizontalSeeking`: session đã vượt ngưỡng ngang và đang phát delta seek.
- `AwaitingTapResolution`: detector đang phân giải single/double tap cho thao tác chạm ngắn.
- `LongPressActive`: đã phát `FastForwardStart` và chờ kết thúc để phát `FastForwardEnd`.
- `PinchZooming`: session ưu tiên `ScaleGestureDetector`, chặn outcome một ngón khác.

### Cancellation paths

`TrackingSingleTouch` -> `Cancelled`

- Xảy ra khi gesture không vượt ngưỡng rõ ràng, activity mất focus touch, hoặc multi-touch khiến detector chuyển hẳn sang nhánh pinch.
- `Cancelled` phải kết thúc session mà không để lại trạng thái tua nhanh bị kẹt.