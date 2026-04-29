# Data Model: Player Launch Entry

## 1. PlaybackRequest

Đại diện cho yêu cầu mở player sau khi đã chuẩn hóa từ Android `Intent` hoặc explicit launch nội bộ.

| Field | Type | Required | Validation | Notes |
|-------|------|----------|------------|-------|
| `sources` | `List<MediaSourceRef>` | Có | Phải có ít nhất 1 phần tử playable | Danh sách media nguồn sau khi lọc rỗng/không hợp lệ |
| `startIndex` | `Int` | Có | `0 <= startIndex < sources.size` hoặc fallback về `0` nếu policy cho phép | Xác định item mở đầu tiên |
| `startPositionMs` | `Long` | Có | `>= 0`; nếu vượt quá độ dài media thì clamp ở bước playback | Mốc seek khởi đầu |
| `origin` | `LaunchOrigin` | Có | Một trong `ExternalImplicit`, `InternalExplicit` | Hữu ích cho logging/analytics sau này |
| `rawAction` | `String?` | Không | Chỉ nhận action đã biết hoặc `null` | Giúp trace nguồn intent |

## 2. MediaSourceRef

Đại diện cho một media source đã được parse nhưng chưa phát.

| Field | Type | Required | Validation | Notes |
|-------|------|----------|------------|-------|
| `uri` | `Uri` hoặc biểu diễn tương đương | Có | Không rỗng, scheme hợp lệ sau normalize | Có thể đến từ `http`, `https`, `content`, `file` |
| `scheme` | `MediaScheme` | Có | Phải thuộc tập hỗ trợ của task `1.2` | Dùng để nhánh hóa xử lý truy cập sau này |
| `mimeType` | `String?` | Không | Nếu có thì phải khớp họ video cho luồng implicit | Nguồn từ intent filter hoặc content resolver |
| `isPlayableCandidate` | `Boolean` | Có | `true` chỉ khi qua được kiểm tra đầu vào tối thiểu | Không đồng nghĩa với decode/play thành công |
| `displayLabel` | `String?` | Không | Tùy chọn | Dùng cho thông báo lỗi hoặc UI sau này |

## 3. LaunchOutcome

Kết quả cuối của bước xử lý launch trước khi vào playback thật.

| Field | Type | Required | Validation | Notes |
|-------|------|----------|------------|-------|
| `status` | `LaunchStatus` | Có | `Ready`, `FallbackSelected`, `Rejected` | Trạng thái chính |
| `selectedIndex` | `Int?` | Không | Chỉ có khi `Ready` hoặc `FallbackSelected` | Item được chọn để phát |
| `effectiveStartPositionMs` | `Long?` | Không | `>= 0` khi có | Có thể khác request ban đầu sau clamp/fallback |
| `message` | `String?` | Không | Có khi `Rejected` hoặc cần thông báo fallback | Phục vụ clear user feedback |

## 4. Enum đề xuất

### LaunchOrigin

- `ExternalImplicit`
- `InternalExplicit`

### MediaScheme

- `Http`
- `Https`
- `Content`
- `File`

### LaunchStatus

- `Ready`
- `FallbackSelected`
- `Rejected`

## 5. Relationships

- Một `PlaybackRequest` chứa một hoặc nhiều `MediaSourceRef`.
- Một `PlaybackRequest` sau validation sinh đúng một `LaunchOutcome`.
- `LaunchOutcome.selectedIndex` luôn tham chiếu tới một `MediaSourceRef` trong `PlaybackRequest.sources` khi status khác `Rejected`.

## 6. State Transition

```text
Intent Received
    ->
Intent Parsed
    ->
Request Normalized
    ->
Request Validated
    -> Ready
    -> FallbackSelected
    -> Rejected
```

## 7. Validation Rules

- Bỏ qua source null/rỗng hoặc URI parse thất bại ngay từ bước normalize.
- Nếu sau khi lọc không còn source hợp lệ nào, trả `Rejected`.
- Nếu `startIndex` không hợp lệ:
  - ưu tiên fallback về item đầu tiên nếu còn source hợp lệ
  - nếu policy implementation muốn fail-fast thì phải vẫn đảm bảo user-facing error rõ ràng
- Nếu source không còn quyền truy cập (`content://`) hoặc không tồn tại (`file://`), trả `Rejected` trước khi khởi tạo playback thật.
- Nếu scheme không thuộc tập hỗ trợ của task `1.2`, source đó không được coi là playable candidate.
