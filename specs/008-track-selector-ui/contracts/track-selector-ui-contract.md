# Track Selector UI Contract

## Purpose

Tài liệu này mô tả contract cấp feature giữa playback screen, popup selector audio/subtitle và playback stack Media3 khi triển khai Track Selector UI.

## Surface

- Điểm vào UI chính: `PlayerActivity.playerSettingsButton`
- Điểm vào giữ lại cho file picker phụ đề ngoài: `PlayerActivity.playerOverflowButton`
- Owner của playback session: `CxPlayerManager`
- Source of truth cho subtitle runtime state: `SubtitleManager`
- Source of truth cho audio runtime state: `TrackSelectorSessionController`
- Bề mặt UI mới: `TrackSelector` (`PopupWindow`)

## Popup Contract

| Condition | Expected Behavior |
|-----------|-------------------|
| User chạm `playerSettingsButton` khi có playback session active | Popup selector mở bám vào nút settings và hiển thị trạng thái track hiện tại |
| User tap ra ngoài popup hoặc activity bị recreate | Popup đóng an toàn, không giữ state stale trên màn hình |
| Popup mở khi một section không có lựa chọn hữu ích | Section đó hiển thị trạng thái empty rõ ràng, không tạo danh sách giả |

## Data Contract

| Concern | Contract |
|---------|----------|
| Audio options | Lấy từ `player.currentTracks.groups` với `group.type == C.TRACK_TYPE_AUDIO` |
| Subtitle options | Lấy từ `SubtitleManager.availableSubtitleSources()` để bao phủ `Off`, embedded và external subtitles đã nạp |
| Selected markers | Mỗi section chỉ có tối đa một option active tại một thời điểm |
| Labels | Nếu metadata track trống hoặc mơ hồ, hệ thống phải tạo fallback label dễ phân biệt |

## Selection Contract

1. Chọn audio track mới phải đi qua `TrackSelectionParameters`/`TrackSelectionOverride` và không được reset playback session.
2. Chọn subtitle option phải route về `SubtitleManager.selectSubtitleSource()` để giữ đúng contract subtitle hiện có.
3. Chọn `Off` trong section subtitle chỉ ảnh hưởng text tracks; audio track hiện tại không được đổi theo.
4. Nếu selection không áp dụng được, playback phải tiếp tục xem được và selector lần mở kế tiếp phải phản ánh trạng thái thực đang active.

## Entry Point Contract

| Entry Point | Expected Outcome |
|-------------|------------------|
| `playerSettingsButton` short tap | Mở track selector popup |
| `playerOverflowButton` short tap | Tiếp tục mở external subtitle picker hoặc entry point tương đương cho việc nạp phụ đề ngoài |
| Existing transport controls | Không thay đổi hành vi do feature này |

## User Outcome Contract

| Input Scenario | Expected Outcome |
|----------------|------------------|
| Video có nhiều audio track | User thấy và đổi được audio track đang active từ popup |
| Video có embedded subtitle | User chọn đúng subtitle cần xem hoặc tắt phụ đề từ cùng popup |
| Video có external subtitle đã auto-detect hoặc manual load | Selector hiển thị nguồn subtitle ngoài như một lựa chọn bình thường |
| Video chỉ có một audio track hoặc không có subtitle | Popup vẫn cho thấy trạng thái rõ ràng, không làm người dùng tưởng có thêm lựa chọn |

## Validation Mapping

| Validation | Contract Being Verified |
|------------|-------------------------|
| `TrackSelectorSessionControllerTest` | Audio option mapping, selected state và override routing đúng |
| `SubtitleManagerTest` | Selector không phá contract subtitle source hiện có |
| `PlayerActivityPlaybackTest` | Popup entry point, playback continuity và external subtitle picker entry point vẫn hoạt động |
| Manual playback verification | Audio/subtitle switching outcome khớp spec trên media samples thực |

## Current Limitation

- Popup selector chỉ quản lý track selection cho media item đang active; chưa bao phủ queue hoặc playlist.
- Selector không giải quyết subtitle styling UI; style feature tiếp tục tách riêng khỏi popup này.
- Contract này giả định audio/subtitle availability lấy được từ Media3 runtime state của session đang active; không tạo cache kéo dài sau khi popup đóng.