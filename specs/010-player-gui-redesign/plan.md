# Implementation Plan: Player GUI Redesign

**Branch**: `012-player-gui-redesign` | **Date**: 2026-05-02 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/010-player-gui-redesign/spec.md`

## Summary

Redesign giao diện điều khiển video player CxPlayer cho khớp với bố cục và chức năng của `video_player_module` (CxFileExplorer). Thay đổi chính: thêm function row chứa 8 nút chức năng phụ (Lock, Subtitle, Resize, Rotate, Audio, Speed, Shuffle, Auto-play) vào Bottom Chrome, triển khai lock screen mode, resize mode toggle, screen rotation, và playback speed dropdown. Giữ Repeat trên transport row, chuyển Settings vào overflow menu.

## Technical Context

**Language/Version**: Kotlin 2.0+ / Java 17  
**Primary Dependencies**: AndroidX Media3 (ExoPlayer), AndroidX AppCompat, Material Components  
**Storage**: SharedPreferences (playback speed, resize mode preferences)  
**Testing**: Manual testing trên thiết bị/emulator  
**Target Platform**: Android 7.0+ (API 24), targetSdk 36  
**Project Type**: Mobile app (Android video player)  
**Performance Goals**: UI response < 200ms, Lock/Unlock < 100ms  
**Constraints**: Không sử dụng Compose (toàn bộ UI dùng XML + View), tương thích ExoPlayer/Media3 API  
**Scale/Scope**: 1 Activity, ~3 file Kotlin sửa đổi, ~10 drawable mới, 1 layout XML sửa đổi

## Constitution Check

*Constitution chưa được cấu hình (template placeholder). Bỏ qua gates.*

## Project Structure

### Documentation (this feature)

```text
specs/010-player-gui-redesign/
├── spec.md              # Feature specification
├── plan.md              # This file
├── research.md          # Phase 0 - Research findings
├── data-model.md        # Phase 1 - Data model
├── quickstart.md        # Phase 1 - Quickstart guide
└── tasks.md             # Phase 2 output (tạo bởi /speckit.tasks)
```

### Source Code (repository root)

```text
CxPlayer/app/src/main/
├── java/com/cxplayer/
│   ├── ui/player/
│   │   ├── PlayerActivity.kt       # [SỬA] Thêm function row handlers, lock/resize/rotate/speed logic
│   │   └── GestureController.kt    # [SỬA] Thêm lock screen check
│   └── player/
│       └── CxPlayerManager.kt      # [SỬA] Thêm resize mode + playback speed API
├── res/
│   ├── layout/
│   │   └── activity_player.xml     # [SỬA] Thêm function row vào Bottom Chrome
│   ├── drawable/
│   │   ├── ic_player_lock.xml      # [MỚI]
│   │   ├── ic_player_unlock.xml    # [MỚI]
│   │   ├── ic_player_rotate.xml    # [MỚI]
│   │   ├── ic_player_subtitle.xml  # [MỚI]
│   │   ├── ic_player_resize_fit.xml    # [MỚI]
│   │   ├── ic_player_resize_fill.xml   # [MỚI]
│   │   ├── ic_player_resize_zoom.xml   # [MỚI]
│   │   ├── ic_player_autoplay.xml      # [MỚI]
│   │   └── ic_player_autoplay_off.xml  # [MỚI]
│   ├── values/
│   │   ├── strings.xml             # [SỬA] Thêm content descriptions + labels
│   │   └── dimens.xml              # [SỬA] Thêm function row dimensions
│   └── menu/
│       └── player_overflow.xml     # [MỚI] Overflow menu với Settings item
```

**Structure Decision**: Android mobile app single-module. Tất cả thay đổi nằm trong `app` module. Không tạo module mới.

## Design Decisions

### D1: Function Row Implementation

**Approach**: HorizontalScrollView → LinearLayout → ImageButton/Spinner
- Đơn giản, giống cách video_player_module triển khai
- Các nút cố định (8 nút), không cần RecyclerView adapter pattern
- HorizontalScrollView xử lý tự động scroll khi màn hình nhỏ

### D2: Lock Screen State Management

**Approach**: Boolean flag `isLocked` trong PlayerActivity
- Khi `isLocked = true`: ẩn tất cả button (visibility GONE), hiện unlock button, block GestureController
- Khi `isLocked = false`: restore visibility, enable gestures, reset auto-hide timeout
- Tham chiếu: `VideoPlayerActivity.j3()` + `m4()` pattern

### D3: Resize Mode Cycling

**Approach**: Enum cycle qua `ResizeMode.next()` extension function
- Map trực tiếp sang `PlayerView.setResizeMode()` 
- Icon và label cập nhật ngay lập tức
- Label hiển thị bằng Toast-style overlay (1 giây auto-dismiss)
- Tham chiếu: `VideoPlayerActivity.d4()`

### D4: Playback Speed

**Approach**: Spinner/PopupMenu thay vì custom dialog
- Giống cách video_player_module dùng `MySpinner` 
- 7 mức tốc độ cố định
- Gọi `player.setPlaybackParameters(PlaybackParameters(speed))`
- Lưu preference vào SharedPreferences

### D5: Settings → Overflow Menu

**Approach**: Chuyển nút Settings hiện tại thành menu item trong overflow popup
- Nút overflow (`playerOverflowButton`) đã có trên Top Chrome
- Tạo `player_overflow.xml` menu resource
- PopupMenu inflate từ overflow button click
