# Contract: Player Screen Layout

## Purpose

Định nghĩa contract UI cho màn hình player fullscreen ở task 1.4, bao gồm các region bắt buộc, thứ tự control, fallback hiển thị và các hook ổn định để automation/test có thể dựa vào.

## Required Regions

### Video Region

- **Purpose**: hiển thị nội dung video ở vai trò vùng chiếm ưu thế.
- **Required element**: `playerView`
- **Rule**: luôn fill phần diện tích chính của màn hình và nằm dưới các lớp overlay control.

### Top Region

- **Purpose**: cung cấp điều hướng và ngữ cảnh nội dung.
- **Required elements**:
  - `playerBackButton`
  - `playerTitleView`
  - `playerOverflowButton`
- **Rules**:
  - Back button luôn có thể truy cập được khi chrome hiển thị.
  - Title có thể truncate hoặc fallback nhưng không được đẩy mất back/overflow.
  - Region này phải nhận top system inset thay vì để control chui xuống dưới status bar.

### Timeline Region

- **Purpose**: hiển thị tiến trình phát và mốc thời gian.
- **Required elements**:
  - `playerCurrentTimeView`
  - `playerSeekBar`
  - `playerDurationView`
- **Rules**:
  - Thứ tự hiển thị từ trái sang phải là current time, seek bar, duration.
  - Khi chưa có duration, region vẫn giữ layout ổn định bằng placeholder hoặc giá trị mặc định không làm dịch chuyển control khác.

### Transport Region

- **Purpose**: cho phép thao tác phát cơ bản.
- **Required elements**:
  - `playerSeekBackButton`
  - `playerPlayPauseButton`
  - `playerSeekForwardButton`
  - `playerVolumeButton`
  - `playerSettingsButton`
- **Rules**:
  - Thứ tự trái sang phải phải giữ cố định như danh sách trên.
  - `playerPlayPauseButton` là control trọng tâm và phải còn nhìn thấy trong mọi profile hỗ trợ.
  - Region này phải nhận bottom system inset để tránh nằm dưới navigation bar hoặc gesture area.

## Visibility and Fallback Rules

- Khi chrome hiển thị, cả top region và bottom region đều phải còn trong viewport.
- Khi title thiếu, `playerTitleView` dùng fallback text trung tính thay vì để rỗng hoàn toàn.
- Khi overflow action chưa có nội dung cụ thể, `playerOverflowButton` vẫn có thể hiện diện như điểm vào ổn định hoặc bị ẩn có chủ đích; không để chừa khoảng trống làm vỡ layout.
- Khi timeline chưa sẵn sàng, `playerSeekBar` có thể disabled nhưng vẫn phải giữ chỗ trong layout.

## Orientation and Insets Contract

- Layout phải hỗ trợ ít nhất hai profile: portrait và landscape trên điện thoại Android từ minSdk 24.
- Video region không bị inset toàn cục chỉ để tránh system bars; chỉ top/bottom overlay container nhận inset tương ứng.
- Chuyển orientation không được làm mất id, không đổi thứ tự control và không làm control rơi khỏi vùng nhìn thấy.

## Accessibility and Automation Hooks

- Mỗi interactive element trong top/transport region phải có content description hoặc text có nghĩa.
- View id nêu trong contract này là id ổn định để instrumentation tests và các task kế tiếp dựa vào.
- Layout phải cho phép kiểm thử tối thiểu các điều kiện sau:
  - top region hiện diện sau launch
  - transport region hiện diện sau launch
  - timeline region còn nhìn thấy sau recreate/orientation change

## Compatibility Notes

- Contract này chỉ bao phủ Phase 1 core player trên điện thoại; chưa cam kết layout chuyên biệt cho tablet, TV hoặc multi-window.
- Contract chỉ mô tả bố cục và surface interaction. Hành vi chi tiết của play/pause, seek bar, seek ±10 giây sẽ được chốt ở các feature kế tiếp.