# Data Model: Player GUI Redesign

**Date**: 2026-05-02

## Entities

### PlayerControlState

Quản lý trạng thái toàn bộ giao diện điều khiển video.

| Field | Type | Description |
|-------|------|-------------|
| isVisible | Boolean | Chrome đang hiển thị hay ẩn |
| isLocked | Boolean | Giao diện đang ở chế độ khóa |
| resizeMode | ResizeMode | Chế độ hiển thị video hiện tại |
| playbackSpeed | Float | Tốc độ phát hiện tại (default 1.0) |
| isSubtitleEnabled | Boolean | Phụ đề đang bật/tắt |
| isShuffleEnabled | Boolean | Chế độ shuffle đang bật/tắt |
| isAutoPlayEnabled | Boolean | Auto-play đang bật/tắt |
| orientation | ScreenOrientation | Hướng màn hình hiện tại |

### ResizeMode (Enum)

| Value | Media3 Constant | Label | Icon |
|-------|-----------------|-------|------|
| FIT | RESIZE_MODE_FIT (0) | "Vừa khung" | ic_player_resize_fit |
| FILL | RESIZE_MODE_FILL (3) | "Lấp đầy" | ic_player_resize_fill |
| ZOOM | RESIZE_MODE_ZOOM (4) | "Phóng to" | ic_player_resize_zoom |

**Transitions**: FIT → FILL → ZOOM → FIT (vòng)

### PlaybackSpeed

| Value | Label |
|-------|-------|
| 0.25f | "0.25x" |
| 0.5f | "0.5x" |
| 0.75f | "0.75x" |
| 1.0f | "1.0x" |
| 1.25f | "1.25x" |
| 1.5f | "1.5x" |
| 2.0f | "2.0x" |

**Persistence**: Lưu vào SharedPreferences, restore khi mở player.

### FunctionButton

| Field | Type | Description |
|-------|------|-------------|
| id | String | View ID (e.g., playerLockButton) |
| icon | DrawableRes | Resource ID cho icon |
| contentDescription | StringRes | Accessibility description |
| isVisible | Boolean | Hiển thị hay không |
| isEnabled | Boolean | Có thể tương tác hay không |
| position | Int | Thứ tự trên function row (0-based, trái→phải) |

**Danh sách button cố định (theo thứ tự)**:

| Position | ID | Default Icon |
|----------|-----|-------------|
| 0 | playerLockButton | ic_player_lock |
| 1 | playerSubtitleButton | ic_player_subtitle |
| 2 | playerResizeButton | ic_player_resize_fit |
| 3 | playerRotateButton | ic_player_rotate |
| 4 | playerAudioTrackButton | ic_player_track_selector |
| 5 | playerSpeedSpinner | (Spinner widget) |
| 6 | playerShuffleButton | ic_player_shuffle |
| 7 | playerAutoPlayButton | ic_player_autoplay |

## State Transitions

### Lock/Unlock Flow

```
UNLOCKED ──[nhấn Lock]──→ LOCKED
  ↑                          │
  └──[nhấn Unlock]───────────┘

UNLOCKED:
  - Tất cả button visible
  - Gesture enabled  
  - Auto-hide timeout = 5000ms

LOCKED:
  - Chỉ Unlock button visible
  - Gesture disabled
  - Auto-hide timeout = 3000ms
```

### Chrome Visibility Flow

```
HIDDEN ──[tap screen]──→ VISIBLE ──[timeout/tap]──→ HIDDEN
                              │
                              └──[user interaction]──→ VISIBLE (reset timer)
```
