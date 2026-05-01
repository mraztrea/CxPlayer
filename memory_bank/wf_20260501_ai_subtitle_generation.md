# Workflow: AI Subtitle Generation — 2026-05-01

## Mô tả
Triển khai tính năng phụ đề AI real-time cho CxPlayer sử dụng Soniox STT API.

## Các file đã tạo/sửa

### File mới
| File | Mô tả |
|------|-------|
| `data/model/SubtitleEvent.kt` | Sealed class cho events: Original, Translation, Provisional |
| `data/model/SrtEntry.kt` | Data class cho SRT entry |
| `data/model/SonioxConfig.kt` | Config cho Soniox API |
| `data/model/SubtitleDisplayMode.kt` | Enum: ORIGINAL_ONLY, TRANSLATION_ONLY, BOTH |
| `data/db/CachedSubtitleEntity.kt` | Room Entity cho subtitle cache |
| `data/db/SubtitleDao.kt` | Room DAO cho CRUD operations |
| `data/db/AppDatabase.kt` | Room Database singleton |
| `player/CxAudioProcessor.kt` | AudioProcessor trích xuất PCM 16kHz mono |
| `subtitle/SonioxClient.kt` | WebSocket client (connect, keepalive, auto-reconnect, session reset) |
| `subtitle/AiSubtitleManager.kt` | Orchestrator cho toàn bộ AI subtitle flow |
| `subtitle/SrtExporter.kt` | Xuất SRT file chuẩn |
| `subtitle/SubtitleCacheManager.kt` | Quản lý Room DB cache |

### File đã sửa
| File | Thay đổi |
|------|----------|
| `player/CxRenderersFactory.kt` | Override `buildAudioSink` để inject CxAudioProcessor |
| `player/CxPlayerManager.kt` | Thêm `renderersFactory()` accessor |
| `ui/player/PlayerActivity.kt` | Thêm nút 🤖, overlay UI, toggle/display mode/export/cache logic |
| `res/layout/activity_player.xml` | Thêm nút AI và overlay phụ đề |
| `res/values/strings.xml` | Thêm strings cho AI subtitle |
| `gradle/libs.versions.toml` | Room 2.6.1 → 2.8.4 |
| `app/build.gradle.kts` | Thêm Room dependencies (KSP) |

## Cách sử dụng
1. Mở video bất kỳ trong CxPlayer
2. Nhấn nút 🤖 (mic) ở top bar để bật AI Subtitle
3. Lần đầu sẽ yêu cầu nhập API Key Soniox
4. Nhấn giữ nút 🤖 để chuyển chế độ: Gốc / Dịch / Cả hai
5. Tắt AI subtitle → hệ thống sẽ hỏi xuất SRT file và tự động cache

## Yêu cầu API Key
Cần đăng ký tại https://soniox.com để lấy API key.
API key lưu trong SharedPreferences với key `pref_soniox_api_key`.

## Không cần migration database
Room database mới hoàn toàn, không cần migration.
