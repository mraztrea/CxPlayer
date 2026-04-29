# Workflow: Implement PlayerActivity Launch Entry

## Scope

- Feature: `001-player-activity`
- Goal: hoàn thành implementation cho `PlayerActivity` launch entry theo `specs/001-player-activity/tasks.md`

## Files dự kiến thay đổi

- `CxPlayer/app/src/main/AndroidManifest.xml`
- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/res/layout/activity_player.xml`
- `CxPlayer/app/src/main/res/values/strings.xml`
- `CxPlayer/app/src/main/res/values/themes.xml`
- `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt`
- `specs/001-player-activity/tasks.md`

## Verification Commands

```powershell
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat testDebugUnitTest"
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat assembleDebug"
```

## Notes

- Không có migration database.
- Manual verification qua `adb shell am start` chỉ thực hiện được nếu có device/emulator sẵn.
