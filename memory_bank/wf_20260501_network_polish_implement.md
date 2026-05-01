# Workflow: Network Polish Implement

## Mục tiêu

- Triển khai feature `specs/009-network-polish` theo `tasks.md`
- Ưu tiên hoàn thành theo phase: Setup -> Foundational -> US1 -> US2 -> US3 -> Polish

## Files dự kiến chạm

- `CxPlayer/gradle/libs.versions.toml`
- `CxPlayer/app/build.gradle.kts`
- `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/player/CxLoadControl.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/player/CxMediaSourceFactory.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/player/PlaybackService.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/data/datasource/CxDataSourceFactory.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/data/datasource/SmbDataSource.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/network/SmbBrowser.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/ui/controls/NetworkBrowserDialog.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/AndroidManifest.xml`
- `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- `CxPlayer/app/src/test/java/com/cxplayer/player/PlaybackRequestParserTest.kt`
- `CxPlayer/app/src/test/java/com/cxplayer/player/SmbBrowserContractTest.kt`
- `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`
- `specs/009-network-polish/tasks.md`

## Validation commands

```powershell
Set-Location 'd:\Projects\CaNhan\CxPlayer\CxPlayer'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.CxPlayerManagerTest
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.PlaybackRequestParserTest
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.SmbBrowserContractTest
.\gradlew.bat :app:compileDebugKotlin
.\gradlew.bat compileDebugAndroidTestKotlin
```

## Ghi chú

- Background audio yêu cầu dời ownership của player ra khỏi `PlayerActivity.onStop()`.
- Sau mỗi cụm task hoàn thành cần tick `[X]` trong `specs/009-network-polish/tasks.md`.
- Kết thúc feature phải cập nhật changelog marker trong `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`.