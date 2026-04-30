# Workflow: Implement Player Lifecycle Management

## Scope

- Feature: `004-player-lifecycle`
- Goal: hoàn thành implementation cho `specs/004-player-lifecycle/tasks.md`

## Files dự kiến thay đổi

- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- `CxPlayer/app/src/main/res/values/strings.xml`
- `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt`
- `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- `specs/004-player-lifecycle/tasks.md`

## Verification Commands

```powershell
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat testDebugUnitTest --tests 'com.cxplayer.player.CxPlayerManagerTest' --tests 'com.cxplayer.ui.player.PlayerActivityLaunchParserTest'"
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest"
```

## Notes

- Không có migration database.
- `.gitignore` hiện tại đã bao phủ đủ pattern thiết yếu cho Kotlin/Gradle nên không cần chỉnh thêm ở workflow này.
- Manual verification cho foreground/background, recreate và clean exit cần device hoặc emulator Android sẵn sàng.
- `connectedDebugAndroidTest` hiện bị chặn trên thiết bị `V2405A - 16` do `INSTALL_FAILED_ABORTED: User rejected permissions`; cần mở khoá thiết bị và chấp nhận cài app test trước khi chạy lại T021.
