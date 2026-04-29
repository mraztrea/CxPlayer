# Quickstart: Player Launch Entry

## Mục tiêu

Xác minh nhanh rằng implementation của task `1.2`:

- thêm được `PlayerActivity` vào manifest
- nhận được `ACTION_VIEW` cho video source hợp lệ
- chuẩn hóa launch request đúng
- trả lỗi rõ ràng khi request không hợp lệ

## Build

```powershell
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat assembleDebug"
```

## Kiểm thử thủ công tối thiểu

### 1. Launcher vẫn mở được app

```powershell
rtk adb shell am start -n com.cxplayer/.MainActivity
```

Kỳ vọng:
- App vẫn mở bình thường từ launcher entry hiện tại.

### 2. Mở video HTTP bằng `ACTION_VIEW`

```powershell
rtk adb shell am start -a android.intent.action.VIEW -d "https://example.com/sample.mp4" com.cxplayer
```

Kỳ vọng:
- `PlayerActivity` được chọn làm điểm vào playback.
- Player flow nhận đúng URI HTTP và không tạo thêm stack player trùng lặp khi chạy lại lệnh.

### 3. Mở video file local trên thiết bị

```powershell
rtk adb shell am start -a android.intent.action.VIEW -d "file:///sdcard/Movies/sample.mp4" com.cxplayer
```

Kỳ vọng:
- Nếu file tồn tại và truy cập được, player mở đúng source.
- Nếu file không tồn tại, người dùng thấy lỗi rõ ràng và app không crash.

### 4. Mở source không hợp lệ

```powershell
rtk adb shell am start -a android.intent.action.VIEW -d "https://example.com/not-video.txt" com.cxplayer
```

Kỳ vọng:
- Intent không match vào player, hoặc player từ chối request sạch sẽ nếu request đã vào app.
- Không có blank screen hoặc crash.

## Kiểm thử nội bộ

Nếu implementation có tách parser/validator thành hàm thuần hoặc lớp nhỏ, chạy thêm unit test:

```powershell
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat testDebugUnitTest"
```

Nếu có instrumentation test cho intent launch:

```powershell
rtk pwsh -NoProfile -Command "Set-Location 'CxPlayer'; .\gradlew.bat connectedDebugAndroidTest"
```

## Ghi chú

- `https://example.com/sample.mp4` chỉ là placeholder; thay bằng URL video thật khi verify.
- Với `content://`, nên kiểm thử qua file manager hoặc app ngoài thật vì `adb am start` khó mô phỏng quyền truy cập tạm thời chính xác.
- Explicit launch hiện hỗ trợ các extra keys `extra_media_uris`, `extra_start_index`, và `extra_start_position_ms`.
- Ngày 2026-04-29 chưa có device/emulator attach trong môi trường shell, nên các bước `adb shell am start ...` mới được xác nhận ở mức tài liệu và chưa chạy end-to-end trên thiết bị.
