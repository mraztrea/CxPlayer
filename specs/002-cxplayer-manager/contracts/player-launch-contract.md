# Contract: Player Launch Request

## Purpose

Định nghĩa giao diện mà `PlayerActivity` chấp nhận từ caller nội bộ hoặc từ external `ACTION_VIEW`, đồng thời mô tả các rule normalize trước khi request được chuyển vào `CxPlayerManager`.

## Entry Points

### External implicit launch

- **Action**: `android.intent.action.VIEW`
- **Accepted URI schemes**: `http`, `https`, `content`, `file`
- **Accepted MIME types**: `video/mp4`, `video/3gpp`, `video/webm`, `video/x-matroska`

### Internal explicit launch

- **Target**: `com.cxplayer.ui.player.PlayerActivity`
- **Required input**: ít nhất một URI hợp lệ trong `data` hoặc `EXTRA_MEDIA_URIS`

## Extras

| Key | Type | Required | Behavior |
|-----|------|----------|----------|
| `extra_media_uris` | ArrayList<Uri> | No | Nếu có và không rỗng thì ưu tiên hơn `Intent.data` |
| `extra_start_index` | Int | No | Chỉ số media item mong muốn; sẽ được clamp về phần tử hợp lệ gần nhất nếu ngoài phạm vi |
| `extra_start_position_ms` | Long | No | Vị trí bắt đầu mong muốn; giá trị âm hoặc không áp dụng được sẽ bị reset về `0` |

## Normalization Rules

1. Lọc bỏ mọi source không truy cập được hoặc không thuộc scheme/định dạng hỗ trợ.
2. Nếu sau khi lọc không còn source hợp lệ, request bị reject và UI nhận lỗi có thể phục hồi.
3. Nếu vẫn còn source hợp lệ:
   - giữ nguyên thứ tự source caller cung cấp
   - clamp `startIndex` về phần tử hợp lệ gần nhất
   - reset `startPositionMs` không hợp lệ về `0`
4. Request đã normalize là đầu vào duy nhất được chuyển cho `CxPlayerManager`.

## Output Expectations

- **Accepted request**: `PlayerActivity` thiết lập playlist đã normalize và giao ownership runtime cho `CxPlayerManager`.
- **Rejected request**: `PlayerActivity` hiển thị thông báo lỗi ngắn và đóng màn hình thay vì khởi tạo player session rỗng.

## Compatibility Notes

- Contract này chỉ bao phủ Phase 1 và không cam kết background playback, DRM, subtitle, hoặc nhiều session song song.
- Caller nội bộ nên ưu tiên gửi `extra_media_uris` khi cần playlist nhiều item; caller external có thể chỉ cần `Intent.data`.