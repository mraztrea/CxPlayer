# Research: Playback Session Manager

## Decision 1: Tách quyền sở hữu `ExoPlayer` vào `CxPlayerManager`

- **Decision**: Tạo `CxPlayerManager` trong `CxPlayer/app/src/main/java/com/cxplayer/player/` để sở hữu duy nhất một `ExoPlayer` instance, gắn hoặc tháo `PlayerView`, thiết lập playlist, và giải phóng tài nguyên khi Activity không còn sở hữu phiên phát.
- **Rationale**: Điều này trực tiếp đáp ứng FR-001, FR-006 và FR-009 bằng cách loại bỏ việc `PlayerActivity` tự tạo và tự quản lý player ở nhiều callback khác nhau. Manager cũng tạo một surface nhỏ, dễ test hơn cho snapshot/restore và seek controls.
- **Alternatives considered**:
  - Giữ nguyên `ExoPlayer` trong `PlayerActivity`: nhanh hơn lúc đầu nhưng tiếp tục trộn UI với ownership/lifecycle logic.
  - Đưa player vào singleton hoặc service: vượt scope task 1.3 và kéo theo background playback/session policy chưa có trong Phase 1.

## Decision 2: Chuẩn hóa request trước khi gọi player

- **Decision**: Request launch phải bị reject chỉ khi không còn nguồn phát hợp lệ; nếu còn ít nhất một nguồn phát, `startIndex` được clamp về phần tử hợp lệ gần nhất và `startPosition` không hợp lệ được reset về `0`.
- **Rationale**: Quyết định này bám theo clarification đã chốt trong spec, giảm tỉ lệ fail không cần thiết cho request chỉ sai một phần, đồng thời giữ acceptance test rõ ràng cho trường hợp empty/unsupported playlist.
- **Alternatives considered**:
  - Reject toàn bộ request nếu có bất kỳ input nào sai: đơn giản nhưng làm trải nghiệm launch kém ổn định.
  - Luôn fallback về item đầu tiên: dễ cài đặt hơn nhưng không giữ ý định của caller khi index chỉ lệch một phần.

## Decision 3: Lifecycle boundary theo Activity foreground lifecycle

- **Decision**: `CxPlayerManager` được khởi tạo khi `PlayerActivity` vào foreground (`onStart` cho API 24+, `onResume` cho API cũ hơn), capture snapshot trong `onSaveInstanceState`, và release ở callback đối xứng (`onStop` hoặc `onPause`).
- **Rationale**: Cách này khớp với phase-1 plan, giảm rò rỉ player khi xoay màn hình và giữ restore path rõ ràng cho một foreground session duy nhất. Snapshot đủ nhẹ để không cần persistent storage.
- **Alternatives considered**:
  - Chỉ init/release trong `onCreate`/`onDestroy`: dễ tạo double-init khi activity recreation.
  - Giữ player qua config change bằng retained object/ViewModel ngay ở task 1.3: thêm complexity trước khi state model hoàn chỉnh.

## Decision 4: Chiến lược kiểm thử tách logic và wiring

- **Decision**: Dùng JUnit host-side cho `PlaybackRequest` normalization, manager snapshot/restore behavior và seek increments; thêm một instrumentation smoke test cho `PlayerActivity` để xác nhận attach/release/recreate path không crash.
- **Rationale**: Logic normalize và state transitions mang tính quyết định và chạy nhanh nhất ở host-side. Tuy nhiên, việc gắn `PlayerView` và vòng đời Activity cần ít nhất một thiết bị/emulator path để bắt regressions ở lớp wiring.
- **Alternatives considered**:
  - Chỉ dùng instrumentation: coverage tốt nhưng vòng lặp chậm và khó cô lập lỗi normalization.
  - Chỉ dùng unit test: rẻ nhưng bỏ sót sai khác lifecycle/UI integration.

## Decision 5: Giữ `CxPlayerManager` ở mức constructor-based, chưa buộc Hilt trong task này

- **Decision**: Manager được thiết kế theo constructor đơn giản, có thể khởi tạo trực tiếp từ `PlayerActivity` trong task 1.3 và chỉ bọc DI bằng Hilt ở task nền tảng kế tiếp nếu cần.
- **Rationale**: Repo đã có dependency Hilt nhưng chưa có `CxPlayerApp`/module wiring hoàn chỉnh cho player flow. Ép DI ngay bây giờ làm task 1.3 phụ thuộc sang setup hạ tầng chưa thuộc scope trực tiếp của manager.
- **Alternatives considered**:
  - Thêm Hilt module và application wiring ngay: nhất quán về kiến trúc nhưng làm rộng scope.
  - Dùng singleton tĩnh: giảm boilerplate nhưng khó test và làm ownership không rõ ràng.