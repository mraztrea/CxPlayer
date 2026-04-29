# Phase 2: Gesture Controls

**Thời gian ước tính**: 1.5 tuần
**Phụ thuộc**: Phase 1 hoàn thành
**Mục tiêu**: Thêm điều khiển bằng cử chỉ cảm ứng, speed selector, aspect ratio.

---

## Checklist

- [ ] 2.1 GestureController class (touch listener tổng hợp)
- [ ] 2.2 Swipe vertical: Volume (right half)
- [ ] 2.3 Swipe vertical: Brightness (left half)
- [ ] 2.4 Swipe horizontal: Seek
- [ ] 2.5 Double-tap: Play/Pause (center), Seek ±10s (sides)
- [ ] 2.6 Long press: Fast forward 2x
- [ ] 2.7 Pinch-to-zoom (ScaleGestureDetector)
- [ ] 2.8 Gesture overlay UI (volume/brightness/seek indicators)
- [ ] 2.9 SpeedSelector popup (0.25x → 2x, 8 levels)
- [ ] 2.10 Aspect ratio toggle (Fit/Fill/Zoom/16:9/4:3)
- [ ] 2.11 Repeat mode (Off/One/All)

---

## Cấu trúc files

```
app/src/main/java/com/cxplayer/
├── ui/player/
│   └── GestureController.kt       # Main gesture handler
├── ui/controls/
│   └── SpeedSelector.kt           # Speed picker popup
└── domain/model/
    └── AspectRatio.kt              # Aspect ratio enum
```

---

## Specs chi tiết

### 2.1 GestureController

```kotlin
class GestureController(
    private val playerView: PlayerView,
    private val onVolumeChange: (delta: Float) -> Unit,
    private val onBrightnessChange: (delta: Float) -> Unit,
    private val onSeekDelta: (deltaMs: Long) -> Unit,
    private val onTogglePlayPause: () -> Unit,
    private val onFastForward: (speed: Float) -> Unit,
    private val onFastForwardEnd: () -> Unit,
    private val onZoom: (scaleFactor: Float) -> Unit
)
```

### 2.2 Gesture Mapping

| Gesture | Zone | Action |
|---------|------|--------|
| Swipe vertical | Right 50% | Volume ±1 per 150px |
| Swipe vertical | Left 50% | Brightness ±0.05 per 150px |
| Swipe horizontal | Any | Seek ±(distance × 100)ms |
| Double tap | Center | Play/Pause |
| Double tap | Left 33% | Seek -10s |
| Double tap | Right 33% | Seek +10s |
| Long press | Any | Fast forward 2x (release → normal) |
| Pinch | Any | Zoom video (1.0 → 3.0x) |

### 2.3 Overlay UI khi gesture

```
┌──────────────────────────────┐
│                              │
│        🔊 Volume: 75%        │  ← Right swipe up
│        ☀️ Brightness: 60%    │  ← Left swipe up
│        ▶▶ 2X ▶▶             │  ← Long press
│        ◀ -00:30              │  ← Horizontal swipe
│                              │
└──────────────────────────────┘
```

### 2.4 SpeedSelector

```kotlin
val SPEED_OPTIONS = listOf(
    SpeedOption("0.25x", 0.25f),
    SpeedOption("0.5x",  0.5f),
    SpeedOption("0.75x", 0.75f),
    SpeedOption("1x",    1.0f),    // default
    SpeedOption("1.25x", 1.25f),
    SpeedOption("1.5x",  1.5f),
    SpeedOption("1.75x", 1.75f),
    SpeedOption("2x",    2.0f),
)
```

### 2.5 Aspect Ratio

```kotlin
enum class AspectRatio(val mode: Int) {
    FIT(AspectRatioFrameLayout.RESIZE_MODE_FIT),
    FILL(AspectRatioFrameLayout.RESIZE_MODE_FILL),
    ZOOM(AspectRatioFrameLayout.RESIZE_MODE_ZOOM),
    FIXED_16_9(AspectRatioFrameLayout.RESIZE_MODE_FIXED_WIDTH),
    FIXED_4_3(AspectRatioFrameLayout.RESIZE_MODE_FIXED_HEIGHT),
}
```

---

## Verification

1. Vuốt bên phải lên/xuống → Volume thay đổi, indicator hiện
2. Vuốt bên trái lên/xuống → Brightness thay đổi, indicator hiện
3. Vuốt ngang → Seek, hiện thời gian delta
4. Double-tap giữa → Play/Pause toggle
5. Double-tap trái/phải → Seek ±10s
6. Nhấn giữ → 2x speed, thả → normal
7. Pinch → Zoom video
8. Speed popup → chọn 1.5x → video chạy nhanh hơn
9. Aspect ratio → chuyển Fit → Fill → Zoom
