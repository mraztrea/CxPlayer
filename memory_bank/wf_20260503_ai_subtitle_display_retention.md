# Workflow 2026-05-03 - AI subtitle display retention

## Muc tieu

Sua loi phu de AI dich bi mat qua nhanh:

- Khong de snapshot moi khong co noi dung nhin thay de len subtitle dang hien thi.
- Giu subtitle hien tai cho toi khi subtitle tiep theo thuc su hien thi trong mode dang xem.

## File chinh da sua

- `CxPlayer/app/src/main/java/com/cxplayer/subtitle/AiSubtitleManager.kt`
- `CxPlayer/app/src/test/java/com/cxplayer/subtitle/AiSubtitleManagerTest.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`

## Thay doi ky thuat

- Them guard trong `AiSubtitleManager.emitPendingSnapshotIfDue()` de bo qua snapshot moi neu snapshot do khong co noi dung nhin thay trong `SubtitleDisplayMode` hien tai, trong khi subtitle truoc do van co noi dung dang hien.
- Them unit test bao ve case `TRANSLATION_ONLY`: subtitle dich cu phai duoc giu lai khi chunk moi chi moi co provisional original va chua co translation.
- Cap nhat dong changelog bat buoc trong `MainActivity.kt`.

## Lenh verify da dung

```powershell
rtk pwsh -NoProfile -Command "Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'; .\gradlew.bat app:testDebugUnitTest --tests 'com.cxplayer.subtitle.AiSubtitleManagerTest'"
```

## Ghi chu

- Khong co migration database.
- Chua chay full build; chi verify bang unit test lien quan den scope bugfix nay.
