# Research: Playback Screen Layout

## Decision 1: Giữ `PlayerView` làm render surface duy nhất và dùng custom chrome overlay

- **Decision**: Tiếp tục dùng `androidx.media3.ui.PlayerView` làm vùng render fullscreen, giữ `app:use_controller="false"`, và đặt top bar, timeline, transport controls thành các overlay riêng trên cùng layout.
- **Rationale**: Media3 hỗ trợ controller mặc định, nhưng spec của feature yêu cầu vị trí thành phần và thứ tự hành động riêng. Layout hiện tại đã tắt controller mặc định, nên giữ hướng này tránh phải đấu nhau với hành vi show/hide và bố cục có sẵn của `PlayerView`.
- **Alternatives considered**:
  - Bật controller mặc định của `PlayerView`: nhanh hơn nhưng không đáp ứng được top bar tùy biến và control ordering của spec.
  - Dùng Compose overlay cho riêng màn hình này: khả thi nhưng làm tăng phạm vi kỹ thuật trong khi `PlayerActivity` hiện đã là màn hình XML/View system.

## Decision 2: Dùng bố cục fullscreen kiểu overlay với top region và bottom region tách biệt

- **Decision**: Tổ chức màn hình thành một root overlay fullscreen, trong đó video fill toàn màn hình, top region chứa back/title/overflow, bottom region chứa timeline row và transport row, mỗi vùng có nền scrim nhẹ để giữ độ đọc mà không che quá nhiều diện tích video.
- **Rationale**: Spec ưu tiên video là vùng chiếm ưu thế nhưng vẫn yêu cầu control nhận diện ngay. Tách theo region trên/dưới giúp người dùng hình thành muscle memory ổn định và giúp task 1.5-1.6 nối logic vào mà không phải di chuyển thành phần.
- **Alternatives considered**:
  - Nhét toàn bộ control vào một cột dưới cùng: đơn giản hơn nhưng làm ngữ cảnh tiêu đề/điều hướng yếu đi.
  - Dùng một toolbar cố định đè mạnh lên vùng video: dễ làm nhưng chiếm không gian nhìn thấy nhiều hơn mức cần thiết.

## Decision 3: Áp dụng system bar insets cho overlay controls, không inset toàn bộ vùng video

- **Decision**: Áp dụng top/bottom insets lên các container control thay vì thêm padding cho toàn bộ root/video surface.
- **Rationale**: Tài liệu `WindowInsetsCompat` cho phép lấy và dispatch insets đến những vùng cửa sổ nhỏ hơn. Với fullscreen player, cách này giữ video thật sự full-bleed nhưng vẫn đảm bảo nút back, timeline và transport row không nằm dưới status bar hoặc navigation bar khi portrait/landscape đổi chiều.
- **Alternatives considered**:
  - Padding toàn bộ root theo system bars: an toàn nhưng làm mất diện tích video và phá cảm giác immersive.
  - Bỏ qua insets: đơn giản nhất nhưng rủi ro cao cho khả năng nhìn thấy và chạm vào control trên thiết bị gesture navigation.

## Decision 4: Giữ implementation trong XML/ViewBinding thay vì đổi màn hình player sang Compose

- **Decision**: Thực hiện feature qua `activity_player.xml` + wiring trong `PlayerActivity.kt`, tận dụng `viewBinding` đã bật ở module app.
- **Rationale**: Surface player hiện tại đã là Activity XML với `PlayerView`. Layout phase 1 không cần state management phức tạp để biện minh cho một rewrite sang Compose; đi tiếp trên View system giữ diffs nhỏ, giảm rủi ro, và phù hợp mục tiêu “surgical changes”.
- **Alternatives considered**:
  - Rebuild toàn bộ player screen bằng ComposeView/Compose screen: linh hoạt hơn về UI nhưng mở rộng scope quá mức cho task 1.4.
  - Giữ `findViewById` thuần túy cho toàn bộ control mới: vẫn chạy được nhưng tăng ma sát khi màn hình thêm nhiều thành phần tương tác.

## Decision 5: Validation ưu tiên instrumentation assertions cho khả năng nhìn thấy và reflow bố cục

- **Decision**: Giữ smoke tests playback đang có, đồng thời thêm hoặc mở rộng instrumentation assertions để kiểm tra top region, timeline row và transport row tồn tại, còn nhìn thấy được và vẫn thao tác được sau khi recreate/orientation change.
- **Rationale**: Đây là feature layout; unit test không đủ để bắt regressions như control rơi khỏi viewport hoặc đè lên nhau. Instrumentation test trên `PlayerActivity` là đường xác nhận rẻ nhất bám sát hành vi người dùng.
- **Alternatives considered**:
  - Chỉ dựa vào manual QA: nhanh lúc đầu nhưng khó khóa regression ở các task tiếp theo.
  - Snapshot/golden tests riêng: mạnh hơn nhưng vượt nhu cầu Phase 1 và tạo thêm hạ tầng chưa có trong repo.