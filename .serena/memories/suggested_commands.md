Use RTK prefix for shell commands in this repo. Common commands on Windows PowerShell:
- `rtk git status`
- `rtk rg --files CxPlayer`
- `rtk pwsh -NoProfile -Command "Get-Content -Raw '_docs/plans/phase-1-core-player.md'"`
- `rtk pwsh -NoProfile -Command "cd CxPlayer; .\gradlew.bat tasks"`
- `rtk pwsh -NoProfile -Command "cd CxPlayer; .\gradlew.bat assembleDebug"`
- `rtk pwsh -NoProfile -Command "cd CxPlayer; .\gradlew.bat testDebugUnitTest"`
- `rtk pwsh -NoProfile -Command "cd CxPlayer; .\gradlew.bat connectedDebugAndroidTest"`
Android Studio can also be used for Sync and Run per _docs/setup-guide.md.