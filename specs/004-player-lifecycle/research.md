# Research: Player Lifecycle Management

## Decision 1: Dùng `onStart` và `onStop` làm lifecycle boundary chính cho player session

- **Decision**: Giữ `onCreate()` chỉ để inflate view, parse intent và restore snapshot; dùng `onStart()` để attach/load session và `onStop()` để capture snapshot rồi release session.
- **Rationale**: Repo hiện chạy với `minSdk 24`, còn guideline lifecycle trong Android cho phép dùng `onStart`/`onStop` làm boundary chính cho tài nguyên hiển thị khi activity đi foreground/background. Cách này khớp với flow đang có trong `PlayerActivity` và tránh thêm nhánh `onResume`/`onPause` chỉ để phục vụ API thấp hơn không còn trong phạm vi hỗ trợ.
- **Alternatives considered**:
  - Chuyển hoàn toàn sang `onResume`/`onPause`: phù hợp hơn cho API 23 trở xuống nhưng thừa cho repo này và dễ làm tăng số lần attach/release không cần thiết.
  - Giữ player sống qua `onStop`: có thể giảm thời gian resume nhưng trái với yêu cầu clean release và làm phức tạp kiểm soát audio/background.

## Decision 2: Dùng `PlaybackSnapshot` + `savedInstanceState` làm handoff state duy nhất

- **Decision**: Chỉ lưu `currentIndex`, `currentPositionMs` và `playWhenReady` qua `PlaybackSnapshot`, sau đó persist snapshot này vào `savedInstanceState` trước khi activity có thể bị recreate.
- **Rationale**: Feature chỉ cần continuity ngắn hạn cho cùng một request playback. Snapshot nhẹ này đã tồn tại trong codebase, đủ để khôi phục item hiện tại, vị trí phát và ý định play/pause mà không mở rộng scope sang database, file cache hay persistent session store.
- **Alternatives considered**:
  - Đưa state vào persistent storage: bền hơn nhưng vượt phạm vi Phase 1 và tạo thêm vấn đề đồng bộ với incoming intent mới.
  - Dùng `ViewModel` hoặc `SavedStateHandle` như owner chính của playback state: khả thi cho UI state, nhưng player session hiện được điều phối trực tiếp bởi activity + manager nên thêm một layer mới chưa mang lại lợi ích tương xứng.

## Decision 3: Xem `onNewIntent()` là ranh giới thay thế session, không tái dùng snapshot của request cũ

- **Decision**: Khi `PlayerActivity` nhận intent mới, request mới sẽ thay thế request cũ; snapshot chờ từ phiên trước không được áp vào nội dung mới trừ khi nó được tạo lại từ chính request mới đó.
- **Rationale**: Activity dùng `singleTask`, nên intent mới là đường vào tự nhiên khi người dùng mở một video khác trong lúc player đang tồn tại. Tách rạch ròi session replacement khỏi session restore giúp tránh resume nhầm vị trí của nội dung cũ sang nội dung mới.
- **Alternatives considered**:
  - Cố gắng merge snapshot cũ vào request mới nếu index còn hợp lệ: có thể giảm logic chút ít nhưng rủi ro cao về phát sai nội dung.
  - Tạo activity instance mới cho mỗi intent: trái với manifest contract hiện tại.

## Decision 4: Giữ `CxPlayerManager` là owner duy nhất của ExoPlayer session và làm release idempotent

- **Decision**: Tiếp tục để `CxPlayerManager` nắm quyền tạo, bind, export snapshot và release session; activity chỉ gọi đúng boundary lifecycle và không tự giữ player instance riêng.
- **Rationale**: Manager hiện đã bọc session factory, state snapshot và transport helpers. Giữ một owner giúp thỏa điều kiện single-session discipline, giảm nguy cơ tạo hai phiên phát và đơn giản hóa test host-side.
- **Alternatives considered**:
  - Đưa logic session ownership thẳng vào `PlayerActivity`: ngắn hạn có vẻ ít lớp hơn nhưng làm activity phình ra và khó test hơn.
  - Nâng session owner lên service/application scope: phù hợp background playback, nhưng đó là phạm vi ngoài feature này.

## Decision 5: Giữ manifest contract hiện có, xác nhận recreate bằng test thay vì đổi navigation model trong feature này

- **Decision**: Không đổi `singleTask` hay `configChanges` chỉ để phục vụ feature lifecycle. Validation cho saved-state và recreate sẽ dùng `ActivityScenario.recreate()` cùng flow foreground/background hiện có.
- **Rationale**: Manifest contract hiện tại đã khóa hành vi launch của player và hỗ trợ mục tiêu tránh multiple activity instances. Feature lifecycle cần làm chắc handoff state và clean release, không cần mở rộng sang thay đổi navigation/config model ở cùng một bước.
- **Alternatives considered**:
  - Bỏ `configChanges` để ép recreate khi rotate: có thể giúp bắt lifecycle bug sớm hơn nhưng làm scope rộng ra khỏi mục tiêu chính của feature.
  - Bỏ `singleTask`: làm thay đổi hành vi mở video từ nguồn ngoài và tăng nguy cơ session chồng lấn.

## Decision 6: Validation ưu tiên test hiện có với lifecycle assertions bổ sung thay vì thêm hạ tầng mới

- **Decision**: Mở rộng `CxPlayerManagerTest` cho release/reload semantics và `PlayerActivityPlaybackTest` cho recreate, `moveToState()` và clean session continuity, thay vì dựng test harness mới.
- **Rationale**: Repo đã có đủ bề mặt unit + instrumentation để chứng minh feature. Đây là đường xác nhận hẹp nhất, ít chi phí nhất và phù hợp với rule thay đổi tối thiểu.
- **Alternatives considered**:
  - Tạo suite instrumentation mới hoàn toàn: rõ ràng hơn về tên nhưng làm phân tán validation khi test hiện tại đã bám đúng activity này.
  - Chỉ dùng manual QA: không đủ để giữ regression ở các task tiếp theo.