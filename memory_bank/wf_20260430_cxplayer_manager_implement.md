# Workflow: Implement Playback Session Manager

## Scope

- Feature: `002-cxplayer-manager`
- Goal: hoàn thành implementation cho `CxPlayerManager` theo `specs/002-cxplayer-manager/tasks.md`

## Files dự kiến thay đổi

- `CxPlayer/app/build.gradle.kts`
- `CxPlayer/app/src/main/AndroidManifest.xml`
- `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityLaunchParserTest.kt`
- `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- `CxPlayer/gradle/libs.versions.toml`
- `specs/002-cxplayer-manager/tasks.md`

## Verification Commands

```powershell
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat testDebugUnitTest"
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat connectedDebugAndroidTest"
```

## Notes

- Không có migration database.
- Manual verification cho local file và HTTP launch cần device/emulator sẵn sàng.