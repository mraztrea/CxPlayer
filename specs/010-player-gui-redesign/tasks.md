# Tasks: Player GUI Redesign

**Input**: Design documents from `specs/010-player-gui-redesign/`
**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md, quickstart.md

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Android app**: `CxPlayer/app/src/main/` at repository root
- **Source**: `java/com/cxplayer/`
- **Resources**: `res/layout/`, `res/drawable/`, `res/values/`, `res/menu/`

---

## Phase 1: Setup (Drawable Resources)

**Purpose**: Tạo tất cả icon drawable mới cần thiết cho function row buttons

- [x] T001 [P] Tạo icon vector drawable `ic_player_lock.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_lock.xml` (Material icon: lock outline, 24dp, white)
- [x] T002 [P] Tạo icon vector drawable `ic_player_unlock.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_unlock.xml` (Material icon: lock open outline, 24dp, white)
- [x] T003 [P] Tạo icon vector drawable `ic_player_rotate.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_rotate.xml` (Material icon: screen rotation, 24dp, white)
- [x] T004 [P] Tạo icon vector drawable `ic_player_subtitle.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_subtitle.xml` (Material icon: subtitles, 24dp, white)
- [x] T005 [P] Tạo icon vector drawable `ic_player_subtitle_off.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_subtitle_off.xml` (Material icon: subtitles off, 24dp, white)
- [x] T006 [P] Tạo icon vector drawable `ic_player_resize_fit.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_resize_fit.xml` (Material icon: fit screen, 24dp, white)
- [x] T007 [P] Tạo icon vector drawable `ic_player_resize_fill.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_resize_fill.xml` (Material icon: crop free, 24dp, white)
- [x] T008 [P] Tạo icon vector drawable `ic_player_resize_zoom.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_resize_zoom.xml` (Material icon: zoom out map, 24dp, white)
- [x] T009 [P] Tạo icon vector drawable `ic_player_autoplay.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_autoplay.xml` (Material icon: playlist play, 24dp, white)
- [x] T010 [P] Tạo icon vector drawable `ic_player_autoplay_off.xml` trong `CxPlayer/app/src/main/res/drawable/ic_player_autoplay_off.xml` (Material icon: playlist remove, 24dp, white)

---

## Phase 2: Foundational (String & Dimen Resources + Overflow Menu)

**Purpose**: Thêm string resources, dimension resources, và overflow menu cần thiết cho tất cả user stories

**⚠️ CRITICAL**: Layout và code phụ thuộc vào resources này

- [x] T011 Thêm string resources cho function row buttons (content descriptions + labels) trong `CxPlayer/app/src/main/res/values/strings.xml`: `player_lock_content_description`, `player_unlock_content_description`, `player_rotate_content_description`, `player_subtitle_content_description`, `player_resize_content_description`, `player_autoplay_content_description`, `player_resize_fit_label`, `player_resize_fill_label`, `player_resize_zoom_label`, `player_speed_content_description`, `player_no_subtitle_message`
- [x] T012 Thêm dimension resources cho function row trong `CxPlayer/app/src/main/res/values/dimens.xml`: `player_function_row_height` (48dp), `player_function_button_size` (40dp), `player_function_button_padding` (8dp), `player_function_button_spacing` (4dp), `player_function_row_margin_top` (4dp)
- [x] T013 [P] Tạo overflow menu resource `CxPlayer/app/src/main/res/menu/player_overflow.xml` với item Settings (id: `action_player_settings`, icon: `ic_player_settings`, title từ string resource)
- [x] T014 [P] Tạo string array resource `player_speed_options` trong `CxPlayer/app/src/main/res/values/strings.xml` với giá trị: "0.25x", "0.5x", "0.75x", "1.0x", "1.25x", "1.5x", "2.0x"

**Checkpoint**: Tất cả resources sẵn sàng — layout và code có thể tham chiếu

---

## Phase 3: User Story 1+2 — Bố cục 2 vùng Chrome + Function Row (Priority: P1) 🎯 MVP

**Goal**: Redesign layout activity_player.xml thêm function row vào Bottom Chrome, chuyển Settings sang overflow menu, giữ Repeat trên transport row

**Independent Test**: Mở player → thấy function row 8 nút giữa seekbar và transport row, overflow menu hoạt động

### Implementation for User Story 1+2

