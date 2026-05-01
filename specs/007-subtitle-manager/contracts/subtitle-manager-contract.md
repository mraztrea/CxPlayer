# Subtitle Manager Contract

## Purpose

Tài liệu này mô tả contract cấp feature giữa playback screen hiện tại, runtime subtitle orchestration và outcome subtitle mà người dùng nhìn thấy khi triển khai Subtitle Manager.

## Surface

- Điểm vào UI: `PlayerActivity`
- Owner của playback session: `CxPlayerManager`
- Điểm orchestration subtitle mới: `SubtitleManager`
- Bề mặt render subtitle: `PlayerView.subtitleView`

## Dependency Contract

| Concern | Contract |
|---------|----------|
| External subtitle attachment | Subtitle ngoài được gắn bằng `MediaItem.SubtitleConfiguration`, không bằng overlay text tự dựng |
| Embedded subtitle selection | Text track nhúng được chọn hoặc tắt qua `TrackSelectionParameters` và override text track phù hợp |
| Styling | Mọi thay đổi style đi qua `PlayerView.subtitleView` và có hiệu lực trong session hiện tại |
| Playback continuity | Đổi subtitle không được làm mất quyền điều khiển play/pause/seek của playback screen |

## Detection Contract

| Condition | Expected Behavior |
|-----------|-------------------|
| Media source hiện tại là local file và có subtitle cùng tên cơ bản ở extension hỗ trợ | Auto-detect trả về một external subtitle candidate và có thể kích hoạt subtitle đó |
| Media source hiện tại không suy ra được sibling file theo contract của feature | Auto-detect trả về trạng thái unsupported, không crash và không chặn playback |
| Thư mục có subtitle khác tên cơ bản | Không tự động chọn; chỉ dùng khi user chủ động nạp |
| Subtitle file lỗi hoặc unsupported | Trả về lỗi có kiểm soát, video vẫn tiếp tục xem được |

## Selection Contract

1. Tại mọi thời điểm chỉ có một subtitle source active: embedded, external hoặc `Off`.
2. Chọn external subtitle mới phải giữ lại vị trí phát hiện tại và `playWhenReady`.
3. Chọn embedded subtitle không được yêu cầu reload toàn bộ activity.
4. Chọn `Off` phải làm biến mất subtitle text nhưng không làm dừng video.

## Style Contract

| Action | Expected Outcome |
|--------|------------------|
| Đổi font size | Subtitle đổi kích thước ngay trong phiên xem hiện tại |
| Bật hoặc tắt bold | Typeface subtitle cập nhật ngay |
| Đổi màu chữ | Foreground color đổi ngay trên subtitle đang render |
| Đổi edge mode hoặc edge color | Viền hoặc độ nổi đổi ngay để tăng readability |

## User Outcome Contract

| Input Scenario | Expected Outcome |
|----------------|------------------|
| `video.mp4` + `video.srt` cùng thư mục | Subtitle được auto-detect và hiển thị trong cùng phiên phát |
| User nạp `.ass` hoặc `.vtt` khi video đang phát | Subtitle ngoài hiển thị mà không buộc mở lại video |
| Video có embedded subtitle | User chọn đúng track cần xem hoặc tắt subtitle hoàn toàn |
| Subtitle lỗi hoặc unsupported | Ứng dụng không crash, video tiếp tục phát và user còn đường đổi lựa chọn |

## Validation Mapping

| Validation | Contract Being Verified |
|------------|-------------------------|
| `SubtitleManagerTest` | Auto-detect, source selection state, mime mapping và style mapping đúng |
| `CxPlayerManagerTest` | Playback session contract cũ không bị subtitle feature làm hỏng |
| `compileDebugAndroidTestKotlin` | Wiring UI và androidTest compile đúng sau khi chạm playback screen |
| Manual playback verification | Outcome contract cho `.srt`, `.ass`, `.vtt`, embedded subtitle và failure path đạt đúng spec |

## Current Limitation

- Track selector popup chuyên dụng chưa thuộc feature này, nên contract hiện tại chỉ chốt subtitle runtime behavior và UI seam tối thiểu để kích hoạt các thao tác subtitle.
- Auto-detect mặc định chưa bao phủ `content://` hoặc remote URI vì playback request hiện tại không có contract sibling-file ổn định cho các source đó.