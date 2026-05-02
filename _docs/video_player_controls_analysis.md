# Phân Tích Giao Diện Điều Khiển Video - `video_player_module`

> Module này là code decompile từ app **CxFileExplorer** (Alpha Inventor), sử dụng **ExoPlayer/Media3** làm engine phát video.

## Tổng Quan Kiến Trúc

- **Activity chính**: `VideoPlayerActivity` (~3464 dòng, obfuscated)
- **Click handler**: `VideoPlayerActivity$g` — xử lý tất cả sự kiện click qua `O1` listener
- **Subtitle dialog**: Class `f` — PopupWindow để chọn track (subtitle/audio)
- **Orientation handler**: `VideoPlayerActivity$y` — OrientationEventListener xoay màn hình
- **Gesture**: `GestureDetector` + `ScaleGestureDetector` cho swipe & pinch-to-zoom

---

## Các Chức Năng Trên Giao Diện Điều Khiển Video

### 🎬 Điều Khiển Phát (Playback Controls)

| # | Chức năng | Field | Method | Ghi chú |
|---|-----------|-------|--------|---------|
| 1 | **Play/Pause** | ExoPlayer built-in | `dispatchKeyEvent` (keycode 85, 62, 126, 127) | Nút play/pause mặc định của ExoPlayer |
| 2 | **Seek Bar** | `S` (TimeBar) | `K1` callback | Thanh progress tua video |
| 3 | **Tua nhanh (Fast Forward)** | Built-in ExoPlayer | `exo_player_control_ffwd_button.xml` | Tua tiến |
| 4 | **Tua lùi (Rewind)** | Built-in ExoPlayer | `exo_player_control_rewind_button.xml` | Tua lùi |

### 🔀 Điều Hướng Playlist

| # | Chức năng | Field | Method | Ghi chú |
|---|-----------|-------|--------|---------|
| 5 | **Next video** | `n` (View) | `P1()` → `n3()` | Chuyển video kế tiếp trong playlist. Chỉ hoạt động khi `w2() < C2() - 1` |
| 6 | **Previous video** | `o` (View) | `Q1()` → `u3()` | Quay lại video trước. Nếu đang phát > 3s thì seek về đầu |

### 🖥️ Hiển Thị & Tỉ Lệ

| # | Chức năng | Field | Method | Ghi chú |
|---|-----------|-------|--------|---------|
| 7 | **Resize Mode / Tỉ lệ khung hình** | `r` (ImageButton) | `R1()` → `d4()` | Chuyển đổi 3 chế độ: Fit (0), Fill (3), Zoom (4). Icon thay đổi theo chế độ. Hiện text mô tả 1 giây |
| 8 | **Xoay màn hình (Rotate)** | `s` (View) | `K()` → `B3()` | Toggle landscape/portrait. Sử dụng `OrientationEventListener` để tự động xoay theo cảm biến |
| 9 | **Pinch-to-Zoom** | `ScaleGestureDetector M1` | Touch listener | Phóng to/thu nhỏ video bằng cử chỉ 2 ngón tay trên `AspectRatioFrameLayout` |

### 📝 Phụ Đề (Subtitle)

| # | Chức năng | Field | Method | Ghi chú |
|---|-----------|-------|--------|---------|
| 10 | **Toggle Subtitle ON/OFF** | `v` (ImageButton) | `S1()` → `f4()` | Bật/tắt phụ đề. Sử dụng class `f` (subtitle dialog). Nếu `l0 == 1`: toggle trực tiếp, nếu không: hiện popup chọn |
| 11 | **Subtitle Track Selector** | `D1` (class `f`) | `D1.o()`, `D1.k()`, `D1.l()` | PopupWindow cho phép chọn track subtitle cụ thể |

### 🔊 Âm Thanh & Track

| # | Chức năng | Field | Method | Ghi chú |
|---|-----------|-------|--------|---------|
| 12 | **Audio Track Selector** | `u` (ImageButton) | `T1()` → `d2()` | Hiện popup chọn track audio. Gọi `D1.n(this.v)` |
| 13 | **Tốc độ phát (Speed)** | `y` (MySpinner) | `K3()` | Dropdown spinner chọn tốc độ phát. Lưu/restore qua `onSaveInstanceState` |

### 🔒 Khóa Màn Hình

| # | Chức năng | Field | Method | Ghi chú |
|---|-----------|-------|--------|---------|
| 14 | **Lock Screen (chế độ đơn giản)** | `p` (View) | `S0(1)` → `j3(true)` | Khóa giao diện - ẩn tất cả nút điều khiển. Chỉ hiển thị nút unlock `g` |
| 15 | **Unlock Screen** | `q` (View) | `S0(0)` → `j3(false)` | Mở khóa giao diện - hiện lại tất cả control |

### 🔄 Chế Độ Phát

