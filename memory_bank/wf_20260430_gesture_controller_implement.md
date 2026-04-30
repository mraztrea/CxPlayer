# Workflow: Gesture Controller Implement

## Phạm vi

- Đồng bộ implementation gesture playback với spec `specs/004-gesture-controller/`
- Ưu tiên đóng các gap cục bộ giữa `GestureController`, test unit, test instrumentation, và `tasks.md`

## Lệnh cần chạy

Từ thư mục `CxPlayer/`:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.ui.player.GestureControllerTest
.\gradlew.bat compileDebugAndroidTestKotlin
.\gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest
```

## Ghi chú

- Nếu `connectedDebugAndroidTest` gặp `INSTALL_FAILED_ABORTED`, cần mở thiết bị và chấp nhận prompt cài test app rồi chạy lại.
- Không có migration database trong workflow này.# Workflow: Gesture Controller Implement

## Mục tiêu

Triển khai task 2.1 GestureController cho màn hình player theo Spec Kit feature `specs/004-gesture-controller`.

## Phạm vi file dự kiến

- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/GestureController.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/player/CxPlayerManager.kt`
- `CxPlayer/app/src/test/java/com/cxplayer/ui/player/GestureControllerTest.kt`
- `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- `specs/004-gesture-controller/tasks.md`

## Lệnh validation dự kiến

Từ thư mục `CxPlayer/`:

```powershell
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.ui.player.GestureControllerTest
.\gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest
```

## Ghi chú

- Không có migrate database.
- Tách validation thành host-side test trước, instrumentation test sau.
- Long press 2x dự kiến cần mở rộng API playback speed trong `CxPlayerManager`.