# Network Playback Contract

## Purpose

Tài liệu này mô tả contract cấp feature giữa browser SMB, playback stack Media3, `PlayerActivity` và service-backed session khi triển khai Network Polish.

## Surface

- Owner của playback policy: `CxPlayerManager`
- Owner của session continuity: `PlaybackService`
- Owner của UI playback shell, PiP và orientation: `PlayerActivity`
- Source resolver: `CxMediaSourceFactory`
- Datasource bridge: `CxDataSourceFactory`, `SmbDataSource`
- SMB browse/auth layer: `SmbBrowser`

## Source Resolution Contract

| Source Type | Expected Routing |
|-------------|------------------|
| `http` / `https` | Đi qua `CxDataSourceFactory` với OkHttp-backed datasource và network wake policy |
| `content` / `file` | Tiếp tục phát qua local/content flow hiện có với local wake policy |
| `smb` | Chỉ được tạo từ flow browse nội bộ và route qua `SmbDataSource` |

## Network Policy Contract

| Condition | Expected Behavior |
|-----------|-------------------|
| Source là HTTP(S) hoặc SMB | Player dùng network wake mode và buffer policy tối ưu cho LAN/network playback |
| Source là local/content | Player không giữ network wake lock dư thừa |
| Network source fail tạm thời | App báo lỗi rõ ràng hoặc retry theo policy, không treo UI playback |

## SMB Contract

| Condition | Expected Behavior |
|-----------|-------------------|
| Credential hợp lệ và share truy cập được | Browser trả danh sách thư mục/file để user tiếp tục điều hướng |
| Credential sai hoặc server từ chối | Browser trả lỗi thân thiện, không phát sinh playback request giả |
| User chọn file video trong SMB browser | Entry được chuyển thành source nội bộ có thể route sang playback stack |
| User chọn thư mục | Browser chỉ đổi thư mục hiện tại, không tạo playback request |

## Continuity Contract

1. `PlayerActivity` không được là owner duy nhất của player lifecycle sau feature này; `PlaybackService` phải giữ session khi app xuống nền.
2. Chuyển `Foreground -> PictureInPicture` hoặc `Foreground -> BackgroundAudio` không được làm mất `currentIndex`, `currentPositionMs` hoặc `playWhenReady`.
3. Khi activity quay lại foreground, `PlayerView` phải attach lại vào session đang active thay vì tạo player mới ngoài ý muốn.

## PiP and Orientation Contract

| Condition | Expected Behavior |
|-----------|-------------------|
| User rời app khi video đang phát trên thiết bị hỗ trợ PiP | Activity có thể vào PiP và playback tiếp tục |
| Activity `onPause()` xảy ra vì vào PiP | Logic pause thông thường không được dừng playback một cách mù quáng |
| User khóa orientation cho phiên xem | Activity giữ requested orientation đó qua recreate cho đến khi user đổi lại |

## Validation Mapping

| Validation | Contract Being Verified |
|------------|-------------------------|
| `PlaybackRequestParserTest` | Source classification và SMB internal launch không phá các scheme cũ |
| `CxPlayerManagerTest` | Wake mode, load control và media source routing đúng với loại source |
| `SmbBrowserContractTest` | Browse/auth error handling và playable entry mapping đúng |
| `PlayerActivityPlaybackTest` | PiP/orientation/background continuity wiring không phá playback shell |
| Manual LAN/SMB verification | Time-to-first-frame, browse success và continuity outcome khớp spec |

## Current Limitation

- Contract này chưa bao phủ lưu credential SMB hoặc reconnect tự động sau process death.
- SMB vẫn là flow nội bộ của app, không phải app-wide protocol handler.
- Continuity tập trung vào một playback session active, chưa mở rộng sang playlist/network queue phức tạp.