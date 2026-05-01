# Data Model: Network Polish

## Overview

Feature này không thêm persistence dài hạn. Mô hình dữ liệu tập trung vào runtime state cần để duyệt SMB, phân loại playback source, giữ continuity qua foreground/PiP/background và áp orientation policy đúng trong phiên xem.

## Entities

### PlaybackTransportSource

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | String | Yes | Mã ổn định của source trong phiên phát |
| `uriValue` | String | Yes | URI chuẩn hóa dùng cho playback routing |
| `scheme` | Enum | Yes | `Http`, `Https`, `Content`, `File`, hoặc `Smb` |
| `displayLabel` | String? | No | Nhãn hiển thị cho user hoặc player chrome |
| `mimeType` | String? | No | MIME type nếu nguồn hoặc parser xác định được |
| `requiresNetworkWakeMode` | Boolean | Yes | Source này có cần network wake policy hay không |
| `usesCustomDataSource` | Boolean | Yes | Có đi qua datasource factory đặc thù hay không |

**Validation rules**

- `scheme = Smb` chỉ hợp lệ với internal explicit launch flow của app.
- `requiresNetworkWakeMode` phải đúng với `scheme` mạng như `Http`, `Https`, `Smb`.
- `uriValue` phải được chuẩn hóa trước khi được route sang media source factory.

### NetworkCredentialSet

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `host` | String | Yes | Tên máy hoặc IP của SMB server |
| `shareName` | String | Yes | Tên share người dùng muốn mở |
| `username` | String | Yes | Tài khoản dùng để xác thực |
| `password` | String | Yes | Mật khẩu runtime cho phiên browse/play |
| `domain` | String? | No | Domain/workgroup nếu server yêu cầu |

**Validation rules**

- `host` và `shareName` không được rỗng sau khi trim.
- Credential chỉ được giữ trong session runtime và phải bị bỏ khi browse/play session kết thúc.
- `password` không được ghi log hoặc lưu vĩnh viễn trong phase này.

### SharedLibraryEntry

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `path` | String | Yes | Đường dẫn SMB tương đối trong share |
| `displayName` | String | Yes | Tên hiển thị trong browser UI |
| `entryType` | Enum | Yes | `Directory` hoặc `File` |
| `sizeBytes` | Long? | No | Kích thước nếu entry là file và server cung cấp |
| `lastModifiedEpochMs` | Long? | No | Mốc sửa đổi gần nhất nếu có |
| `isPlayableCandidate` | Boolean | Yes | Có phải file video app có thể phát thử hay không |

**Validation rules**

- `entryType = Directory` thì `isPlayableCandidate = false`.
- `displayName` không được rỗng, kể cả khi path gốc thiếu metadata đẹp.
- Nếu `isPlayableCandidate = true`, extension hoặc metadata phải khớp nhóm video app hỗ trợ.

### NetworkBrowseSession

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `credentialSet` | NetworkCredentialSet | Yes | Credential runtime của phiên browse hiện tại |
| `currentDirectoryPath` | String | Yes | Thư mục đang được hiển thị |
| `entries` | List<SharedLibraryEntry> | Yes | Danh sách entry ở thư mục hiện tại |
| `connectionState` | Enum | Yes | `Disconnected`, `Authenticating`, `Browsing`, `Error` |
| `errorMessage` | String? | No | Thông điệp lỗi thân thiện khi browse thất bại |

**Validation rules**

- `connectionState = Error` thì `errorMessage` phải được cung cấp.
- `connectionState = Browsing` thì `credentialSet` và `entries` phải phản ánh cùng một share/session active.
- Một browse session chỉ map tới một host/share active tại một thời điểm.

### PlaybackContinuityState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `playbackMode` | Enum | Yes | `Foreground`, `PictureInPicture`, `BackgroundAudio` hoặc `Stopped` |
| `currentIndex` | Int | Yes | Media item index đang active |
| `currentPositionMs` | Long | Yes | Vị trí phát gần nhất |
| `playWhenReady` | Boolean | Yes | User có muốn tiếp tục phát hay không |
| `hasAttachedUi` | Boolean | Yes | Hiện có activity/player view đang attach vào session hay không |

**Validation rules**

- `currentPositionMs` luôn không âm.
- `playbackMode = PictureInPicture` chỉ hợp lệ khi source là video và activity đang hỗ trợ PiP.
- Chuyển `Foreground -> BackgroundAudio` không được reset `currentIndex` hoặc `currentPositionMs`.

### OrientationPreference

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `mode` | Enum | Yes | `Auto`, `PortraitLocked`, `LandscapeLocked`, `CurrentLocked` |
| `requestedOrientationValue` | Int | Yes | Giá trị orientation được áp xuống activity |
| `appliesToCurrentSessionOnly` | Boolean | Yes | Có chỉ áp dụng cho phiên xem hiện tại hay không |

**Validation rules**

- `appliesToCurrentSessionOnly` luôn là `true` trong phase này.
- `requestedOrientationValue` phải tương ứng với `mode` đã chọn.
- Recreate activity không được làm mất `mode` khi phiên phát vẫn active.

## Relationships

- `PlaybackTransportSource` là đầu vào cho `CxMediaSourceFactory` để quyết định datasource, wake mode và media source routing.
- `NetworkBrowseSession` được tạo từ `NetworkCredentialSet` và trả về `SharedLibraryEntry`; khi user chọn file playable, entry đó được chuyển thành `PlaybackTransportSource` với `scheme = Smb`.
- `PlaybackContinuityState` được service-backed playback layer giữ làm nguồn sự thật cho UI attach/detach, PiP và background audio.
- `OrientationPreference` là state UI kèm theo `PlaybackContinuityState` nhưng không làm owner của player engine.

## State Transitions

### SMB browse lifecycle

`Disconnected` -> `Authenticating`

- User nhập host/share/credential và gửi yêu cầu kết nối.

`Authenticating` -> `Browsing`

- Xác thực thành công, app lấy được danh sách entry trong thư mục đích.

`Authenticating` -> `Error`

- Server từ chối credential hoặc share không truy cập được.

`Browsing` -> `Browsing`

- User đi sâu vào một thư mục con hoặc quay lên thư mục cha.

`Browsing` -> `Disconnected`

- User đóng browser hoặc session bị kết thúc.

### Playback continuity lifecycle

`Foreground` -> `PictureInPicture`

- User rời app khi đang xem video trên thiết bị hỗ trợ PiP.

`Foreground` -> `BackgroundAudio`

- User đưa app xuống nền hoặc tắt màn hình khi audio vẫn được phép tiếp tục.

`PictureInPicture` -> `Foreground`

- User chạm vào cửa sổ PiP để quay lại màn hình đầy đủ.

`BackgroundAudio` -> `Foreground`

- User mở lại app khi service-backed session vẫn còn active.

`Foreground | PictureInPicture | BackgroundAudio` -> `Stopped`

- User chủ động dừng phát hoặc session/service bị release.

### Orientation lifecycle

`Auto` -> `PortraitLocked | LandscapeLocked | CurrentLocked`

- User chọn khóa hướng cho phiên xem hiện tại.

`PortraitLocked | LandscapeLocked | CurrentLocked` -> `Auto`

- User bật lại tự xoay.