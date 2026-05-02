# Workflow: PlayerActivity Merge Fix

## Mục tiêu

Sửa lỗi compile sau merge:

`Unresolved reference 'playerSettingsButton'` tại `PlayerActivity.kt`.

## Root cause

- Layout `activity_player.xml` hiện dùng `playerOverflowButton`.
- `PlayerActivity.kt` vẫn còn field `settingsButton` và dòng bind `binding.playerSettingsButton` từ nhánh cũ.
- Symbol này không còn tồn tại trong ViewBinding nên compile fail.

## File đã sửa

- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`

## Cách sửa

- Xóa field `settingsButton` không còn dùng.
- Xóa dòng bind `settingsButton = binding.playerSettingsButton`.
- Giữ nguyên flow settings hiện tại qua `overflowButton` và `showOverflowMenu()`.

## Verify

- Chạy:
  - `rtk pwsh -NoProfile -Command "Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'; .\gradlew.bat :app:compileDebugKotlin --console=plain --no-daemon"`

## Ghi chú

- Không cần migrate database.
- Đây là fix conflict merge, phạm vi hẹp trong `PlayerActivity`.
