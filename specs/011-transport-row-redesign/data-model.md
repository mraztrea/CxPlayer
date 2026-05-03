# Data Model: Transport Row Redesign

## UI State

### TransportRowState

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| isExpanded | Boolean | false | Hàng nút phụ (function row) có đang hiển thị không |

### Lifecycle

```
COLLAPSED (default)
    ↓ [User taps Expand button]
EXPANDED
    ↓ [User taps Close button / Chrome auto-hide / Screen lock]
COLLAPSED
```

### State Transitions

| From | Trigger | To | Side Effect |
|------|---------|----|----|
| COLLAPSED | Bấm Expand | EXPANDED | Slide up animation, icon → "X" |
| EXPANDED | Bấm Close (X) | COLLAPSED | Slide down animation, icon → chevron |
| EXPANDED | Chrome auto-hide timeout | COLLAPSED | Slide down, rồi ẩn chrome |
| EXPANDED | Screen lock | COLLAPSED | Slide down, rồi lock |
| EXPANDED | Tap anywhere (toggle chrome) | COLLAPSED | Slide down, rồi ẩn chrome |

## Button Layout Mapping

### Transport Row (always visible, center-aligned)

| Position | Button ID | Icon | Function |
|----------|-----------|------|----------|
| 1 | playerPipButton | ic_player_pip | Picture-in-Picture |
| 2 | playerSkipPreviousButton | ic_player_skip_previous | Previous track |
| 3 | playerPlayPauseButton | ic_player_play/pause | Play/Pause toggle |
| 4 | playerSkipNextButton | ic_player_skip_next | Next track |
| 5 | playerSubtitleButton | ic_player_subtitle | Subtitle selector |

### Function Row (expandable, center-aligned)

| Position | Button ID | Icon/Text | Function |
|----------|-----------|-----------|----------|
| 1 | playerShuffleButton | ic_player_shuffle | Shuffle toggle |
| 2 | playerSeekBackButton | ic_player_seek_back | Rewind |
| 3 | playerSpeedButton (new) | Text "1X" | Cycle playback speed |
| 4 | playerSeekForwardButton | ic_player_seek_forward | Fast forward |
| 5 | playerRepeatButton | ic_player_repeat | Repeat mode toggle |

### Side Buttons (right side, vertical stack)

| Position | Button ID | Icon | Function |
|----------|-----------|------|----------|
| Top | playerLockButton | ic_player_lock | Lock screen |
| Bottom | playerExpandButton (new) | ic_player_expand / ic_close | Toggle expand/collapse |
