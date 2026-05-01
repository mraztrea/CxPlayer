# Workflow: Playlist Queue + Shuffle + Repeat + Next/Previous Controls

**Ngày:** 2026-05-01  
**Phase:** 3 - Advanced Media (Task 3.9 & 3.10)

## Tóm tắt

Implement tính năng Playlist/Queue và các điều khiển Shuffle/Repeat/Next/Previous cho CxPlayer.

## Files đã thay đổi

### Resources
- `res/drawable/ic_player_skip_previous.xml` — Icon skip previous (Material)
- `res/drawable/ic_player_skip_next.xml` — Icon skip next (Material)
- `res/drawable/ic_player_shuffle.xml` — Icon shuffle (Material)
- `res/drawable/ic_player_repeat_off.xml` — Icon repeat tắt (dimmed)
- `res/drawable/ic_player_repeat_all.xml` — Icon repeat tất cả
- `res/drawable/ic_player_repeat_one.xml` — Icon repeat 1 video
- `res/values/strings.xml` — Thêm content description và feedback messages
- `res/layout/activity_player.xml` — Thêm 4 nút mới vào transport row

### Core Logic
- `player/CxPlayerManager.kt`:
  - Thêm `CxRepeatMode` enum (Off/All/One)
  - `PlayerSession` interface: thêm `shuffleModeEnabled`, `repeatMode`, `hasNextMediaItem`, `hasPreviousMediaItem`, `seekToNextMediaItem()`, `seekToPreviousMediaItem()`
  - `ExoPlayerSession`: implement tất cả members mới
  - `CxPlayerManager`: thêm `seekToNext()`, `seekToPrevious()`, `toggleShuffle()`, `cycleRepeatMode()`
  - `PlaybackStateSnapshot`: thêm `playlistSize`, `hasNext/Previous`, `shuffleEnabled`, `repeatMode`

### UI Layer
- `ui/player/PlayerActivity.kt`:
  - Binding 4 nút mới: `skipPreviousButton`, `skipNextButton`, `shuffleButton`, `repeatButton`
  - Click handlers với feedback Toast
  - `updatePlaylistControls()`: sync enabled/disabled state, alpha, icon theo state

### Tests
- `player/CxPlayerManagerTest.kt` — Update `FakePlayerSession` với các members mới

## Không cần migration / lệnh chạy thêm

Build: `.\gradlew.bat assembleDebug`  
Test: `.\gradlew.bat testDebugUnitTest`
