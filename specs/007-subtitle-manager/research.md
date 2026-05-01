# Research: Subtitle Manager

## Decision 1: Nạp phụ đề ngoài bằng cách rebuild `MediaItem` hiện tại với `MediaItem.SubtitleConfiguration`, đồng thời giữ nguyên vị trí phát và `playWhenReady`

- **Decision**: Khi người dùng nạp phụ đề ngoài hoặc auto-detect tìm thấy phụ đề hợp lệ, feature sẽ tạo `MediaItem.SubtitleConfiguration` mới, rebuild `MediaItem` hiện tại với danh sách subtitle configuration phù hợp, rồi re-prepare player trong cùng session sau khi giữ lại `currentPosition` và `playWhenReady`.
- **Rationale**: Tài liệu Media3 cho thấy external subtitle là phần của `MediaItem`, không phải một overlay tách rời. Cách làm này khớp với primitive chính thức của Media3, giúp subtitle ngoài đi qua cùng pipeline text track của player và không cần lớp render phụ đề tự quản lý riêng.
- **Alternatives considered**:
  - Render subtitle ngoài bằng lớp view tùy biến riêng trên `PlayerView`: tránh rebuild media item nhưng lệch khỏi Media3 pipeline, tăng rủi ro sync và bảo trì.
  - Reload toàn bộ playlist qua `CxPlayerManager.load()`: đơn giản hơn ở wiring nhưng làm bề mặt thay đổi lớn hơn mức cần thiết và dễ ảnh hưởng state playback hiện có.

## Decision 2: Giới hạn auto-detect ở source cục bộ cùng tên cơ bản với video; không suy diễn cho `content://`, `http://` hoặc tên có hậu tố ngôn ngữ khác

- **Decision**: Auto-detect mặc định chỉ chạy khi media source hiện tại là đường dẫn cục bộ có thể suy ra file path thực, và chỉ thử các extension `.srt`, `.ass`, `.ssa`, `.vtt` với cùng tên cơ bản như video.
- **Rationale**: Spec đã chốt rõ boundary là file cạnh video cùng tên cơ bản. `PlaybackRequest` hiện chỉ lưu `uriValue`, `scheme` và metadata mức cao; với `content://` hoặc remote URI, repo hiện chưa có contract nào đảm bảo truy cập sibling files. Giữ auto-detect ở local file path là lựa chọn ít rủi ro và testable nhất.
- **Alternatives considered**:
  - Quét thư mục hoặc DocumentTree cho `content://`: bao phủ rộng hơn nhưng đòi thêm permission/state handling ngoài scope.
  - Tự nhận nhiều biến thể như `movie.en.srt`: tiện hơn cho người dùng nhưng dễ chọn nhầm file và trái với assumption hiện tại của spec.

## Decision 3: Chọn hoặc tắt subtitle nhúng bằng `TrackSelectionParameters`, không rebuild media item cho mọi thao tác text track

- **Decision**: Embedded subtitle selection và thao tác tắt subtitle sẽ đi qua `TrackSelectionParameters`/`TrackSelectionOverride`; trạng thái off được mô hình hóa bằng việc disable `C.TRACK_TYPE_TEXT` hoặc xóa override tương ứng.
- **Rationale**: Tài liệu Media3 cho thấy text track selection thuộc nhóm track selection parameters. Đây là seam đúng cho embedded subtitle vì track đã nằm sẵn trong source, và thao tác chọn/tắt cần hiệu lực ngay mà không cần thay `MediaItem` nếu không có subtitle ngoài mới.
- **Alternatives considered**:
  - Rebuild `MediaItem` mỗi lần đổi subtitle nhúng: không cần phân biệt external/embedded API nhưng làm session churn nhiều hơn cần thiết.
  - Chỉ dùng preferred text language: không đủ để hỗ trợ chọn cụ thể một track hoặc tắt subtitle theo UI intent.

## Decision 4: Subtitle styling dùng trực tiếp `PlayerView.subtitleView` với `CaptionStyleCompat` và text size theo session hiện tại

- **Decision**: `SubtitleManager` sẽ áp style hiển thị trực tiếp lên `playerView.subtitleView` bằng `CaptionStyleCompat` và `setFixedTextSize`, giữ style ở mức runtime state cho phiên xem hiện tại.
- **Rationale**: `activity_player.xml` đã dùng `androidx.media3.ui.PlayerView`, và `PlayerView` đã sở hữu `SubtitleView`. Dùng seam này giữ feature nhỏ, cho hiệu lực nhìn thấy ngay, và tránh chạm vào XML overlay mới khi task hiện tại chỉ cần đổi cách hiển thị chữ.
- **Alternatives considered**:
  - Tạo subtitle overlay XML riêng với `TextView`: nhanh cho demo nhưng không đồng bộ với text cues/positioning của Media3.
  - Persist style vào storage từ task này: hữu ích nhưng vượt scope spec hiện tại vốn chỉ yêu cầu hiệu lực trong phiên xem hiện tại.

## Decision 5: `PlayerActivity` là orchestration seam cho subtitle actions; `CxPlayerManager` giữ ownership của player session

- **Decision**: Feature sẽ giữ `CxPlayerManager` tập trung vào playback session, còn `PlayerActivity` tạo và điều phối `SubtitleManager` vì activity hiện đã biết `PlaybackRequest`, `PlayerView`, lifecycle và settings button placeholder.
- **Rationale**: `PlayerActivity` đang chứa `PlaybackRequest`, pending launch, attach/release lifecycle và actions UI. `CxPlayerManager` hiện chưa expose `ExoPlayer` hay `PlayerView.subtitleView` như surface công khai, nên nhét toàn bộ subtitle orchestration vào manager sẽ làm bề mặt public contract nở không cần thiết.
- **Alternatives considered**:
  - Nhúng toàn bộ subtitle logic vào `CxPlayerManager`: giảm số class mới nhưng làm manager phình to và trộn UI style với session state.
  - Tạo module UI selector đầy đủ ngay trong feature này: đi nhanh tới UX hoàn chỉnh nhưng chồng lấn task 3.8 Track Selector UI.

## Decision 6: Validation ưu tiên host-side tests cho detection/state mapping, còn playback screen dùng smoke/regression và manual media matrix

- **Decision**: Kiểm thử chính gồm unit tests cho auto-detect, track state mapping, styling snapshot và failure handling; androidTest chỉ làm regression cho PlayerActivity không crash/mất playback khi subtitle action xảy ra; manual verification dùng sample `.srt`, `.ass`, `.vtt`, embedded MKV/MP4 và bad subtitle.
- **Rationale**: Media3 text track behavior phụ thuộc media sample thật và player runtime, trong khi phần logic dễ hồi quy nhất nằm ở basename detection, state transition và orchestration. Cách chia này vừa rẻ vừa phù hợp tầng rủi ro của feature.
- **Alternatives considered**:
  - Dồn hết vào instrumentation media playback: bao phủ runtime sâu hơn nhưng đòi asset và thiết bị nhiều hơn mức cần cho task hiện tại.
  - Chỉ test thủ công: không đủ khóa regression ở logic auto-detect và mapping selection state.