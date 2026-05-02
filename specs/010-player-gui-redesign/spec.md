# Feature Specification: Player GUI Redesign

**Feature Branch**: `012-player-gui-redesign`  
**Created**: 2026-05-02  
**Status**: Draft  
**Input**: User description: "Sửa lại GUI của ứng dụng CxPlayer giống hệt với GUI của video_player_module"

## Clarifications

### Session 2026-05-02

- Q: Giao diện hiện tại có nút Repeat và Settings — khi redesign sẽ xử lý thế nào? → A: Giữ Repeat trên transport row, chuyển Settings vào overflow menu
- Q: Thứ tự sắp xếp các nút trên function row từ trái sang phải? → A: Lock → Subtitle → Resize → Rotate → Audio → Speed → Shuffle → Auto-play (theo tần suất sử dụng giảm dần)
- Q: Khi video chỉ có 1 subtitle track, nhấn nút Subtitle thì hành vi gì? → A: Toggle on/off trực tiếp, chỉ hiện popup chọn track khi có >= 2 tracks

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Bố cục điều khiển 2 vùng (Top Chrome + Bottom Chrome) (Priority: P1)

Người dùng mở video player và thấy giao diện điều khiển được chia thành 2 vùng rõ ràng:
- **Top Chrome**: Toolbar phía trên với nút Back, tiêu đề video, và nút menu overflow
- **Bottom Chrome**: Thanh điều khiển phía dưới với seek bar, nút play/pause và các nút chức năng

Bố cục này phải giống hệt với ứng dụng tham chiếu (`video_player_module`), trong đó:
- Top chrome có gradient scrim từ trên xuống
- Bottom chrome có gradient scrim từ dưới lên
- Khu vực giữa để trống hiển thị video, không có overlay điều khiển

**Why this priority**: Đây là nền tảng bố cục UI cốt lõi. Nếu bố cục sai, tất cả các chức năng khác sẽ không đúng vị trí.

**Independent Test**: Có thể kiểm tra bằng cách mở player và so sánh bố cục với ảnh chụp giao diện tham chiếu.

**Acceptance Scenarios**:

1. **Given** người dùng mở một video, **When** video bắt đầu phát và chạm vào màn hình, **Then** hiển thị Top Chrome (toolbar + title) phía trên và Bottom Chrome (seekbar + transport buttons) phía dưới
2. **Given** giao diện đang hiển thị, **When** không có tương tác trong 5 giây, **Then** cả Top Chrome và Bottom Chrome tự động ẩn đi
3. **Given** giao diện đã ẩn, **When** người dùng chạm vào màn hình, **Then** cả 2 vùng chrome hiện lại đồng thời

---

### User Story 2 - Hàng nút chức năng phụ (Function Row) trong Bottom Chrome (Priority: P1)

Trong Bottom Chrome, bên dưới seek bar và trước hàng transport chính (play/pause/prev/next), có một hàng nút chức năng phụ bao gồm:
- Nút **Lock Screen** (khóa màn hình)
- Nút **Rotate** (xoay màn hình ngang/dọc)
- Nút **Auto-play toggle**
- Nút **Audio Track Selector**
- Nút **Subtitle Toggle/Selector**
- Nút **Resize Mode** (Fit/Fill/Zoom)
- Nút **Shuffle**
- Dropdown **Playback Speed**

Các nút này được xếp trên 1 hàng ngang, có thể cuộn ngang (HorizontalScrollView) nếu không đủ chỗ.

**Why this priority**: Đây là điểm khác biệt lớn nhất giữa giao diện hiện tại và giao diện tham chiếu. Giao diện hiện tại thiếu hầu hết các nút này.

**Independent Test**: Mở player, kiểm tra xem tất cả các nút chức năng phụ có hiện đúng vị trí và hoạt động khi nhấn.

**Acceptance Scenarios**:

1. **Given** giao diện điều khiển đang hiển thị, **When** người dùng nhìn vào Bottom Chrome, **Then** thấy một hàng nút chức năng phụ gồm: Lock, Rotate, Auto-play, Audio, Subtitle, Resize, Shuffle, Speed
2. **Given** thiết bị có màn hình nhỏ, **When** hàng nút chức năng vượt quá chiều rộng, **Then** người dùng có thể cuộn ngang để truy cập các nút bị ẩn
3. **Given** giao diện ở chế độ khóa (Lock), **When** người dùng nhìn vào màn hình, **Then** chỉ hiển thị duy nhất nút Unlock, tất cả các nút khác bị ẩn

---

### User Story 3 - Lock Screen Mode (Priority: P2)

