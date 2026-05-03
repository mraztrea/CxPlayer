# Data Model: Transport Row Redesign

**Date**: 2026-05-03

## Layout Model

### Bottom Chrome Structure (after redesign)

```
playerBottomChrome (LinearLayout, vertical)
├── playerTimelineRow (LinearLayout, horizontal)
│   ├── playerCurrentTimeView (TextView)
│   ├── playerSeekBar (SeekBar)
│   └── playerDurationView (TextView)
└── playerTransportRow (LinearLayout, horizontal, gravity=center)
    ├── [HIDDEN] playerSeekBackButton (expanded only)
    ├── [HIDDEN] playerRepeatButton (expanded only)
    ├── playerResizeButton ← always visible
    ├── playerSkipPreviousButton ← always visible
    ├── playerPlayPauseButton ← always visible
    ├── playerSkipNextButton ← always visible
    ├── playerSubtitleButton ← always visible
    ├── [HIDDEN] playerAudioTrackButton (expanded only)
    ├── [HIDDEN] playerSpeedSpinner (expanded only)
    ├── [HIDDEN] playerShuffleButton (expanded only)
    ├── [HIDDEN] playerAutoPlayButton (expanded only)
    └── [HIDDEN] playerSeekForwardButton (expanded only)
```

### Floating Buttons (tách biệt khỏi transport)

```
playerRoot (FrameLayout)
├── ...
├── playerFloatingButtons (LinearLayout, vertical, gravity=center_vertical|end)
│   ├── playerLockButton (ImageButton)
│   └── playerExpandButton (ImageButton) ← NEW
└── playerUnlockButton (existing, visible when locked)
```

## State Model

### Transport Expand State

| State | Transport Buttons Visible | Floating Icon |
|-------|--------------------------|---------------|
| Collapsed (default) | Resize, Prev, Play, Next, Subtitle | Expand (chevron) |
| Expanded | All 12 buttons | Collapse (chevron) |

### State Transitions

```
Collapsed → [user taps Expand button] → Expanded
Expanded → [user taps Expand button] → Collapsed
Expanded → [chrome hides] → (remember state) → [chrome shows] → Expanded
Collapsed → [chrome hides] → (remember state) → [chrome shows] → Collapsed
Any → [Lock tapped] → Locked (all chrome hidden, only Unlock visible)
```

## Dimension Changes

| Dimension | Current | New | Reason |
|-----------|---------|-----|--------|
| player_transport_row_min_height | 56dp | 48dp | Thu nhỏ vừa 1 hàng nút |
| player_transport_primary_button_size | 56dp | 48dp | Đồng bộ với row height |
| player_transport_primary_button_padding | 14dp | 10dp | Tăng vùng icon trong 48dp |
| player_function_row_height | 48dp | (remove) | Function row bị xoá |
| player_function_row_margin_top | 4dp | (remove) | Function row bị xoá |
| player_transport_row_margin_top | 12dp | 8dp | Compact hơn |

## New Drawables

| File | Description |
|------|-------------|
| ic_player_expand.xml | Vector drawable - chevron/arrow icon cho expand |
| ic_player_collapse.xml | Vector drawable - chevron/arrow icon cho collapse |
