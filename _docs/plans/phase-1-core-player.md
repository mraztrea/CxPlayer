# Phase 1: Core Player

**Thời gian ước tính**: 2 tuần
**Mục tiêu**: Xây dựng player cơ bản có thể phát video local và HTTP, với controls tối thiểu.

---

## Checklist

- [ ] 1.1 Project Setup & Dependencies
- [ ] 1.2 PlayerActivity + Manifest
- [ ] 1.3 CxPlayerManager (ExoPlayer wrapper)
- [ ] 1.4 Layout: PlayerView + Controls
- [ ] 1.5 Basic Controls (play/pause, seek bar, time)
- [ ] 1.6 Seek forward/backward 10s
- [ ] 1.7 Intent handling (ACTION_VIEW, content://, file://, http://)
- [ ] 1.8 Lifecycle management + state restore
- [ ] 1.9 Keep screen on + fullscreen immersive
- [ ] 1.10 Resume playback position (savedInstanceState)

---

## Dependencies (Phase 1 only)

> Xem chi tiết tại `gradle/libs.versions.toml` và `app/build.gradle.kts`.
> Project dùng Kotlin DSL + Version Catalog + KSP (không dùng kapt).

**Versions:**
| Library | Version |
|---------|---------|
| Media3 (ExoPlayer) | 1.10.0 |
| Hilt (DI) | 2.59.2 |
| KSP | 2.2.10-2.0.2 |
| Material | 1.12.0 |
| AppCompat | 1.7.0 |
| Lifecycle ViewModel | 2.8.7 |

**Plugins (app module):** `android.application`, `kotlin.compose`, `ksp`, `hilt`

**Key dependencies:**
```kotlin
// Media3 / ExoPlayer
implementation(libs.androidx.media3.exoplayer)
implementation(libs.androidx.media3.ui)
implementation(libs.androidx.media3.common)
implementation(libs.androidx.media3.datasource)
implementation(libs.androidx.media3.extractor)
implementation(libs.androidx.media3.session)

// Hilt DI
implementation(libs.hilt.android)
ksp(libs.hilt.compiler)

// Android
implementation(libs.androidx.appcompat)
implementation(libs.google.material)
implementation(libs.androidx.lifecycle.viewmodel.ktx)
```

---

## Cấu trúc files cần tạo

```
app/src/main/
├── java/com/cxplayer/
│   ├── CxPlayerApp.kt              # @HiltAndroidApp
│   ├── player/
│   │   └── CxPlayerManager.kt      # ExoPlayer lifecycle wrapper
│   └── ui/player/
│       ├── PlayerActivity.kt        # Single Activity
│       └── PlayerViewModel.kt       # UI state
├── res/
│   ├── layout/activity_player.xml
│   └── values/themes.xml            # Fullscreen theme
└── AndroidManifest.xml
```

---

## Specs chi tiết

### 1.1 Project Setup

- Tạo Android project mới: `com.cxplayer`
- Min SDK 24, Target SDK 35, Kotlin
- Setup Hilt (Application class + kapt)

### 1.2 PlayerActivity

```kotlin
// Intent contract
data class PlayerIntent(
    val uris: List<Uri>,
    val startIndex: Int = 0,
    val startPositionMs: Long = 0
)
```

**Manifest:**
```xml
<activity
    android:name=".ui.player.PlayerActivity"
    android:configChanges="orientation|screenSize|keyboardHidden"
    android:launchMode="singleTask"
    android:theme="@style/Theme.CxPlayer.Fullscreen">
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <data android:scheme="http" />
        <data android:scheme="https" />
        <data android:scheme="content" />
        <data android:scheme="file" />
        <data android:mimeType="video/mp4" />
        <data android:mimeType="video/3gpp" />
        <data android:mimeType="video/webm" />
        <data android:mimeType="video/x-matroska" />
    </intent-filter>
</activity>
```

### 1.3 CxPlayerManager

```kotlin
class CxPlayerManager(private val context: Context) {
    private var player: ExoPlayer? = null

    fun initialize() {
        val trackSelector = DefaultTrackSelector(context)
        player = ExoPlayer.Builder(context)
            .setTrackSelector(trackSelector)
            .setSeekForwardIncrementMs(10_000)
            .setSeekBackIncrementMs(10_000)
            .build().apply {
                setAudioAttributes(AudioAttributes.DEFAULT, true)
                setWakeMode(C.WAKE_MODE_LOCAL)
                playWhenReady = true
            }
    }

    fun play(uris: List<Uri>, startIndex: Int = 0, positionMs: Long = 0) {
        val mediaItems = uris.map { MediaItem.fromUri(it) }
        player?.apply {
            setMediaItems(mediaItems, startIndex, positionMs)
            prepare()
        }
    }

    fun release() {
        player?.release()
        player = null
    }
}
```

### 1.4 Layout

```
┌──────────────────────────────────────────┐
│ [← Back]  Video Title           [...Menu]│  ← Toolbar (auto-hide)
│                                          │
│              PlayerView                  │  ← ExoPlayer PlayerView
│           (full screen)                  │
│                                          │
│  00:12:34 ═══════●═══════════ 01:45:00   │  ← SeekBar
│       [⏪]    [⏯️]    [⏩]    [🔊] [⚙️]  │  ← Controls bar
└──────────────────────────────────────────┘
```

### 1.5 Lifecycle

```
onCreate  → inflate layout, parse intent
onStart   → initializePlayer() (API 24+)
onResume  → initializePlayer() (API 23-)
onPause   → releasePlayer()   (API 23-)
onStop    → releasePlayer()   (API 24+)
onDestroy → cleanup
onSaveInstanceState → save position, window, autoPlay, speed
```

---

## Verification

1. Cài APK → mở file MP4 từ file manager → video phát
2. Mở URL HTTP → buffering → phát
3. Xoay màn hình → position không đổi
4. Controls: play/pause, seek bar, seek ±10s hoạt động
5. Fullscreen immersive: thanh status/navigation ẩn