Người dùng có thể khóa giao diện điều khiển để tránh chạm nhầm khi xem video. Khi khóa:
- Tất cả nút điều khiển bị ẩn
- Chỉ hiển thị nút **Unlock** duy nhất
- Gesture (swipe brightness/volume/seek) bị vô hiệu hóa
- Sau khi unlock, giao diện trở về trạng thái bình thường

**Why this priority**: Chức năng quan trọng cho trải nghiệm xem phim, tránh thao tác nhầm.

**Independent Test**: Nhấn nút Lock, xác nhận giao diện ẩn hết. Nhấn Unlock, xác nhận giao diện quay lại.

**Acceptance Scenarios**:

1. **Given** giao diện đang hiển thị bình thường, **When** người dùng nhấn nút Lock, **Then** tất cả nút điều khiển ẩn, chỉ còn nút Unlock
2. **Given** giao diện đang khóa, **When** người dùng vuốt ngang/dọc, **Then** không có phản hồi seek/volume/brightness
3. **Given** giao diện đang khóa, **When** người dùng nhấn nút Unlock, **Then** giao diện trở lại trạng thái bình thường

---

### User Story 4 - Resize Mode Toggle (Priority: P2)

Người dùng có thể chuyển đổi giữa 3 chế độ hiển thị video:
- **Fit**: Video vừa khung hình, giữ nguyên tỉ lệ (có viền đen nếu cần)
- **Fill**: Video lấp đầy khung hình, cắt bớt nếu cần
- **Zoom**: Video phóng to, cắt nhiều hơn

Mỗi lần nhấn nút Resize, chế độ chuyển sang mode kế tiếp theo vòng: Fit → Fill → Zoom → Fit. Icon nút thay đổi theo chế độ hiện tại. Một label text hiển thị tên chế độ trong 1 giây rồi tự ẩn.

**Why this priority**: Chức năng phổ biến cần thiết cho video có tỉ lệ khác nhau.

**Independent Test**: Nhấn nút Resize liên tục, xác nhận video thay đổi chế độ và icon/label cập nhật đúng.

**Acceptance Scenarios**:

1. **Given** video đang phát ở chế độ Fit, **When** người dùng nhấn nút Resize, **Then** video chuyển sang Fill và icon cập nhật
2. **Given** video đang phát ở chế độ Zoom, **When** người dùng nhấn nút Resize, **Then** video chuyển sang Fit (quay vòng)
3. **Given** người dùng vừa nhấn Resize, **When** chế độ thay đổi, **Then** label tên chế độ hiện 1 giây rồi tự ẩn

---

### User Story 5 - Screen Rotation Toggle (Priority: P2)

Người dùng có thể nhấn nút Rotate để chuyển đổi giữa chế độ landscape và portrait. Nếu thiết bị đang bật auto-rotate, sau khi toggle thủ công, hệ thống sẽ chờ thiết bị xoay về hướng mong muốn rồi bật lại auto-rotate.

**Why this priority**: Cần thiết cho người dùng muốn khóa hướng xoay thủ công.

**Independent Test**: Nhấn nút Rotate, xác nhận màn hình xoay đúng hướng.

**Acceptance Scenarios**:

1. **Given** thiết bị đang ở portrait, **When** nhấn nút Rotate, **Then** màn hình chuyển sang landscape
2. **Given** thiết bị đang ở landscape, **When** nhấn nút Rotate, **Then** màn hình chuyển sang portrait

---

### User Story 6 - Playback Speed Dropdown (Priority: P3)

Người dùng có thể chọn tốc độ phát video từ một dropdown (spinner) với các mức tốc độ phổ biến (0.25x, 0.5x, 0.75x, 1.0x, 1.25x, 1.5x, 2.0x). Tốc độ được lưu lại và restore khi quay lại player.

**Why this priority**: Tính năng tiện ích, không ảnh hưởng đến trải nghiệm cơ bản.

**Independent Test**: Mở dropdown, chọn tốc độ, xác nhận video phát đúng tốc độ đã chọn.

**Acceptance Scenarios**:

1. **Given** video đang phát ở 1.0x, **When** người dùng chọn 2.0x từ dropdown, **Then** video phát với tốc độ gấp đôi
2. **Given** người dùng đã chọn 1.5x, **When** thoát và mở lại video, **Then** tốc độ vẫn là 1.5x

---

### Edge Cases

