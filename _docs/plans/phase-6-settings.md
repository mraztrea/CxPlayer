# Phase 6: Settings & Preferences

**Thời gian ước tính**: 1.5 tuần
**Phụ thuộc**: Phase 1, Phase 2 (gesture), Phase 5 (AI subtitle config)
**Mục tiêu**: Settings screen đầy đủ, gesture toggles, playback history (nhớ position/brightness/speed).

---

## Checklist

- [ ] 6.1 SettingsScreen (Jetpack Compose)
- [ ] 6.2 Playback settings section (speed, aspect ratio, auto-rotate)
- [ ] 6.3 Gesture settings section (toggle từng gesture, sensitivity)
- [ ] 6.4 Subtitle settings section (font size, bold, preferred lang)
- [ ] 6.5 AI Subtitle settings (API key, source/target lang, auto-start)
- [ ] 6.6 Network settings (buffer size)
- [ ] 6.7 History settings (remember position, brightness, max entries)
- [ ] 6.8 Appearance settings (theme: Dark/Light/System)
- [ ] 6.9 Room DB: PlaybackHistoryEntity + DAO
- [ ] 6.10 PlaybackHistoryRepository (save/restore per-URI)
- [ ] 6.11 Tích hợp: GestureController đọc GestureSettings
- [ ] 6.12 Tích hợp: PlayerActivity restore position + brightness khi mở video
- [ ] 6.13 EncryptedSharedPreferences cho API key
- [ ] 6.14 Export/Import settings

---

## Dependencies bổ sung

```groovy
def room = "2.6.1"
implementation "androidx.room:room-runtime:$room"
implementation "androidx.room:room-ktx:$room"
kapt "androidx.room:room-compiler:$room"

implementation "androidx.security:security-crypto:1.1.0-alpha06"
implementation "androidx.datastore:datastore-preferences:1.1.4"
```

## Cấu trúc files

```
app/src/main/java/com/cxplayer/
├── data/
│   ├── preferences/
│   │   └── UserPreferences.kt      # DataStore wrapper
│   ├── db/
│   │   ├── CxDatabase.kt           # Room database
│   │   └── PlaybackHistoryDao.kt
│   └── repository/
│       ├── SettingsRepository.kt
│       └── PlaybackHistoryRepository.kt
├── domain/model/
│   ├── GestureSettings.kt
│   └── AppSettings.kt
└── ui/settings/
    ├── SettingsScreen.kt            # Main settings Compose UI
    ├── PlaybackSettingsSection.kt
    ├── GestureSettingsSection.kt
    ├── AiSubtitleSettingsSection.kt
    └── AppearanceSettingsSection.kt
```

---

## Specs chi tiết

### 6.1 Settings Table

| Category | Setting | Type | Default | Storage |
|----------|---------|------|---------|---------|
| **Playback** | Default speed | Float | 1.0 | DataStore |
| | Resume playback | Boolean | true | DataStore |
| | Default aspect ratio | Enum | Fit | DataStore |
| | Auto-rotate | Boolean | true | DataStore |
| | Preferred audio lang | String | "" | DataStore |
| **Subtitle** | Font size | Int | 16 | DataStore |
| | Bold | Boolean | false | DataStore |
| | Preferred lang | String | "vi" | DataStore |
| **Gesture** | Swipe volume | Boolean | true | DataStore |
| | Swipe brightness | Boolean | true | DataStore |
| | Swipe seek | Boolean | true | DataStore |
| | Pinch-to-zoom | Boolean | true | DataStore |
| | Double-tap | Boolean | true | DataStore |
| | Long-press ff | Boolean | true | DataStore |
| | Sensitivity | Float | 1.0 | DataStore |
| **Network** | Buffer size (LAN) | Enum | Normal | DataStore |
| **AI Subtitle** | Soniox API key | String | "" | EncryptedPrefs |
| | Source language | String | "auto" | DataStore |
| | Target language | String | "vi" | DataStore |
| | Auto-start | Boolean | false | DataStore |
| **History** | Remember position | Boolean | true | DataStore |
| | Remember brightness | Boolean | true | DataStore |
| | Max entries | Int | 500 | DataStore |
| **Appearance** | Theme | Enum | System | DataStore |

### 6.2 PlaybackHistoryEntity (Room DB)

```kotlin
@Entity(tableName = "playback_history")
data class PlaybackHistoryEntity(
    @PrimaryKey val videoUri: String,
    val positionMs: Long,
    val durationMs: Long,
    val lastPlayedAt: Long,
    val brightness: Float?,       // null = system default
    val speed: Float?,
    val audioTrackIndex: Int?,
    val subtitleTrackIndex: Int?,
    val title: String?
)

@Dao
interface PlaybackHistoryDao {
    @Query("SELECT * FROM playback_history WHERE videoUri = :uri")
    suspend fun getByUri(uri: String): PlaybackHistoryEntity?

    @Upsert
    suspend fun upsert(entity: PlaybackHistoryEntity)

    @Query("DELETE FROM playback_history WHERE lastPlayedAt < :cutoff")
    suspend fun deleteOlderThan(cutoff: Long)

    @Query("SELECT COUNT(*) FROM playback_history")
    suspend fun count(): Int
}
```

### 6.3 GestureSettings

```kotlin
data class GestureSettings(
    val enableSwipeVolume: Boolean = true,
    val enableSwipeBrightness: Boolean = true,
    val enableSwipeSeek: Boolean = true,
    val enablePinchZoom: Boolean = true,
    val enableDoubleTap: Boolean = true,
    val enableLongPressFf: Boolean = true,
    val swipeSensitivity: Float = 1.0f
)
```

Tích hợp vào GestureController: check setting trước khi dispatch gesture.

### 6.4 Luồng restore playback history

```
1. PlayerActivity.onCreate()
2. → PlaybackHistoryRepository.getByUri(videoUri)
3. → if (history != null && settings.rememberPosition):
      - Seek to history.positionMs
      - Set brightness to history.brightness
      - Set speed to history.speed
      - Select audio/subtitle track
4. PlayerActivity.onStop()
5. → PlaybackHistoryRepository.upsert(currentState)
```

---

## Verification

1. Settings → tắt "Swipe volume" → vuốt bên phải → không thay đổi volume
2. Settings → tắt "Double-tap" → double-tap → không play/pause
3. Xem video 50% → đóng app → mở lại video → resume đúng vị trí
4. Đặt brightness 80% → đóng → mở lại → brightness vẫn 80%
5. Đặt speed 1.5x → đóng → mở video khác → speed mặc định 1.0x (per-video)
6. Nhập sai API key → hiện warning
7. Theme: đổi Dark → UI chuyển dark mode
8. Export settings → import trên thiết bị khác → settings khớp
