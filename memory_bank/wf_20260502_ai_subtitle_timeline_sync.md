# Workflow 2026-05-02 - AI subtitle timeline sync

## Muc tieu

Sua B1 cho AI subtitle:

- Giu nguyen luong gui audio hien tai.
- Khong lam prefetch audio tuong lai.
- Chi hien thi subtitle khi playback position da toi `startMs` cua chunk tu Soniox.

## File chinh da sua

- `CxPlayer/app/src/main/java/com/cxplayer/data/model/SubtitleEvent.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/subtitle/AiSubtitleManager.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/test/java/com/cxplayer/subtitle/AiSubtitleManagerTest.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`

## Thay doi ky thuat

- Them `startPositionMs` va `endPositionMs` vao `SubtitleEvent.Snapshot`.
- Doi `AiSubtitleManager` sang giu pending snapshot va chi emit khi `updatePlaybackPosition()` bao playhead da toi moc subtitle.
- Doi timing SRT tu `System.currentTimeMillis()` sang moc `startMs/endMs` cua Soniox khi co du lieu.
- Them polling nhe trong `PlayerActivity` de day current playback position vao `AiSubtitleManager` moi `50ms`.
- Them unit test bao ve hanh vi subtitle den som nhung chi render khi toi `startMs`.

## Lenh verify da dung

```powershell
rtk pwsh -NoProfile -Command "Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'; .\gradlew.bat testDebugUnitTest --tests com.cxplayer.subtitle.AiSubtitleManagerTest"
rtk pwsh -NoProfile -Command "Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'; .\gradlew.bat testDebugUnitTest --tests com.cxplayer.subtitle.AiSubtitleManagerTest --tests com.cxplayer.player.SubtitleManagerTest"
```

## Ghi chu

- Ban sua nay chua lam prefetch audio 2 giay.
- Khi seek lui xa, AI subtitle live van khong co co che replay subtitle cu. Day la gioi han scope B1 da chot.
