# Research: Player GUI Redesign

**Date**: 2026-05-02
**Feature**: [spec.md](spec.md)

## R1: Bố cục UI tham chiếu từ video_player_module

**Decision**: Bố cục 2 vùng chrome (Top + Bottom) với gradient scrim overlay, function row nằm giữa seek bar và transport row.

**Rationale**: Phân tích decompile từ `VideoPlayerActivity.java` cho thấy:
- Top Chrome: LinearLayout với gradient scrim, chứa back button + title + overflow
- Bottom Chrome: LinearLayout với gradient scrim, chứa timeline row + function row + transport row
- Method `m4()` (line 2086-2141) điều khiển visibility của tất cả button dựa trên state (locked/unlocked/audio-only)
- Method `j3()` (line 1927-1940) điều khiển lock/unlock với timeout 5s (normal) / 3s (locked)

**Alternatives considered**: 
- Sử dụng ExoPlayer's built-in StyledPlayerView controller → Rejected vì không hỗ trợ function row và lock screen

## R2: Cách triển khai Function Row

**Decision**: Sử dụng HorizontalScrollView chứa LinearLayout với các ImageButton, tương tự cách video_player_module triển khai.

**Rationale**: 
- Video_player_module dùng các field `f`, `g`, `h`, `i`, `j`, `l`, `m`, `n`, `o`, `p`, `q`, `r`, `s`, `t`, `u`, `v`, `x`, `y` cho các button
- Các button được set visibility riêng lẻ trong `m4()` dựa trên context (locked, audio-only, normal)
- HorizontalScrollView cho phép thêm nút mới mà không bị giới hạn chiều rộng

**Alternatives considered**:
- RecyclerView → Over-engineered cho ~8 nút cố định
- ConstraintLayout Flow → Không hỗ trợ cuộn ngang

## R3: Icon drawable cần thêm

**Decision**: Cần tạo thêm 6 icon vector drawable cho các nút mới trên function row.

**Rationale**: Icons hiện có:
- ✅ `ic_player_back`, `ic_player_play`, `ic_player_pause`, `ic_player_seek_back`, `ic_player_seek_forward`
- ✅ `ic_player_skip_next`, `ic_player_skip_previous`, `ic_player_shuffle`
- ✅ `ic_player_repeat_off/all/one`, `ic_player_track_selector`, `ic_player_settings`
- ✅ `ic_player_overflow`, `ic_player_volume`
- ❌ Thiếu: `ic_player_lock`, `ic_player_unlock`, `ic_player_rotate`, `ic_player_subtitle`, `ic_player_resize_fit/fill/zoom`, `ic_player_autoplay`

**Alternatives considered**: Sử dụng Material Icons trực tiếp → Accepted, sẽ dùng Material Icons vector drawable

## R4: Resize Mode mapping với Media3 API

**Decision**: Map 3 chế độ resize sang `AspectRatioFrameLayout.RESIZE_MODE_*`:
- Fit = `RESIZE_MODE_FIT` (0)
- Fill = `RESIZE_MODE_FILL` (3) 
- Zoom = `RESIZE_MODE_ZOOM` (4)

**Rationale**: Đây chính xác là mapping của video_player_module (method `d4()`, line 1596-1630). Media3 PlayerView wrapper exposing `setResizeMode()` API.

## R5: Playback Speed implementation

**Decision**: Sử dụng `Player.setPlaybackParameters(PlaybackParameters(speed))` của Media3 API. UI dùng Spinner/dropdown popup.

**Rationale**: Video_player_module dùng `MySpinner` widget (field `y`), gọi `K3(speed, true)` → `Player.setPlaybackParameters()`. Speed levels: 0.25x, 0.5x, 0.75x, 1.0x, 1.25x, 1.5x, 2.0x.