- [x] T015 Sửa layout Bottom Chrome thêm function row (HorizontalScrollView → LinearLayout) giữa timeline row và transport row trong `CxPlayer/app/src/main/res/layout/activity_player.xml`. Function row chứa 8 ImageButton theo thứ tự: Lock (playerLockButton), Subtitle (playerSubtitleButton), Resize (playerResizeButton), Rotate (playerRotateButton), Audio (playerAudioTrackButton), Speed spinner (playerSpeedSpinner), Shuffle (playerShuffleButton — di chuyển từ transport row), Auto-play (playerAutoPlayButton). Thêm nút Unlock (playerUnlockButton, visibility=gone) ở vị trí center của playerRoot
- [x] T016 Sửa transport row trong `CxPlayer/app/src/main/res/layout/activity_player.xml`: loại bỏ playerShuffleButton (đã chuyển lên function row), loại bỏ playerSettingsButton (chuyển vào overflow), giữ nguyên: SkipPrevious, SeekBack, PlayPause, SeekForward, SkipNext, Repeat, TrackSelector
- [x] T017 Thêm logic inflate overflow menu vào PlayerActivity: trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`, sửa `playerOverflowButton` click handler để inflate `R.menu.player_overflow` qua PopupMenu, xử lý `action_player_settings` item click
- [x] T018 Thêm logic auto-hide chrome trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`: sử dụng Handler + postDelayed(5000ms) để ẩn Top Chrome và Bottom Chrome, reset timer khi user tương tác, toggle visibility khi tap vào playerView

**Checkpoint**: Mở player → thấy bố cục mới với function row 8 nút, overflow menu hoạt động, chrome auto-hide sau 5 giây

---

## Phase 4: User Story 3 — Lock Screen Mode (Priority: P2)

**Goal**: Nút Lock ẩn toàn bộ UI, chỉ giữ nút Unlock, vô hiệu hóa gesture

**Independent Test**: Nhấn Lock → tất cả ẩn, chỉ Unlock hiện, gesture bị block. Nhấn Unlock → khôi phục.

### Implementation for User Story 3

- [x] T019 [US3] Thêm state `isLocked: Boolean` và methods `lockScreen()` / `unlockScreen()` vào `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`. `lockScreen()`: ẩn topChrome, bottomChrome, hiện unlockButton, set auto-hide timeout = 3000ms. `unlockScreen()`: hiện lại tất cả, ẩn unlockButton, reset timeout = 5000ms
- [x] T020 [US3] Gắn click listener cho `playerLockButton` (gọi `lockScreen()`) và `playerUnlockButton` (gọi `unlockScreen()`) trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [x] T021 [US3] Thêm check `isLocked` vào `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt`: nếu `isLocked == true`, block tất cả gesture (brightness, volume, seek, double-tap). Expose property `isLocked` để PlayerActivity set

**Checkpoint**: Lock/Unlock hoạt động đúng, gesture bị block khi lock

---

## Phase 5: User Story 4 — Resize Mode Toggle (Priority: P2)

**Goal**: Nút Resize chuyển vòng Fit→Fill→Zoom→Fit, cập nhật icon + hiện label 1 giây

**Independent Test**: Nhấn Resize 3 lần → video thay đổi chế độ, icon thay đổi, label hiện rồi tự ẩn

### Implementation for User Story 4

- [x] T022 [US4] Tạo enum `ResizeMode` với 3 giá trị (FIT, FILL, ZOOM), mỗi giá trị kèm `media3Value: Int`, `iconRes: Int`, `labelRes: Int`, và method `next(): ResizeMode` trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` (companion hoặc top-level enum)
- [x] T023 [US4] Thêm logic toggle resize mode trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`: click `playerResizeButton` → cycle `currentResizeMode.next()`, gọi `playerView.setResizeMode(mode.media3Value)`, cập nhật icon `playerResizeButton.setImageResource(mode.iconRes)`, hiện label text tạm thời 1 giây bằng overlay TextView (sử dụng `playerGestureOverlayCueView` hiện có)

**Checkpoint**: Resize toggle hoạt động, icon + label cập nhật chính xác

---

## Phase 6: User Story 5 — Screen Rotation Toggle (Priority: P2)

**Goal**: Nút Rotate toggle landscape/portrait, tích hợp auto-rotate sensor

**Independent Test**: Nhấn Rotate → màn hình xoay đúng hướng

### Implementation for User Story 5

- [x] T024 [US5] Thêm logic rotation toggle trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`: click `playerRotateButton` → kiểm tra orientation hiện tại, gọi `requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE/PORTRAIT`. Nếu auto-rotate đang bật (kiểm tra `Settings.System.getInt(contentResolver, "accelerometer_rotation")`), sử dụng OrientationEventListener để reset về `SCREEN_ORIENTATION_UNSPECIFIED` sau khi user xoay thiết bị đúng hướng

**Checkpoint**: Rotation toggle hoạt động, tương thích auto-rotate sensor

---

## Phase 7: User Story 6 — Playback Speed Dropdown (Priority: P3)

**Goal**: Speed spinner cho phép chọn tốc độ phát, lưu preference

**Independent Test**: Chọn 2.0x → video phát gấp đôi, thoát mở lại → vẫn 2.0x

### Implementation for User Story 6

- [x] T025 [US6] Thêm logic cho `playerSpeedSpinner` (Spinner widget) trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`: tạo ArrayAdapter từ `player_speed_options` string array, set default selection = index of 1.0x (index 3). OnItemSelectedListener → parse speed float, gọi `player.setPlaybackParameters(PlaybackParameters(speed))`. Lưu preference vào SharedPreferences key `player_playback_speed`, restore khi khởi tạo

