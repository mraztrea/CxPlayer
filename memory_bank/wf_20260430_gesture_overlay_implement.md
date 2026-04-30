# Workflow: Implement Gesture Overlay UI

## Scope

- Feature: `005-gesture-overlay-ui`
- Goal: triển khai task `2.8 Gesture overlay UI` theo artifacts Speckit đã tạo

## Files dự kiến chạm

- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureOverlayState.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/res/layout/activity_player.xml`
- `CxPlayer/app/src/main/res/drawable/bg_player_gesture_overlay.xml`
- `CxPlayer/app/src/main/res/values/strings.xml`
- `CxPlayer/app/src/main/res/values/dimens.xml`
- `CxPlayer/app/src/test/java/com/cxplayer/ui/player/PlayerActivityGestureOverlayTest.kt`
- `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- `specs/005-gesture-overlay-ui/tasks.md`

## Commands dự kiến dùng

```powershell
pwsh -NoProfile -Command "Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'; $env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'; .\gradlew.bat testDebugUnitTest --tests com.cxplayer.ui.player.PlayerActivityGestureOverlayTest"
pwsh -NoProfile -Command "Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'; $env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'; .\gradlew.bat compileDebugAndroidTestKotlin"
```

## Notes

- Không có migration database.
- Dự kiến dùng unit test trước để khóa formatter/state transition, sau đó mới nối UI và instrumentation.
- `connectedDebugAndroidTest` có thể vẫn bị chặn bởi prompt cài test app trên thiết bị thật.