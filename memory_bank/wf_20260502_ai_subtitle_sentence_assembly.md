# Workflow: AI Subtitle Sentence Assembly

## Mục tiêu

Sửa AI subtitle realtime để hiển thị theo câu/phân đoạn subtitle tự nhiên thay vì từng token hoặc mảnh từ.

## Root cause

1. `SonioxClient` đang emit sự kiện cho từng token final/provisional.
2. `AiSubtitleManager` finalize entry mới mỗi khi nhận original token finalized, khiến gần như mỗi token final trở thành một subtitle riêng.
3. `PlayerActivity` render trực tiếp từng event, nên overlay nhảy theo token subword như `You`, `'`, `Th`, `rough`, `B`, `ạn`.

## File đã sửa

- `CxPlayer/app/src/main/java/com/cxplayer/data/model/SubtitleEvent.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/subtitle/SonioxClient.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/subtitle/AiSubtitleManager.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`

## Cách sửa

- `SonioxClient`
  - gom token theo từng WebSocket message thành một `SonioxChunk`
  - tách `finalizedOriginalText`, `finalizedTranslationText`, `provisionalOriginalText`, `hasEndToken`
- `AiSubtitleManager`
  - giữ buffer câu hiện tại
  - chỉ flush subtitle khi gặp dấu kết câu, `<end>`, gap thời gian đủ lớn, hoặc câu quá dài
  - emit `SubtitleEvent.Snapshot` cho UI thay vì emit từng token
- `PlayerActivity`
  - render snapshot hoàn chỉnh
  - original line dùng italic khi còn provisional tail

## Verify

- Chạy:
  - `rtk pwsh -NoProfile -Command "Set-Location 'D:\Projects\CaNhan\CxPlayer\CxPlayer'; .\gradlew.bat :app:compileDebugKotlin --console=plain --no-daemon"`
- Kiểm tra thực tế:
  - overlay không còn hiển thị từng token rời
  - một câu giữ ổn định hơn trước khi flush
  - bản dịch không còn bị bám theo token cắt giữa từ

## Ghi chú

- Không cần migrate database.
- Patch này cố ý giữ scope trong pipeline subtitle/UI, không đụng audio pipeline hay storage contract khác.