**Checkpoint**: Speed dropdown hoạt động, preference được lưu/restore

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Tích hợp cuối, xử lý edge cases

- [x] T026 Gắn click listeners cho các nút còn lại trên function row: `playerSubtitleButton` (gọi SubtitleManager toggle/popup logic hiện có), `playerAudioTrackButton` (gọi TrackSelector popup hiện có), `playerAutoPlayButton` (toggle icon autoplay/autoplay_off + lưu preference) trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- [ ] T027 Xử lý edge cases trong `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`: disable nút Subtitle khi không có subtitle track, disable Next/Previous khi playlist chỉ 1 video, hardware volume vẫn hoạt động khi lock screen
- [x] T028 Cập nhật changelog trong `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt` dòng greeting thành `[FEATURE]: Player GUI redesign - function row, lock screen, resize mode, rotation, speed - 2026-05-02`
- [ ] T029 Chạy verification theo `specs/010-player-gui-redesign/quickstart.md`: build project, cài đặt APK, kiểm tra 6 test cases thủ công

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — tạo drawable icons
- **Foundational (Phase 2)**: No dependencies — tạo string/dimen/menu resources
- **US1+2 Layout (Phase 3)**: Depends on Phase 1 + Phase 2 (layout tham chiếu drawable + string resources)
- **US3 Lock (Phase 4)**: Depends on Phase 3 (cần layout với lock/unlock buttons)
- **US4 Resize (Phase 5)**: Depends on Phase 3 (cần layout với resize button)
- **US5 Rotation (Phase 6)**: Depends on Phase 3 (cần layout với rotate button)
- **US6 Speed (Phase 7)**: Depends on Phase 3 (cần layout với speed spinner)
- **Polish (Phase 8)**: Depends on Phase 3-7

### User Story Dependencies

- **US1+2 (P1)**: Can start after Phase 1+2 — foundation for everything
- **US3 Lock (P2)**: Can start after US1+2 — independent feature
- **US4 Resize (P2)**: Can start after US1+2 — independent feature, can parallel with US3
- **US5 Rotation (P2)**: Can start after US1+2 — independent feature, can parallel with US3/US4
- **US6 Speed (P3)**: Can start after US1+2 — independent feature, can parallel with US3/US4/US5

### Parallel Opportunities

- Phase 1: ALL 10 tasks (T001-T010) can run in parallel (different files)
- Phase 2: T013 + T014 can run in parallel (different resources)
- After Phase 3: US3, US4, US5, US6 can ALL run in parallel (different logic, no file conflicts)

---

## Parallel Example: Phase 1 (Drawables)

```
# Tất cả 10 drawable tasks chạy song song:
Task T001: ic_player_lock.xml
Task T002: ic_player_unlock.xml
Task T003: ic_player_rotate.xml
... (tất cả file khác nhau)
```

## Parallel Example: After Phase 3 (User Stories)

```
# Sau khi layout xong, 4 user stories chạy song song:
Developer A: T019-T021 (Lock Screen)
Developer B: T022-T023 (Resize Mode)
Developer C: T024 (Rotation)
Developer D: T025 (Speed)
```

---

## Implementation Strategy

### MVP First (US1+2 Layout Only)

1. Complete Phase 1: Drawables (T001-T010)
2. Complete Phase 2: Resources (T011-T014)
3. Complete Phase 3: Layout + Auto-hide (T015-T018)
4. **STOP and VALIDATE**: Bố cục mới hiển thị đúng, overflow menu hoạt động
5. Deploy test build

### Incremental Delivery

1. Phase 1+2+3 → Layout redesign MVP → Test
2. + Phase 4 (Lock) → Test lock/unlock → Deploy
3. + Phase 5 (Resize) → Test resize cycle → Deploy
4. + Phase 6 (Rotation) → Test rotate → Deploy
5. + Phase 7 (Speed) → Test speed dropdown → Deploy
6. Phase 8 (Polish) → Final validation → Release

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Phase 1 drawables dùng Material Icons vector paths (không cần download — copy pathData từ Material Symbols)
- Tất cả changes trong `PlayerActivity.kt` nên sử dụng existing patterns (view binding, click listeners)
- Commit sau mỗi phase hoàn thành