| # | Chức năng | Field | Method | Ghi chú |
|---|-----------|-------|--------|---------|
| 16 | **Night Mode / Tự động xoay** | `t` (ImageView) | `M()` → `a4()` | Toggle `n0` flag. Khi bật: icon thay đổi (2131231112 vs 2131231134). Liên quan đến auto-play setting |
| 17 | **Shuffle playlist** | `x` (ImageButton) | `P()` → `e4()` | Toggle chế độ shuffle. Đảo thứ tự playlist `c0`. Lưu setting qua `ax.p3.m.k()` |

### ✋ Cử Chỉ (Gesture Controls)

| # | Chức năng | Ghi chú |
|---|-----------|---------|
| 18 | **Swipe dọc bên trái → Brightness** | Điều chỉnh độ sáng màn hình via `WindowManager.LayoutParams.screenBrightness` |
| 19 | **Swipe dọc bên phải → Volume** | Điều chỉnh âm lượng via `AudioManager.setStreamVolume(STREAM_MUSIC)` |
| 20 | **Swipe ngang → Seek** | Tua video qua gesture swipe ngang |
| 21 | **Double tap → Fast seek** | Tua nhanh bằng double tap (left/right) |
| 22 | **Pinch → Zoom** | Phóng to/thu nhỏ video |

### 📊 Hiển Thị Thông Tin

| # | Chức năng | Field | Ghi chú |
|---|-----------|-------|---------|
| 23 | **Tên file/video** | `T` (TextView) | Hiển thị title video trên toolbar |
| 24 | **Thời gian hiện tại** | `E` (TextView) | Hiển thị vị trí phát hiện tại |
| 25 | **Brightness/Volume indicator** | `B`, `C` (ProgressBar), `D` | Thanh hiển thị mức brightness/volume khi swipe |
| 26 | **Resize mode label** | `A` (TextView) | Hiển thị tên chế độ resize 1 giây khi chuyển |

### 📋 Menu Options

| # | Chức năng | Ghi chú |
|---|-----------|---------|
| 27 | **Options Menu** | `onCreateOptionsMenu` — inflate menu resource |
| 28 | **Menu Item 1** | ID `2131362531` → gọi `X3()` |
| 29 | **Menu Item 2** | ID `2131362536` → gọi `a4()` (hidden by default) |

---

## Sơ Đồ Bố Cục UI

```
┌──────────────────────────────────────────────────────┐
│  [Toolbar: Back + Title (T)]              [Menu ⋮]   │
│                                                       │
│  ┌─────────────────────────────────────────────────┐  │
│  │                                                 │  │
│  │              VIDEO PLAYER VIEW (b)              │  │
│  │          (AspectRatioFrameLayout F)              │  │
│  │                                                 │  │
│  │    [Brightness/Volume indicator B,C,D]          │  │
│  │                                                 │  │
│  └─────────────────────────────────────────────────┘  │
│                                                       │
│  ┌─── Control Bar (hàng trên) ────────────────────┐  │
│  │ [Lock p/q] [Rotate s] [Auto n0/t]               │  │
│  │ [Audio u] [Subtitle v] [Resize r]               │  │
│  │ [Shuffle x] [Speed y]                           │  │
│  └─────────────────────────────────────────────────┘  │
│                                                       │
│  ┌─── Control Bar (hàng dưới) ────────────────────┐  │
│  │ [Prev o]  [Rewind]  [Play/Pause]  [FFwd]  [Next n] │
│  │            [────── SeekBar S ──────]            │  │
│  │            [Time E]          [Duration]          │  │
│  └─────────────────────────────────────────────────┘  │
│                                                       │
│  ┌─── Lock Mode (khi r1=true) ────────────────────┐  │
│  │                [Unlock g]                        │  │
│  └─────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────┘
```

## Tóm Tắt

Video player module có **tổng cộng ~22 chức năng điều khiển** chính:

1. ▶️ Play/Pause
2. ⏩ Fast Forward / ⏪ Rewind
3. ⏭️ Next / ⏮️ Previous (playlist navigation)
4. 📐 Resize Mode (Fit/Fill/Zoom - 3 chế độ)
5. 🔄 Screen Rotation (portrait/landscape toggle)
6. 📌 Pinch-to-Zoom
7. 📝 Subtitle Toggle + Track Selector
8. 🔊 Audio Track Selector
9. ⚡ Playback Speed (spinner dropdown)
10. 🔒 Lock/Unlock Screen
11. 🔀 Shuffle Playlist
12. 🌙 Auto-play/Night mode toggle
13. 🔆 Brightness control (swipe gesture)
14. 🔊 Volume control (swipe gesture)
15. 👆 Seek by swipe gesture
16. 👆👆 Double-tap fast seek
17. 📊 Seek Bar (progress indicator)
