# Workflow: Implement Playback Screen Layout

## Scope

- Feature: `003-player-layout`
- Goal: hoàn thành implementation cho `1.4 Layout` theo `specs/003-player-layout/tasks.md`

## Files dự kiến thay đổi

- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/res/layout/activity_player.xml`
- `CxPlayer/app/src/main/res/values/colors.xml`
- `CxPlayer/app/src/main/res/values/strings.xml`
- `CxPlayer/app/src/main/res/values/dimens.xml`
- `CxPlayer/app/src/main/res/drawable/*.xml`
- `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- `specs/003-player-layout/tasks.md`

## Verification Commands

```powershell
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat :app:compileDebugKotlin :app:compileDebugAndroidTestKotlin"
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat testDebugUnitTest"
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat connectedDebugAndroidTest"
```

## Notes

- Không có migration database.
- `.gitignore` hiện tại đã bao phủ đủ pattern Kotlin/Android thiết yếu, nên không cần bổ sung ignore file mới cho phase này.