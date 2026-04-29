# Contract: Player Launch Intent

## Mục đích

Định nghĩa hợp đồng giao tiếp cho điểm vào `PlayerActivity` ở task `1.2`, bao gồm launch từ app ngoài và launch explicit từ nội bộ.

## 1. External Implicit Launch

### Supported action

- `android.intent.action.VIEW`

### Required category

- `android.intent.category.DEFAULT`

### Supported URI schemes

- `http`
- `https`
- `content`
- `file`

### Supported MIME types for manifest matching

- `video/mp4`
- `video/3gpp`
- `video/webm`
- `video/x-matroska`

### Required behavior

- Nếu intent match manifest filter, `PlayerActivity` phải được mở như điểm vào playback.
- Nếu URI hợp lệ nhưng không truy cập được ở runtime, activity phải trả lỗi rõ ràng và kết thúc flow sạch sẽ.
- Nếu intent không đại diện cho video nằm trong scope task `1.2`, activity không được đưa người dùng vào trạng thái playback hỏng.

## 2. Internal Explicit Launch

### Canonical request shape

```text
PlaybackRequest
- sources: one or more media sources
- startIndex: zero-based selected item
- startPositionMs: playback start position
```

### Canonical extra keys đề xuất

- `extra_media_uris`
- `extra_start_index`
- `extra_start_position_ms`

### Required behavior

- Explicit launch nội bộ phải được chuẩn hóa về cùng một `PlaybackRequest` như external launch.
- `startIndex` mặc định là `0` nếu caller không truyền.
- `startPositionMs` mặc định là `0` nếu caller không truyền.

## 3. Validation Contract

### Accepted request

Một request được coi là accepted khi:

- có ít nhất một source playable candidate
- `startIndex` trỏ tới source hợp lệ, hoặc fallback policy chọn được source hợp lệ khác
- `startPositionMs` không âm

### Rejected request

Một request phải bị reject khi:

- không có source nào playable
- source bị mất quyền truy cập hoặc parse thất bại
- dữ liệu vào không đủ để chọn media mở đầu

## 4. Launch Outcome Contract

### Ready

- Activity xác định được source mở đầu
- Có thể chuyển sang bước khởi tạo playback

### FallbackSelected

- Source/index yêu cầu ban đầu không dùng được
- Activity chọn source hợp lệ gần nhất theo policy đã chốt
- Người dùng có thể được báo nhẹ nếu cần

### Rejected

- Activity hiển thị lỗi rõ ràng
- Không khởi tạo playback
- Không crash

## 5. Security and Compatibility Notes

- Vì activity có intent filter, manifest implementation phải khai báo `android:exported` tường minh để tương thích Android 12+.
- Parser nên normalize scheme/host của URI về lowercase trước khi validate để tránh mismatch không cần thiết.
