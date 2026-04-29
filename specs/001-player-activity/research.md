# Nghiên cứu kỹ thuật: Player Launch Entry

## Decision 1: Giữ `MainActivity` làm launcher, thêm `PlayerActivity` làm điểm vào playback riêng

- Decision: Không thay launcher hiện tại. `MainActivity` tiếp tục giữ `MAIN/LAUNCHER`, còn `PlayerActivity` chỉ nhận luồng playback.
- Rationale: Project hiện vẫn là Android template với `MainActivity` duy nhất. Tách `PlayerActivity` giúp đúng roadmap Phase 1, giảm coupling với home flow sau này, và giữ thay đổi gọn trong task `1.2`.
- Alternatives considered:
  - Thay luôn launcher thành `PlayerActivity`: bị rộng scope, khó rollback, lẫn với future home/navigation decisions.
  - Dùng lại `MainActivity` để nhận cả launcher lẫn playback: tăng branching logic sớm, làm mờ ranh giới giữa shell app và player entry.

## Decision 2: Chuẩn hóa mọi đầu vào về `PlaybackRequest` trước khi đụng playback logic

- Decision: Dù request đến từ `ACTION_VIEW` hay explicit launch trong app, tầng đầu của `PlayerActivity` sẽ chuyển hết về một mô hình `PlaybackRequest`.
- Rationale: Một đường validation duy nhất giúp xử lý thống nhất `uris`, `startIndex`, `startPositionMs`, fallback, và error outcome. Điều này cũng khớp với spec đã chốt ở bước `/speckit.specify`.
- Alternatives considered:
  - Xử lý từng loại intent trực tiếp trong activity: dễ sinh nhánh lỗi lặp lại và khó test.
  - Đẩy raw `Intent` xuống các lớp sâu hơn: làm phần playback phải biết quá nhiều về Android launch semantics.

## Decision 3: `PlayerActivity` phải khai báo intent filter hẹp nhưng rõ, với `android:exported` tường minh

- Decision: Dùng một activity exported riêng cho implicit video launch, với `ACTION_VIEW`, `CATEGORY_DEFAULT`, các scheme `http`, `https`, `content`, `file`, và MIME video được phase plan chỉ định.
- Rationale: Tài liệu Android nêu rõ implicit activity launch phụ thuộc vào intent filter match, `CATEGORY_DEFAULT`, và component có intent filter phải set `android:exported` tường minh để cài được trên Android 12+.
- Alternatives considered:
  - Không set `android:exported`: sai với yêu cầu cài đặt từ Android 12+ khi có intent filter.
  - Dùng filter quá rộng như mọi MIME/video wildcard không kiểm soát: dễ nhận nhầm input ngoài scope task `1.2`.

## Decision 4: Giữ `singleTask` theo phase plan để tránh stack player trùng lặp

- Decision: Giữ launch mode `singleTask` cho `PlayerActivity` đúng như phase plan đã chỉ ra.
- Rationale: Task `1.2` yêu cầu tránh trải nghiệm bị chồng nhiều màn hình player khi người dùng mở lại video từ app ngoài hoặc từ cùng một luồng. `singleTask` là quyết định kiến trúc đã có sẵn trong plan, nên plan implementation nên bám theo thay vì tự đổi.
- Alternatives considered:
  - `standard`: dễ sinh nhiều instance player, đi ngược yêu cầu tránh duplicate experience.
  - `singleTop`: giảm trùng lặp một phần nhưng không diễn tả mạnh bằng yêu cầu phase plan hiện tại.

## Decision 5: Chuẩn hóa và kiểm tra URI ngay khi nhận intent ngoài

- Decision: Khi nhận URI từ external intent, bước parse đầu tiên phải chuẩn hóa scheme/host về lowercase và loại bỏ phần tử rỗng/không hợp lệ trước khi build `PlaybackRequest`.
- Rationale: Android `Intent` API reference lưu ý so khớp scheme/host có phân biệt hoa thường; chuẩn hóa sớm giảm lỗi khó đoán khi nhận link từ app ngoài.
- Alternatives considered:
  - Tin tưởng URI từ caller: tăng rủi ro mismatch theo scheme case và làm lỗi nằm sâu hơn trong playback path.
  - Chỉ validate khi player đã khởi tạo: lỗi muộn, feedback cho người dùng kém rõ ràng hơn.

## Decision 6: Với launch lỗi, hiển thị thông báo ngắn gọn rồi kết thúc flow player

- Decision: Nếu request không có nguồn hợp lệ, index sai, hoặc mất quyền truy cập, `PlayerActivity` phải trả lỗi hiển thị cho người dùng và đóng flow thay vì render player rỗng.
- Rationale: Spec yêu cầu không crash và không để người dùng ở trạng thái broken playback. Kết thúc sớm giúp hành vi rõ ràng và dễ test hơn trong task đầu của player entry.
- Alternatives considered:
  - Giữ player mở với màn hình rỗng: trải nghiệm mơ hồ, khó phân biệt giữa loading và failure.
  - Nuốt lỗi thầm lặng: không đạt yêu cầu “clear failure outcome”.

## Nguồn tham khảo

- Android Developers: Intents and intent filters — implicit intent matching, `CATEGORY_DEFAULT`, và yêu cầu `android:exported` với component có intent filter.  
  https://developer.android.com/guide/topics/intents/intents-filters.html
- Android Developers: `Intent` API reference — lưu ý scheme/host matching có phân biệt hoa thường.  
  https://developer.android.com/reference/android/content/Intent
