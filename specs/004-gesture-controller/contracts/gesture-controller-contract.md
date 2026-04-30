# Contract: Gesture Controller Surface Integration

## Purpose

Định nghĩa contract tích hợp giữa `PlayerView`, `GestureController` và `PlayerActivity` cho task 2.1, để implementation và test automation cùng dựa vào một mapping gesture thống nhất.

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
| Vertical swipe | Right 50% theo vị trí bắt đầu | `onVolumeChange(delta)` |
| Vertical swipe | Left 50% theo vị trí bắt đầu | `onBrightnessChange(delta)` |
| Horizontal swipe | Any | `onSeekDelta(deltaMs)` |
| Double tap | Center third | `onTogglePlayPause()` |
| Double tap | Left third | `onSeekDelta(-10000)` |
| Double tap | Right third | `onSeekDelta(10000)` |
| Long press | Any | `onFastForward(2f)` khi bắt đầu, `onFastForwardEnd()` khi kết thúc |
| Pinch | Any | `onZoom(scaleFactor)` |

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
  - vuốt phải không phát callback brightness
  - vuốt trái không phát callback volume
  - double tap giữa không phát seek delta
  - pinch không phát outcome một ngón từ cùng session
  - long press luôn có cặp start/end hợp lệ

## Compatibility Notes

- Contract này chỉ bao phủ task 2.1 và integration với surface hiện có.
- Gesture overlay, speed selector, aspect ratio và repeat mode thuộc feature riêng phía sau và không được ép phụ thuộc vào contract này ở giai đoạn planning.