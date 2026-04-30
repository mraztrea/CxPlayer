# Workflow: FFmpeg Integration Implement

## Mục tiêu
- Triển khai task 3.1 FFmpeg Integration theo `specs/006-ffmpeg-integration/tasks.md`.

## Phạm vi code dự kiến
- `CxPlayer/gradle/libs.versions.toml`
- `CxPlayer/build.gradle.kts`
- `CxPlayer/settings.gradle.kts`
- `CxPlayer/app/build.gradle.kts`
- `CxPlayer/ffmpeg-extension/build.gradle.kts`
- `CxPlayer/ffmpeg-extension/src/main/AndroidManifest.xml`
- `CxPlayer/ffmpeg-extension/src/main/java/androidx/media3/decoder/ffmpeg/*.java`
- `CxPlayer/ffmpeg-extension/src/main/java/com/google/android/exoplayer2/ext/ffmpeg/*.java`
- `CxPlayer/app/src/main/java/com/cxplayer/player/CxRenderersFactory.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- `CxPlayer/app/src/test/java/com/cxplayer/player/CxPlayerManagerTest.kt`
- `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`

## Validation dự kiến
```powershell
Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.CxPlayerManagerTest
.\gradlew.bat assembleDebug
.\gradlew.bat compileDebugAndroidTestKotlin
```

## Ghi chú
- `connectedDebugAndroidTest` có thể bị chặn bởi prompt cài test app trên thiết bị thật.
- Local FFmpeg extension sẽ dùng lại native `.so` từ `video_player_module/native_libs` qua một Android library module mới.
- Không có migrate database hay lệnh dữ liệu bổ sung trong feature này.
