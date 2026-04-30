# Data Model: Gesture Overlay UI

## Overview

Feature này không thêm persistence. Mô hình dữ liệu tập trung vào runtime overlay state được `PlayerActivity` dựng từ callback gesture và trạng thái playback hoặc device hiện hành, sau đó bind vào một overlay card duy nhất trên màn hình phát.

## Entities

### GestureOverlayState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `type` | OverlayType | Yes | Loại overlay đang hiển thị |
| `cueText` | String | Yes | Nhãn trực quan chính, ví dụ Volume, Brightness, Seek hoặc 2X |
| `valueText` | String | Yes | Giá trị hiển thị cho người dùng, ví dụ `75%`, `60%`, `+00:30` |
| `isVisible` | Boolean | Yes | Overlay hiện đang hiển thị hay không |
| `dismissDeadlineMs` | Long? | No | Mốc thời gian overlay sẽ tự ẩn nếu không có update mới |
| `isStickyWhileGestureActive` | Boolean | Yes | Overlay có phải giữ liên tục trong lúc gesture còn hoạt động hay không |

**Validation rules**

- Tại mọi thời điểm chỉ được có tối đa một `GestureOverlayState` với `isVisible = true`.
- `valueText` phải phản ánh giá trị đã chuẩn hóa cho người dùng, không hiển thị số ngoài biên thực tế.
- `dismissDeadlineMs` chỉ tồn tại khi overlay đang visible và không còn bị giữ bởi một gesture đang active.

### OverlayType

| Value | Description |
|-------|-------------|
| `Volume` | Feedback cho vuốt dọc nửa phải |
| `Brightness` | Feedback cho vuốt dọc nửa trái |
| `SeekDelta` | Feedback cho vuốt ngang với delta thời lượng có dấu |
| `FastForward` | Feedback cho long press giữ tốc độ 2x |

**Validation rules**

- Mỗi `OverlayType` phải map đúng một cue trực quan duy nhất trong contract UI.
- Các loại gesture ngoài bốn giá trị này không được tạo overlay trong feature hiện tại.

### OverlayDisplayValue

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `rawValue` | Float or Long or None | No | Giá trị nguồn sau khi side effect hoặc playback update được áp dụng |
| `formattedText` | String | Yes | Giá trị đã format để hiển thị trên overlay |
| `isClamped` | Boolean | Yes | Có đang ở biên tối đa hoặc tối thiểu hay không |

**Validation rules**

- `formattedText` của volume và brightness phải ở dạng phần trăm dễ đọc.
- `formattedText` của seek phải giữ dấu `+` hoặc `-` và dùng định dạng thời gian ngắn nhất vẫn rõ nghĩa.
- `formattedText` của fast-forward phải phản ánh đúng tốc độ tạm thời đã áp dụng, với feature hiện tại là `2X`.

### OverlayVisibilityWindow

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `showLatencyTargetMs` | Long | Yes | Ngưỡng tối đa từ lúc nhận gesture đến lúc overlay xuất hiện |
| `autoDismissDelayMs` | Long | Yes | Khoảng trễ tối đa trước khi overlay tự ẩn sau khi gesture kết thúc |
| `lastUpdatedAtMs` | Long | Yes | Lần cập nhật overlay gần nhất |

**Validation rules**

- `showLatencyTargetMs` phải nhỏ hơn hoặc bằng `200` cho feature hiện tại.
- `autoDismissDelayMs` phải nhỏ hơn hoặc bằng `1000` cho feature hiện tại.
- Mỗi lần update overlay mới phải reset cửa sổ tự ẩn hiện có.

## Relationships

- `GestureOverlayState` sử dụng một `OverlayType` để quyết định cue trực quan và cách format dữ liệu.
- `OverlayDisplayValue` là payload hiển thị của `GestureOverlayState` và được dựng từ kết quả runtime trong `PlayerActivity`.
- `OverlayVisibilityWindow` điều khiển thời điểm hiện hoặc ẩn của `GestureOverlayState`.

## State Transitions

### Overlay lifecycle

`Hidden` -> `VisibleActiveGesture` -> `VisiblePendingDismiss` -> `Hidden`

- `Hidden`: chưa có overlay nào trên màn hình.
- `VisibleActiveGesture`: overlay đang hiển thị và gesture tương ứng vẫn còn hiệu lực hoặc đang tiếp tục gửi update.
- `VisiblePendingDismiss`: gesture đã kết thúc nhưng overlay còn chờ khoảng trễ ngắn trước khi tự ẩn.

### Replacement path

`VisibleActiveGesture` -> `VisibleActiveGesture`

- Xảy ra khi cùng loại gesture tiếp tục cập nhật giá trị, hoặc khi một gesture hỗ trợ khác xuất hiện ngay trước khi overlay cũ kịp ẩn.
- Cùng một overlay card được tái sử dụng với nội dung mới thay vì dựng nhiều overlay chồng nhau.

### Cancellation path

`VisibleActiveGesture` -> `Hidden`

- Xảy ra khi activity bị destroy, playback session bị gián đoạn hoặc logic cleanup bắt buộc dọn UI ngay.
- Path này phải hủy luôn lịch tự ẩn đang chờ để không còn callback muộn tác động lên view đã bị giải phóng.