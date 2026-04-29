# Phase 4: Network & Polish

**Thời gian ước tính**: 2 tuần
**Phụ thuộc**: Phase 1, Phase 3
**Mục tiêu**: LAN streaming tối ưu, SMB browsing, PiP, background audio.

---

## Checklist

- [ ] 4.1 OkHttp DataSource factory (thay thế default HTTP)
- [ ] 4.2 CxLoadControl (aggressive buffering cho LAN)
- [ ] 4.3 Wake mode: WAKE_MODE_NETWORK cho HTTP/SMB
- [ ] 4.4 SMB/CIFS browser (smbj library)
- [ ] 4.5 SMB DataSource (stream video từ share)
- [ ] 4.6 Picture-in-Picture (PiP) mode
- [ ] 4.7 Background audio playback
- [ ] 4.8 Auto-rotation / orientation lock

---

## Dependencies bổ sung

```groovy
implementation "androidx.media3:media3-datasource-okhttp:$media3"
implementation "com.squareup.okhttp3:okhttp:4.12.0"
implementation "com.hierynomus:smbj:0.13.0"
```

## Cấu trúc files

```
app/src/main/java/com/cxplayer/
├── player/
│   ├── CxLoadControl.kt           # Custom buffer config
│   └── CxMediaSourceFactory.kt    # URI → MediaSource resolver
├── data/datasource/
│   ├── CxDataSourceFactory.kt     # OkHttp-based
│   └── SmbDataSource.kt           # SMB stream
└── domain/usecase/
    └── BrowseNetwork.kt
```

---

## Specs chi tiết

### 4.1 LAN Streaming

```kotlin
class CxLoadControl : DefaultLoadControl(
    DefaultAllocator(true, C.DEFAULT_BUFFER_SEGMENT_SIZE),
    /* minBufferMs */         50_000,   // 50s
    /* maxBufferMs */         120_000,  // 2min
    /* bufferForPlaybackMs */ 2_500,
    /* bufferForRebufferMs */ 5_000,
    // ... defaults
)

class CxDataSourceFactory(context: Context) {
    private val okHttpClient = OkHttpClient.Builder()
        .connectTimeout(15, TimeUnit.SECONDS)
        .readTimeout(30, TimeUnit.SECONDS)
        .build()

    fun create(): DataSource.Factory {
        return OkHttpDataSource.Factory(okHttpClient)
            .setDefaultRequestProperties(mapOf("User-Agent" to "CxPlayer/1.0"))
    }
}
```

### 4.2 Wake Mode

```kotlin
if (isNetworkUri(uri)) {
    player.setWakeMode(C.WAKE_MODE_NETWORK)  // WiFi + CPU
} else {
    player.setWakeMode(C.WAKE_MODE_LOCAL)     // CPU only
}
```

### 4.3 SMB Browser

```kotlin
class SmbBrowser {
    fun connect(host: String, share: String, user: String, pass: String): List<FileInfo>
    fun openStream(path: String): InputStream
}
```

### 4.4 PiP Mode

```kotlin
override fun onUserLeaveHint() {
    if (Build.VERSION.SDK_INT >= 26 && player?.isPlaying == true) {
        enterPictureInPictureMode(
            PictureInPictureParams.Builder()
                .setAspectRatio(Rational(16, 9))
                .build()
        )
    }
}
```

---

## Verification

1. Play HTTP video trên LAN → buffer nhanh, không giật
2. SMB: nhập host/share/user/pass → browse folder → play video
3. PiP: nhấn Home khi đang phát → video thu nhỏ góc màn hình
4. Background: bật → tắt màn hình → audio tiếp tục
5. WiFi lock: phát video HTTP → WiFi không tắt khi idle
