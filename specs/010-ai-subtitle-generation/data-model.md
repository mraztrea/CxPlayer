# Data Model: AI Subtitle Generation

**Date**: 2026-05-01

## Entities

### SubtitleEvent

Sự kiện phụ đề đơn lẻ được emit từ Soniox STT.

| Field | Type | Description |
|-------|------|-------------|
| type | enum(Original, Translation, Provisional) | Loại phụ đề |
| text | String | Nội dung phụ đề |
| lang | String? | Ngôn ngữ nguồn (chỉ có ở Original) |

**Sealed class**: `SubtitleEvent.Original`, `SubtitleEvent.Translation`, `SubtitleEvent.Provisional`

**Lifecycle**: Tạm thời, tồn tại trong SharedFlow, không persist.

---

### SubtitleDisplayMode

Chế độ hiển thị phụ đề do người dùng chọn.

| Value | Description |
|-------|-------------|
| ORIGINAL_ONLY | Chỉ hiển thị phụ đề ngôn ngữ gốc |
| TRANSLATION_ONLY | Chỉ hiển thị bản dịch |
| BOTH | Hiển thị cả phụ đề gốc và bản dịch song song |

**Default**: BOTH
**Lifecycle**: Lưu theo preference người dùng, áp dụng ngay khi thay đổi.

---

### SrtEntry

Một mục phụ đề trong file SRT, đã finalized.

| Field | Type | Description |
|-------|------|-------------|
| index | Int | Số thứ tự (1-based) |
| startMs | Long | Thời gian bắt đầu (ms từ đầu video) |
| endMs | Long | Thời gian kết thúc (ms từ đầu video) |
| text | String | Nội dung phụ đề (có thể gồm cả original + translation) |

**Lifecycle**: Thu thập trong suốt phiên AI subtitle, dùng cho SRT export và cache.

---

### CachedSubtitle (Room Entity)

Bản ghi cache phụ đề cho một video cụ thể.

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | Long | PK, auto-generate | ID nội bộ |
| videoUri | String | Unique, indexed | URI định danh video |
| videoHash | String | | Hash nội dung video (để detect thay đổi) |
| language | String | | Ngôn ngữ nguồn đã nhận dạng |
| targetLanguage | String | | Ngôn ngữ dịch đích |
| createdAt | Long | | Timestamp tạo cache (epoch ms) |
| entries | String (JSON) | | Danh sách SrtEntry serialized |

**Relationships**: Một CachedSubtitle chứa nhiều SrtEntry (embedded as JSON).

---

### SonioxConfig

Cấu hình cho phiên kết nối Soniox.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| apiKey | String | (required) | API key Soniox |
| sourceLanguage | String | "auto" | Ngôn ngữ nguồn (auto-detect hoặc chỉ định) |
| targetLanguage | String | "vi" | Ngôn ngữ dịch đích |
| translationTerms | List<TranslationTerm> | emptyList() | Các thuật ngữ dịch tùy chỉnh |

---

### TranslationTerm

Thuật ngữ dịch tùy chỉnh để cải thiện chất lượng dịch.

| Field | Type | Description |
|-------|------|-------------|
| source | String | Thuật ngữ nguồn |
| target | String | Bản dịch mong muốn |

---

## State Transitions

### AiSubtitleSession State

```
IDLE → CONNECTING → ACTIVE → DISCONNECTING → IDLE
                  ↘ ERROR → RECONNECTING → CONNECTING
                                         ↘ FAILED → IDLE
```

| State | Description |
|-------|-------------|
| IDLE | AI subtitle tắt, không có kết nối |
| CONNECTING | Đang mở WebSocket, gửi config |
| ACTIVE | Đang nhận và hiển thị phụ đề |
| DISCONNECTING | Đang đóng kết nối (user tắt hoặc chuyển video) |
| ERROR | Lỗi kết nối, chuẩn bị reconnect |
| RECONNECTING | Đang thử kết nối lại (max 3 lần, delay 2s/4s/6s) |
| FAILED | Hết số lần reconnect, chờ user action |

### Session Reset State (3-phút cycle)

```
ACTIVE → PREPARING_NEW → SWITCHING → ACTIVE
```

- PREPARING_NEW: Mở WebSocket mới, gửi config + context
- SWITCHING: WebSocket mới sẵn sàng, chuyển audio stream sang, đóng WebSocket cũ

## Validation Rules

- `apiKey` không được rỗng
- `sourceLanguage` phải là mã ngôn ngữ hợp lệ hoặc "auto"
- `targetLanguage` phải là mã ngôn ngữ hợp lệ
- `SrtEntry.startMs` < `SrtEntry.endMs`
- `SrtEntry.index` > 0, tuần tự tăng dần
- `CachedSubtitle.entries` phải parse được thành List<SrtEntry>
