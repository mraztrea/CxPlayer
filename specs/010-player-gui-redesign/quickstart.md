# Quickstart: Player GUI Redesign

## Mục tiêu

Redesign giao diện điều khiển video player CxPlayer cho khớp với bố cục và chức năng của `video_player_module` (CxFileExplorer).

## Thay đổi chính

### Layout (`activity_player.xml`)
1. **Bottom Chrome** thêm function row (HorizontalScrollView) giữa timeline row và transport row
2. Function row chứa 8 nút: Lock, Subtitle, Resize, Rotate, Audio, Speed, Shuffle, Auto-play
3. Transport row: loại Settings button, giữ Repeat
4. Top Chrome: thêm Settings vào overflow menu

### New Drawables (6 icons)
- `ic_player_lock.xml`, `ic_player_unlock.xml`
- `ic_player_rotate.xml`
- `ic_player_subtitle.xml`
- `ic_player_resize_fit.xml`, `ic_player_resize_fill.xml`, `ic_player_resize_zoom.xml`
- `ic_player_autoplay.xml`, `ic_player_autoplay_off.xml`

### Kotlin Code
- `PlayerActivity.kt`: Thêm click handlers cho function row buttons
- `GestureController.kt`: Thêm lock screen check (`isLocked` → block gestures)
- `CxPlayerManager.kt`: Thêm resize mode + playback speed API

### Dimen/String Resources
- Thêm dimen cho function row (height, button size, padding)
- Thêm string resources cho labels và content descriptions

## Verification

```bash
# Build project
./gradlew :app:assembleDebug

# Run on device/emulator
adb install -r app/build/outputs/apk/debug/app-debug.apk

# Manual test checklist:
# 1. Mở video → xác nhận function row hiện đủ 8 nút
# 2. Nhấn Lock → xác nhận tất cả ẩn, chỉ Unlock hiện
# 3. Nhấn Resize 3 lần → xác nhận Fit→Fill→Zoom→Fit
# 4. Nhấn Rotate → xác nhận xoay màn hình
# 5. Chọn speed từ dropdown → xác nhận tốc độ thay đổi
# 6. Chờ 5 giây → xác nhận chrome auto-hide
```
