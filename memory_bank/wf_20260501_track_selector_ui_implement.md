# Workflow: Track Selector UI Implement

## Muc tieu

- Noi lai Track Selector UI vao `PlayerActivity`
- Tai su dung `TrackSelector.kt` va `TrackSelectorSessionController.kt` hien co
- Khong pha vo flow subtitle picker, subtitle style, va SMB browser da on dinh

## Files du kien cham

- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/res/layout/activity_player.xml`
- `CxPlayer/app/src/main/res/drawable/ic_player_track_selector.xml`
- `CxPlayer/app/src/main/res/values/strings.xml`
- `CxPlayer/app/src/androidTest/java/com/cxplayer/ui/player/PlayerActivityPlaybackTest.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`

## Validation commands

```powershell
Set-Location 'd:\Projects\CaNhan\CxPlayer\CxPlayer'
.\gradlew.bat :app:compileDebugKotlin
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.TrackSelectorSessionControllerTest --tests com.cxplayer.ui.controls.TrackSelectorTest
.\gradlew.bat connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.cxplayer.ui.player.PlayerActivityPlaybackTest
```

## Ghi chu

- Doi affordance tu `volumeButton` sang nut selector rieng de icon va content description khop voi chuc nang popup.
- Giu nguyen click va long-click hien co cua subtitle de tranh regression.
# Workflow: Track Selector UI Implement

## Scope

- Feature: `specs/008-track-selector-ui`
- Main seams: `PlayerActivity`, `CxPlayerManager`, `SubtitleManager`, new `TrackSelectorSessionController`, new `TrackSelector`

## Planned validation

- `pwsh -NoProfile -Command "Set-Location 'd:\Projects\CaNhan\CxPlayer\CxPlayer'; .\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.TrackSelectorSessionControllerTest"`
- `pwsh -NoProfile -Command "Set-Location 'd:\Projects\CaNhan\CxPlayer\CxPlayer'; .\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.SubtitleManagerTest"`
- `pwsh -NoProfile -Command "Set-Location 'd:\Projects\CaNhan\CxPlayer\CxPlayer'; .\gradlew.bat compileDebugAndroidTestKotlin"`

## Notes

- `.gitignore` ở repo root đã có các pattern Android/Kotlin thiết yếu (`.gradle/`, `**/build/`, `**/out/`, `*.class`, `*.jar`, `.idea/`, `.vscode/`, `.env*`), nên không cần bổ sung ở lượt này.
