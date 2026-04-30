# UI Contract: Gesture Overlay UI

## Purpose

Tài liệu này mô tả contract hiển thị giữa runtime gesture callbacks của màn hình phát và lớp overlay nổi dùng để phản hồi cho người dùng. Contract này dùng cho planning, implementation và validation của task 2.8.

## Surface

- Màn hình áp dụng: `PlayerActivity`
- Vùng hiển thị: một overlay card duy nhất nằm trên `PlayerView`
- Input contract: callback gesture đã tồn tại từ `GestureController` và trạng thái runtime của playback hoặc device do `PlayerActivity` sở hữu
- Output contract: một trạng thái overlay visible duy nhất hoặc không overlay nào visible

## Supported Overlay Types

| Overlay Type | Trigger | Required Content | Visibility Rule |
|--------------|---------|------------------|-----------------|
| Volume | Vuốt dọc nửa phải | Cue âm lượng + phần trăm hiện tại | Hiện ngay khi volume gesture được nhận diện; cập nhật tại chỗ khi tiếp tục vuốt |
| Brightness | Vuốt dọc nửa trái | Cue độ sáng + phần trăm hiện tại | Hiện ngay khi brightness gesture được nhận diện; cập nhật tại chỗ khi tiếp tục vuốt |
| SeekDelta | Vuốt ngang | Cue hướng tua + delta thời gian có dấu | Hiện ngay khi seek gesture được nhận diện; cập nhật theo delta mới nhất |
| FastForward | Nhấn giữ hợp lệ | Thông điệp tua nhanh `2X` | Hiện suốt thời gian long press còn hiệu lực; ẩn khi release hoặc cancel |

## Presentation Rules

1. Hệ thống chỉ được có một overlay card visible tại mọi thời điểm.
2. Overlay mới phải thay thế nội dung overlay cũ nếu gesture kế tiếp đến trước khi overlay cũ tự ẩn.
3. Overlay không được chặn các thao tác gesture tiếp theo trên `PlayerView`.
4. Overlay phải đủ tương phản để đọc được trên nền video sáng hoặc tối.
5. Overlay phải phản ánh giá trị thực đã clamp ở biên tối đa hoặc tối thiểu, không hiển thị giá trị vượt phạm vi.

## Timing Contract

| Event | Requirement |
|-------|-------------|
| Show on recognized gesture | Không quá 200ms kể từ khi gesture hỗ trợ được nhận diện |
| Update while same gesture continues | Không dựng overlay thứ hai; chỉ thay nội dung hoặc giá trị của overlay hiện tại |
| Auto-dismiss after gesture end | Không quá 1000ms nếu không có gesture hỗ trợ khác tiếp quản |
| Immediate cleanup on lifecycle end | Overlay phải bị gỡ ngay khi activity cleanup hoặc view hierarchy bị giải phóng |

## Content Format Contract

| Overlay Type | Value Format |
|--------------|--------------|
| Volume | Phần trăm nguyên hoặc dễ đọc, ví dụ `75%` |
| Brightness | Phần trăm nguyên hoặc dễ đọc, ví dụ `60%` |
| SeekDelta | Delta có dấu với định dạng thời gian ngắn, ví dụ `+00:30` hoặc `-00:30` |
| FastForward | Chuỗi cố định `2X` hoặc nội dung tương đương thể hiện rõ tốc độ tạm thời |

## Non-Goals

- Không bao gồm feedback overlay cho double tap play/pause hoặc seek ±10 giây.
- Không bao gồm feedback overlay cho pinch zoom.
- Không bao gồm speed selector, aspect ratio hoặc repeat mode.

## Validation Mapping

| Scenario | Expected Contract Result |
|----------|--------------------------|
| Vuốt volume liên tiếp | Cùng một overlay volume còn visible, giá trị phần trăm tăng hoặc giảm theo trạng thái hiện tại |
| Vuốt brightness rồi chuyển sang seek ngay | Overlay brightness bị thay tại chỗ bằng overlay seek, không chồng hai card |
| Nhấn giữ kích hoạt 2x rồi thả | Overlay fast-forward visible trong lúc giữ và biến mất trong cửa sổ tự ẩn sau release |
| Gesture bị hủy do lifecycle hoặc cancel | Overlay bị cleanup ngay, không còn card cũ trên màn hình |