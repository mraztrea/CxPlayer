# Contract: Gesture Controller Surface Integration

## Purpose

Định nghĩa contract tích hợp giữa `PlayerView`, `GestureController` và `PlayerActivity` cho feature gesture playback, để implementation và test automation cùng dựa vào cùng một mapping gesture định lượng của task 2.2.

## Touch Surface Ownership

- **Touch surface bắt buộc**: `playerView`
- **Owner của touch listener**: `GestureController`
- **Owner của side effect**: `PlayerActivity` hoặc lớp tích hợp phía ngoài nhận callback
- **Rule**: `PlayerView` tiếp tục là video surface chính; feature này không bật controller mặc định của Media3 để xử lý gesture.

## Required Callback Contract

`GestureController` phải hỗ trợ đầy đủ các callback sau theo đúng vai trò:

| Callback | Payload | Purpose |
|----------|---------|---------|
| `onVolumeChange` | `Float delta` | Yêu cầu tăng/giảm âm lượng dựa trên vuốt dọc nửa phải |
| `onBrightnessChange` | `Float delta` | Yêu cầu tăng/giảm độ sáng dựa trên vuốt dọc nửa trái |
| `onSeekDelta` | `Long deltaMs` | Yêu cầu tua dựa trên vuốt ngang hoặc double tap trái/phải |
| `onTogglePlayPause` | None | Yêu cầu chuyển đổi phát/tạm dừng từ double tap giữa |
| `onFastForward` | `Float speed` | Bắt đầu tua nhanh tạm thời khi long press |
| `onFastForwardEnd` | None | Kết thúc tua nhanh tạm thời khi gesture giữ kết thúc |
| `onZoom` | `Float scaleFactor` | Yêu cầu thay đổi mức zoom từ pinch |

## Gesture Mapping Contract

| Gesture | Zone | Expected outcome |
|---------|------|------------------|
| Vertical swipe | Right 50% theo vị trí bắt đầu | `onVolumeChange(delta)` với `1 bước` cho mỗi `150px`; vuốt lên là dương, vuốt xuống là âm |
| Vertical swipe | Left 50% theo vị trí bắt đầu | `onBrightnessChange(delta)` với `0.05` cho mỗi `150px`; vuốt lên là dương, vuốt xuống là âm |
| Horizontal swipe | Any | `onSeekDelta(deltaMs)` với `deltaMs = distancePx * 100`; vuốt phải là dương, vuốt trái là âm |
| Double tap | Center third | `onTogglePlayPause()` |
| Double tap | Left third | `onSeekDelta(-10000)` |
| Double tap | Right third | `onSeekDelta(10000)` |
| Long press | Any | `onFastForward(2f)` khi bắt đầu, `onFastForwardEnd()` khi kết thúc |
| Pinch | Any | `onZoom(scaleFactor)` với scale factor bị chặn trong dải `1f..3f` |

## Quantitative Mapping Invariants

- Một thao tác vuốt dọc `300px` ở nửa phải phải tương ứng hai bước volume cùng dấu theo chiều vuốt.
- Một thao tác vuốt dọc `150px` ở nửa trái phải tương ứng đúng `0.05` brightness delta cùng dấu theo chiều vuốt.
- Một thao tác vuốt ngang `250px` phải tương ứng `25000ms` seek delta cùng dấu theo hướng vuốt.
- Double tap hai bên luôn phát seek delta cố định `±10000ms`, không phụ thuộc khoảng cách giữa hai lần tap.
- Long press luôn bắt đầu với `2f` và luôn kết thúc bằng đúng một `onFastForwardEnd()` nếu phiên giữ đã thực sự bắt đầu.
- Pinch không được phát scale factor nhỏ hơn `1f` hoặc lớn hơn `3f` ra ngoài boundary của contract.

## Session Invariants

- Zone của gesture session được xác định từ tọa độ `ACTION_DOWN` và không đổi giữa chừng.
- Một session không được đồng thời phát hai outcome mâu thuẫn như zoom + seek hoặc brightness + volume.
- Khi pinch đã được nhận diện, controller phải ưu tiên `onZoom` và chặn callback một ngón từ cùng chuỗi chạm.
- Khi long press kết thúc hoặc bị hủy, `onFastForwardEnd()` phải được phát đúng một lần nếu trước đó đã có `onFastForward()`.
- Các thao tác không vượt ngưỡng nhận diện rõ ràng phải bị bỏ qua thay vì phát callback sai loại.

## Activity Integration Contract

- `PlayerActivity` chịu trách nhiệm tạo `GestureController` sau khi `playerView` đã inflate xong.
- `PlayerActivity` phải chuyển các callback playback vào APIs hiện có của activity hoặc `CxPlayerManager` thay vì cho controller truy cập thẳng manager.
- Điều chỉnh âm lượng và độ sáng là side effect ở mức activity/device nên không được nhúng trực tiếp vào `GestureController`.

## Testing Hooks

- `playerView` là hook UI ổn định để instrumentation dispatch touch input.
- Contract này yêu cầu có thể kiểm tra tối thiểu các điều kiện sau:
  - vuốt phải không phát callback brightness và tôn trọng tỷ lệ `1 bước / 150px`
  - vuốt trái không phát callback volume và tôn trọng tỷ lệ `0.05 / 150px`
  - vuốt ngang tôn trọng công thức `distance * 100ms`
  - double tap giữa không phát seek delta
  - pinch không phát outcome một ngón từ cùng session
  - long press luôn có cặp start/end hợp lệ ở mức `2f`

## Compatibility Notes

- Contract này chỉ bao phủ feature gesture playback và integration với surface hiện có.
- Gesture overlay, speed selector, aspect ratio và repeat mode thuộc feature riêng phía sau và không được ép phụ thuộc vào contract này ở giai đoạn planning.