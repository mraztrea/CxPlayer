# Research: Network Polish

## Decision 1: Chèn `CxMediaSourceFactory` + `CxDataSourceFactory` thay vì tiếp tục `MediaItem.fromUri()` thuần túy

- **Decision**: Tạo một seam phân giải source theo URI trong playback stack, nơi HTTP(S) đi qua `DefaultDataSource.Factory` có base là `OkHttpDataSource.Factory`, còn SMB được route sang custom `SmbDataSource` thay vì để `CxPlayerManager` chỉ gọi `MediaItem.fromUri()` như hiện tại.
- **Rationale**: `CxPlayerManager` hiện map `request.sources` trực tiếp thành `MediaItem.fromUri`, nên không có chỗ để áp datasource/policy khác nhau theo scheme. Tài liệu Media3 hỗ trợ rõ cách dùng `DefaultDataSource.Factory` với `OkHttpDataSource.Factory` làm base datasource để bao phủ HTTP và vẫn tương thích với local/content. Đây là seam nhỏ nhất để thêm tối ưu LAN mà không phá local playback flow đã có.
- **Alternatives considered**:
  - Giữ default datasource của ExoPlayer: ít code hơn nhưng không có chỗ để tối ưu HTTP hoặc cắm SMB stream path.
  - Tạo một datasource custom xử lý luôn mọi scheme: quá phức tạp, khó test và thừa vì Media3 đã có path chuẩn cho HTTP/local.

## Decision 2: Dùng `CxLoadControl` builder-based và chọn wake mode theo loại source

- **Decision**: Tạo `CxLoadControl` bằng `DefaultLoadControl.Builder()` với buffer duration ưu tiên LAN streaming, đồng thời áp `C.WAKE_MODE_NETWORK` cho HTTP(S)/SMB và giữ `C.WAKE_MODE_LOCAL` cho local/content.
- **Rationale**: Tài liệu Media3 cho thấy `LoadControl` và `setWakeMode` là seams chính thống ở `ExoPlayer.Builder`. Release notes của Media3 cũng nhấn mạnh local wake mode là mặc định cho nhiều trường hợp buffering nền; vì phase này có network playback, cần phân nhánh wake policy rõ ràng theo source category thay vì hardcode một giá trị chung. Cách này sửa đúng chỗ gốc là lúc build player/session policy.
- **Alternatives considered**:
  - Dùng buffer mặc định và chỉ tăng timeout mạng: không giải quyết trực tiếp rebuffer behavior cho video LAN bitrate cao.
  - Luôn dùng `WAKE_MODE_NETWORK`: đơn giản hơn nhưng giữ Wi-Fi lock cả cho local playback là lãng phí và lệch intent của docs.

## Decision 3: SMB được tách thành hai seam: browse/auth và stream đọc-only, credential chỉ sống trong runtime session

- **Decision**: `SmbBrowser` lo connect/authenticate/listing và trả về model thư mục hoặc video; `SmbDataSource` chỉ lo mở luồng đọc file để phát. Credentials được nhập cho từng browse/play session và không persist dài hạn ở phase này.
- **Rationale**: README của SMBJ minh họa flow chuẩn là `SMBClient -> Connection -> Session -> DiskShare -> list/open`, còn FAQ của SMBJ khuyến nghị dùng quyền truy cập tối thiểu và timeout/socket timeout rõ ràng để giảm lỗi `STATUS_ACCESS_DENIED` hoặc `STATUS_SHARING_VIOLATION`. Việc tách browse và stream giúp player path chỉ xử lý phát media, còn browse path xử lý UX + auth, không trộn hai trách nhiệm.
- **Alternatives considered**:
  - Mount SMB như file local rồi phát qua `file://`: không khả thi trong scope app Android hiện tại.
  - Tải toàn bộ file SMB về local cache rồi mới phát: tăng dung lượng, chậm time-to-first-frame và lệch mục tiêu streaming trực tiếp.
  - Persist password SMB: tạo thêm scope bảo mật và UX quản lý credential vượt quá phase này.

## Decision 4: Background audio phải chuyển player ownership sang `MediaSessionService`, không thể giữ activity-bound lifecycle hiện tại

- **Decision**: Di chuyển ownership của session phát sang một `PlaybackService`/`MediaSessionService` để background audio và playback resumption sống độc lập với `PlayerActivity`; activity sẽ attach/detach UI thay vì release player trong `onStop`.
- **Rationale**: `PlayerActivity` hiện gọi `playerManager.release()` ở `onStop`, nên background audio đúng nghĩa là bất khả thi nếu chỉ vá UI. Tài liệu Media3 khuyến nghị `MediaSessionService` cho background playback và playback resumption; repo đã có dependency `media3-session`, nên đây là seam vừa chính thống vừa sát hiện trạng nhất.
- **Alternatives considered**:
  - Giữ player trong `Activity` và bỏ `release()` ở `onStop`: đơn giản ngắn hạn nhưng fragile với process death, audio controls hệ thống và foreground/background transitions.
  - Dùng foreground service không có media session: đỡ thay đổi hơn nhưng kém tích hợp với transport controls và playback resumption.

## Decision 5: PiP vẫn là concern của `PlayerActivity`, nhưng playback continuity dựa trên service-backed session

- **Decision**: Bật PiP cho `PlayerActivity` trong manifest, vào PiP từ activity khi user rời app lúc video đang phát, và sửa lifecycle để `onPause` không pause playback nếu activity đang ở PiP.
- **Rationale**: Android docs yêu cầu activity khai báo `supportsPictureInPicture`, handle config changes phù hợp và không pause video một cách mù quáng khi chuyển vào PiP. Khi player đã sống ở service, activity có thể tập trung vào UI/PiP shell và không cần làm owner của timeline phát nữa. Đây là cách phù hợp nhất với playback stack hiện tại.
- **Alternatives considered**:
  - Mini-player overlay riêng trong app: scope lớn hơn nhiều và không thay thế được PiP hệ thống.
  - Đưa PiP xuống service layer: sai abstraction, vì PiP là concern của activity window chứ không phải của player engine.

## Decision 6: Orientation lock là session UI preference; SMB sources chỉ đi qua internal explicit launch, không mở rộng implicit intent filter

- **Decision**: Orientation lock/tự xoay được giữ như preference của phiên xem trong `PlayerActivity` và state recreate; parser launch chỉ mở rộng cho SMB ở internal playback flow sau khi user browse/chọn file, không thêm `smb` vào manifest `ACTION_VIEW` filter ở phase này.
- **Rationale**: Manifest hiện chỉ nhận `http/https/content/file` và đó là đúng với những nguồn hệ thống có thể gửi cho app. SMB ở feature này đến từ browser nội bộ, nên internal explicit launch là seam đơn giản và an toàn hơn. Orientation cũng chỉ cần ổn định trong phiên xem hiện tại, không cần cài đặt toàn cục.
- **Alternatives considered**:
  - Thêm `smb` vào intent filter hệ thống: tăng bề mặt edge case mà app chưa có UX nhập credential khi launch từ bên ngoài.
  - Persist orientation lock toàn app: vượt nhu cầu phase 4 và dễ gây side effect cho màn hình khác.