# Workflow: Player GUI Redesign - 2026-05-02

## Tổng quan
Redesign giao diện điều khiển CxPlayer theo mẫu `video_player_module`:
- **Layout**: Thêm Function Row (HorizontalScrollView) với 8 nút chức năng
- **Lock Screen**: Ẩn toàn bộ chrome, chỉ hiện nút Unlock ở giữa
- **Resize Mode**: Cycle giữa Fit → Fill → Zoom
- **Rotation**: Cycle Landscape → Portrait → Sensor
- **Speed**: Spinner dropdown 0.25x → 2.0x
- **Subtitle**: Toggle/popup tùy số lượng track
- **Auto-play**: Toggle bật/tắt
- **Overflow menu**: Settings chuyển vào popup menu
- **Auto-hide Chrome**: Single tap toggle, tự ẩn sau 5s khi đang play, 3s khi locked
- **Immersive Mode**: Ẩn status bar + navigation bar đồng bộ với chrome visibility

## Các file đã sửa

### Resources
- `res/drawable/ic_player_lock.xml` — Icon khóa
- `res/drawable/ic_player_unlock.xml` — Icon mở khóa
- `res/drawable/ic_player_rotate.xml` — Icon xoay
- `res/drawable/ic_player_subtitle.xml` — Icon phụ đề
- `res/drawable/ic_player_subtitle_off.xml` — Icon phụ đề tắt
- `res/drawable/ic_player_resize_fit.xml` — Icon fit
- `res/drawable/ic_player_resize_fill.xml` — Icon fill
- `res/drawable/ic_player_resize_zoom.xml` — Icon zoom
- `res/drawable/ic_player_autoplay.xml` — Icon autoplay
- `res/drawable/ic_player_autoplay_off.xml` — Icon autoplay tắt
- `res/values/strings.xml` — Thêm string resources
- `res/values/dimens.xml` — Thêm dimension resources
- `res/menu/player_overflow.xml` — Menu overflow mới

### Layout
- `res/layout/activity_player.xml` — Thêm Function Row, unlock button, loại Settings/Shuffle khỏi transport

### Logic
- `GestureController.kt` — Thêm `isLocked` flag
- `PlayerActivity.kt` — Function row handlers, lock/resize/rotate/speed/autoplay logic
- `MainActivity.kt` — Cập nhật changelog

## Lệnh cần chạy
Không cần migration hay lệnh đặc biệt. Build bình thường:
```powershell
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-21.0.11.10-hotspot"
.\gradlew.bat assembleDebug
```
