# Workflow: AI Subtitle Reconnect Fix

## Mục tiêu

Sửa lỗi AI dịch subtitle realtime bị kẹt ở trạng thái `Đang kết nối lại...`.

## Root cause

1. `SonioxClient` gửi config `audio_format = "raw"` thay vì `pcm_s16le`, khiến Soniox trả `error_code=400` với message `Invalid audio data format: raw`.
2. Retry counter bị reset ngay trong `onOpen()`, nên mỗi lần WebSocket vừa mở là số lần reconnect quay về `0`, dẫn tới vòng reconnect gần như vô hạn.

## File đã sửa

- `CxPlayer/app/src/main/java/com/cxplayer/subtitle/SonioxClient.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`

## Cách sửa

- Đổi `audio_format` sang `pcm_s16le` để khớp contract Soniox và pipeline PCM hiện tại.
- Thêm cờ `hasValidatedSession`:
  - reset về `false` khi mở phiên mới hoặc disconnect
  - chỉ reset `reconnectAttempts` sau khi nhận được response hợp lệ đầu tiên từ server
- Giữ logic reconnect hiện có, nhưng chặn việc reset counter quá sớm.

## Kiểm tra thủ công

1. Chạy build:
   - `rtk pwsh -NoProfile -Command "Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'; .\gradlew.bat :app:compileDebugKotlin --console=plain --no-daemon"`
2. Mở AI subtitle realtime trên thiết bị.
3. Xác nhận:
   - không còn log `Invalid audio data format: raw`
   - không còn lặp vô hạn `Đang kết nối lại...`
   - nếu Soniox thực sự lỗi nhiều lần liên tiếp, UI phải chuyển sang trạng thái thất bại thay vì reconnect mãi

## Ghi chú

- Không cần migrate database.
- Worktree đang bẩn sẵn ở một số file khác; workflow này chỉ bao phủ fix reconnect/audio format của AI subtitle.
