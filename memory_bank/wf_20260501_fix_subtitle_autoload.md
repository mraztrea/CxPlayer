# Workflow: Sửa lỗi autoload phụ đề ngoài

**Ngày**: 2026-05-01  
**Trạng thái**: ✅ Hoàn thành

## Mô tả vấn đề

Khi mở video (ví dụ: `wma.mp4`), file phụ đề bên ngoài cùng thư mục (`wma.srt`) không được tự động phát hiện và hiển thị trong popup Track Selector. Popup chỉ hiện mục "Subtitle" với option "Off".

## Root cause

1. **`File.listFiles()` trả null trên Android scoped storage**: Trên Android 10+, dù app có `MANAGE_EXTERNAL_STORAGE`, `File.listFiles()` có thể thất bại nếu user chưa grant "All files access" hoặc SAF chưa cho quyền.
2. **MediaStore fallback không index subtitle files**: `querySiblingsFromMediaStore()` query `MediaStore.Files` nhưng MediaStore thường không index các file `.srt`, `.ass`, `.ssa`, `.vtt`.
3. **`Uri.fromFile()` crash JUnit test**: Method này cần Android runtime, gây crash khi test trên JVM.

## Thay đổi

### `SubtitleManager.kt`
- **Thêm fallback `probeSubtitleFilesByPattern()`**: Khi cả `listFiles()` lẫn MediaStore đều thất bại, probe trực tiếp bằng `File.exists()` cho từng pattern:
  - Exact: `{videoBaseName}.srt`, `.ass`, `.ssa`, `.vtt`
  - Language-tagged: `{videoBaseName}.{lang}.srt`, etc. (16 lang codes phổ biến)
- **Sửa `syncDetectedExternalSubtitleSources`**: Thay `Uri.fromFile()` bằng string construction `"file://$path"` để JUnit host-side tests có thể chạy.

### `MainActivity.kt`
- Update changelog string.

## Files thay đổi

- `CxPlayer/app/src/main/java/com/cxplayer/player/SubtitleManager.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`

## Kiểm tra

```powershell
# Build
cd CxPlayer
.\gradlew.bat assembleDebug

# Test
.\gradlew.bat :app:testDebugUnitTest --tests "com.cxplayer.player.SubtitleManagerTest"
```

## Lưu ý

- Đảm bảo app đã được grant quyền "All files access" trên Android 11+.
- Probe fallback chỉ kiểm tra 16 language codes phổ biến. Nếu cần thêm, sửa list `commonLanguageCodes` trong `probeSubtitleFilesByPattern()`.
- HTTP/HTTPS (LAN) URIs hiện vẫn trả `UnsupportedSource` cho auto-detect (cần implement riêng probe HTTP subtitle URLs nếu muốn).
