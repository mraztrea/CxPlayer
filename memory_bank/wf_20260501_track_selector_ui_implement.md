
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
