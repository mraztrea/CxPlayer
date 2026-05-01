# Research: Track Selector UI

## Decision 1: Dùng `PopupWindow` bám vào `playerSettingsButton` và rebuild nội dung mỗi lần mở

- **Decision**: Selector sẽ là một `PopupWindow` gắn vào `playerSettingsButton`, inflate lại section audio/subtitle từ runtime state mỗi lần người dùng mở thay vì giữ một dialog hoặc fragment sống lâu.
- **Rationale**: Spec phase 3 đã chốt rõ UI là popup selector. `PlayerActivity` hiện đã có `settingsButton` và không dùng `PopupWindow` ở nơi khác, nên đây là seam nhỏ nhất để thêm UX mới mà không đòi navigation surface mới. Rebuild state mỗi lần mở tránh lệch state khi user vừa auto-detect subtitle, nạp phụ đề ngoài hoặc track availability thay đổi theo media item.
- **Alternatives considered**:
  - `DialogFragment`: vòng đời nặng hơn mức cần, nhiều ceremony hơn cho một control nhỏ ngay trên playback screen.
  - Bottom sheet: phù hợp khi có nhiều action dài, nhưng vượt quá visual weight mong muốn của feature và dễ che video hơn.

## Decision 2: Audio track selection đi qua `Player.currentTracks.groups` + `TrackSelectionOverride`, không nhét vào `SubtitleManager`

- **Decision**: Thêm một seam `TrackSelectorSessionController` để đọc audio groups từ `Player.currentTracks.groups`, tạo label/runtime state cho audio options và áp `TrackSelectionParameters`/`TrackSelectionOverride` khi user chọn audio track.
- **Rationale**: Tài liệu Media3 cho thấy current track availability nằm ở `player.currentTracks` và track selection override đi qua `TrackSelectionParameters`. `SubtitleManager` hiện đã chứa detection, external subtitle attach, embedded subtitle selection và styling; kéo audio logic vào đó sẽ làm class lệch trách nhiệm và tăng nguy cơ regression cho feature subtitle vừa làm xong.
- **Alternatives considered**:
  - Mở rộng `SubtitleManager` thành manager chung cho cả audio và subtitle: ít file hơn nhưng trách nhiệm bị trộn và test surface rộng hơn.
  - Chỉ dùng preferred audio language: quá gián tiếp, không đủ cho selector phải hiển thị và chuyển một track cụ thể.

## Decision 3: Subtitle section tái sử dụng `SubtitleManager.availableSubtitleSources()` thay vì đọc text tracks lần thứ hai

- **Decision**: Selector subtitle sẽ lấy dữ liệu từ `SubtitleManager.availableSubtitleSources()` để hiển thị `Off`, embedded subtitles và external subtitles đã nạp/tự dò, sau đó gọi lại `selectSubtitleSource()` khi user chọn.
- **Rationale**: `SubtitleManager` đã là nguồn sự thật cho subtitle runtime state, bao gồm external subtitle source không còn hiện diện trực tiếp trong `player.currentTracks.groups`. Nếu selector tự đọc lại text groups từ player, nó sẽ mất external source và tạo hai nguồn state cạnh tranh nhau.
- **Alternatives considered**:
  - Đọc toàn bộ subtitle state trực tiếp từ Media3 current tracks: không bao phủ external subtitle đã được bọc trong state của `SubtitleManager`.
  - Cache danh sách subtitle riêng trong popup: dễ stale khi user nạp/tắt/chuyển subtitle giữa các lần mở popup.

## Decision 4: Giữ luồng nạp phụ đề ngoài bằng cách chuyển action file picker sang `playerOverflowButton`

- **Decision**: `playerSettingsButton` sẽ đổi sang mở track selector popup; action mở file picker phụ đề ngoài hiện có sẽ được giữ lại nhưng chuyển sang `playerOverflowButton`, còn style testing shortcut có thể tiếp tục ở long-press nếu repo vẫn cần seam test tạm thời.
- **Rationale**: Feature mới cần một entry point rõ ràng cho selector mà không được làm mất capability nạp phụ đề ngoài đã tồn tại. `playerOverflowButton` hiện đã có mặt trên chrome nhưng chưa giữ hành vi quan trọng, nên đây là nơi rẻ nhất để tránh regression.
- **Alternatives considered**:
  - Nhét action “Nạp phụ đề ngoài” vào trong popup selector: gom action vào một nơi nhưng mở rộng scope của selector sang file picking workflow.
  - Thay hoàn toàn file picker bằng selector mới: gây regression trực tiếp cho feature subtitle hiện có.

## Decision 5: UI state selector dùng model nhỏ theo section thay vì tạo package domain mới

- **Decision**: Dùng các model runtime nhỏ gần `TrackSelector.kt`, gồm audio options, subtitle options và section state để render popup; không thêm package `domain/model` mới chỉ cho một control UI.
- **Rationale**: Repo hiện không có `domain/` package. Feature này chỉ cần state render tạm thời cho popup, không phải model chia sẻ xuyên nhiều layer hay persistence. Thêm package domain mới cho vài data class sẽ tạo ceremony nhiều hơn giá trị thật.
- **Alternatives considered**:
  - Tạo `com.cxplayer.domain.model.TrackInfo`: khớp sơ đồ phase 3 nhưng tăng cấu trúc mới chưa được repo dùng ở nơi khác.
  - Truyền trực tiếp `Tracks.Group` vào UI: làm UI phụ thuộc thẳng vào Media3 internals và khó test mapping logic.

## Decision 6: Validation ưu tiên host-side cho mapping/selection controller, còn popup behavior khóa bằng `PlayerActivityPlaybackTest`

- **Decision**: Viết unit tests cho `TrackSelectorSessionController` để kiểm tra label mapping, selection state và override routing; cập nhật `PlayerActivityPlaybackTest` để xác nhận selector mở được, selection không làm mất playback snapshot, và entry points settings/overflow vẫn hoạt động.
- **Rationale**: Rủi ro chính nằm ở mapping track runtime state và orchestration giữa activity, selector và manager. Host-side tests là lớp falsify rẻ nhất cho logic này; instrumentation chỉ cần smoke để khóa wiring UI và lifecycle playback.
- **Alternatives considered**:
  - Chỉ test thủ công: quá yếu cho logic mapping track labels, selected state và fallback behaviors.
  - Dồn hết vào androidTest: coverage UI tốt hơn nhưng chậm và tốn công hơn mức cần cho một popup control nhỏ.