- Khi ở chế độ Lock, nhấn nút phần cứng Volume vẫn hoạt động bình thường
- Khi playlist chỉ có 1 video, nút Next/Previous bị disable hoặc ẩn
- Khi video không có subtitle track, nút Subtitle bị disable hoặc hiển thị thông báo "Không có phụ đề"
- Khi thiết bị không có cảm biến orientation, nút Rotate vẫn hoạt động nhưng chỉ toggle requestedOrientation
- Playback speed spinner không hiển thị khi video đang loading/buffering

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Giao diện PHẢI có 2 vùng chrome (Top Chrome + Bottom Chrome) với gradient scrim overlay
- **FR-002**: Top Chrome PHẢI chứa nút Back, tiêu đề video, và nút overflow menu
- **FR-003**: Bottom Chrome PHẢI chứa: timeline row (current time + seekbar + duration) và transport row (play controls + Repeat). Nút Settings hiện tại PHẢI được chuyển vào overflow menu trên Top Chrome
- **FR-004**: PHẢI có hàng nút chức năng phụ (function row) trong Bottom Chrome, hỗ trợ cuộn ngang
- **FR-005**: Function row PHẢI sắp xếp các nút theo thứ tự từ trái sang phải: Lock → Subtitle → Resize → Rotate → Audio → Speed → Shuffle → Auto-play. Nút Repeat giữ nguyên trên transport row (không nằm trong function row)
- **FR-006**: Nút Lock PHẢI ẩn toàn bộ UI chỉ giữ lại nút Unlock, và vô hiệu hóa gesture controls
- **FR-007**: Nút Resize PHẢI chuyển đổi vòng giữa 3 chế độ: Fit → Fill → Zoom → Fit, với icon và label thay đổi tương ứng
- **FR-008**: Nút Rotate PHẢI toggle giữa landscape và portrait, tích hợp auto-rotate sensor
- **FR-009**: Speed dropdown PHẢI hiển thị ít nhất 7 mức tốc độ và lưu lựa chọn của người dùng
- **FR-010**: Giao diện PHẢI tự động ẩn sau thời gian không tương tác (5 giây ở chế độ thường, 3 giây ở chế độ lock)
- **FR-011**: PHẢI hiển thị label text tạm thời (1 giây) khi chuyển resize mode để thông báo chế độ hiện tại
- **FR-012**: Nút Audio Track PHẢI mở popup chọn track audio giống giao diện tham chiếu
- **FR-013**: Nút Subtitle PHẢI toggle on/off trực tiếp khi video chỉ có 1 track subtitle, và mở popup chọn track khi có >= 2 tracks

### Key Entities

- **PlayerControlState**: Trạng thái hiển thị giao diện (visible/hidden, locked/unlocked, resize mode, playback speed)
- **FunctionButton**: Một nút chức năng trên function row (id, icon, contentDescription, visibility, enabled)
- **ResizeMode**: Enum 3 chế độ hiển thị video (Fit, Fill, Zoom) với icon và label tương ứng

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Bố cục giao diện player PHẢI khớp với giao diện tham chiếu khi so sánh trực quan (2 vùng chrome, function row, transport row)
- **SC-002**: 100% các nút chức năng liệt kê trong FR-005 PHẢI có mặt trên giao diện và phản hồi khi nhấn
- **SC-003**: Chuyển đổi giữa 3 resize mode PHẢI hoàn tất trong dưới 200ms mỗi lần nhấn
- **SC-004**: Lock/Unlock screen PHẢI hoàn tất trong dưới 100ms, ẩn/hiện tất cả nút tức thì
- **SC-005**: Tốc độ phát thay đổi tức thì (dưới 500ms) sau khi người dùng chọn từ speed dropdown
- **SC-006**: Giao diện PHẢI hoạt động đúng trên cả orientation portrait và landscape
- **SC-007**: Label resize mode PHẢI tự động ẩn sau đúng 1 giây

## Assumptions

- Ứng dụng CxPlayer đã có sẵn hệ thống GestureController để xử lý swipe brightness/volume/seek — chỉ cần thêm logic lock screen vào đó
- Subtitle Manager (`SubtitleManager.kt`) và Track Selector (`TrackSelector.kt`) đã được triển khai — tính năng chỉ cần gắn nút UI mới vào logic hiện có
- Ứng dụng đã sử dụng ExoPlayer/Media3 làm engine — các chức năng resize mode và playback speed đều dùng API có sẵn của Media3
- Playlist management (`CxPlayerManager.kt`) với next/previous/shuffle/repeat đã được triển khai
- Các icon drawable cho các nút mới sẽ cần được thêm vào resource (hoặc tái sử dụng icon hiện có)
- Target device: Android 7.0+ (API 24+), tương thích với cấu hình hiện tại của project
