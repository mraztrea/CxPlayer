# Workflow: Subtitle Manager Implement

- Ngày: 2026-05-01
- Feature: `specs/007-subtitle-manager`
- Mục tiêu: triển khai subtitle manager cho external subtitle, auto-detect, embedded selection và subtitle styling.

## Plan thực thi

1. Phase 1: tạo shell `SubtitleManager`, test fixture và strings subtitle.
2. Phase 2: mở seam internal từ `CxPlayerManager` và wiring tối thiểu trong `PlayerActivity`.
3. US1: nạp phụ đề ngoài + auto-detect cho local file.
4. US2: embedded subtitle selection và trạng thái `Off`.
5. US3: subtitle style runtime.
6. Polish: chạy unit test, compile androidTest, assembleDebug và cập nhật `tasks.md`.

## Lệnh validation dự kiến

```powershell
Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.SubtitleManagerTest
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.CxPlayerManagerTest
.\gradlew.bat compileDebugAndroidTestKotlin
.\gradlew.bat assembleDebug
```

## Kết quả triển khai

- `SubtitleManager` đã hỗ trợ auto-detect subtitle local cùng basename, attach external subtitle, chọn embedded subtitle, tắt subtitle và apply style runtime.
- `PlayerActivity` đã nối subtitle picker, cycle source, style preset, preserve off-state và restore style preset qua recreate.
- `CxPlayerManager` expose seam internal cho subtitle session controller mà không mở public API mới.

## Validation đã chạy

```powershell
Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot'
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.SubtitleManagerTest
.\gradlew.bat testDebugUnitTest --tests com.cxplayer.player.CxPlayerManagerTest
.\gradlew.bat compileDebugAndroidTestKotlin
.\gradlew.bat assembleDebug
```

## Ghi chú thực thi

- Host-side JVM tests không nên dùng `MediaItem.fromUri`, `Uri.parse`, `Format.Builder` hoặc primitive Media3 kéo vào Android mocked APIs.
- Với embedded subtitle selection trong unit tests, seam theo `groupIndex`/`trackIndex` rẻ và ổn định hơn so với dựng `TrackGroup` thật.
- Manual verification matrix trong `specs/007-subtitle-manager/quickstart.md` vẫn cần chạy riêng trên sample media thật.