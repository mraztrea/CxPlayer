# CxPlayer - Hướng dẫn Setup Môi trường

## Tổng quan

Bạn cần cài đặt các công cụ sau (theo thứ tự):

| # | Công cụ | Mục đích | Dung lượng |
|---|---------|----------|------------|
| 1 | Android Studio | IDE + SDK + JDK bundled | ~2.5 GB |
| 2 | Android SDK 35 | Compile target | ~150 MB |
| 3 | Android Emulator hoặc Device | Test/debug | ~2 GB (emulator) |

> **Lưu ý**: Android Studio đã đi kèm JDK 21 và Gradle. Không cần cài riêng.

---

## Bước 1: Cài Android Studio

1. Tải Android Studio tại: https://developer.android.com/studio
2. Chạy installer, chọn **Standard Installation**
3. Khi setup wizard chạy lần đầu, nó sẽ tự tải:
   - Android SDK
   - Android SDK Platform-Tools
   - Android SDK Build-Tools
   - Android Emulator
4. **Quan trọng**: Khi wizard hỏi SDK Location, ghi nhớ đường dẫn (thường là `C:\Users\<you>\AppData\Local\Android\Sdk`)

---

## Bước 2: Cấu hình SDK trong Android Studio

Sau khi cài xong, mở Android Studio → **More Actions** → **SDK Manager**:

### SDK Platforms tab
Tick cài đặt:
- [x] **Android 15.0 (VanillaIceCream)** - API 35
- [x] **Android 14.0 (UpsideDownCake)** - API 34 (để test trên nhiều version)

### SDK Tools tab
Tick cài đặt:
- [x] Android SDK Build-Tools 35
- [x] Android SDK Command-line Tools (latest)
- [x] Android SDK Platform-Tools
- [x] Android Emulator
- [x] NDK (Side by side) — **cần cho FFmpeg extension ở Phase 3**
- [x] CMake — **cần cho FFmpeg extension ở Phase 3**

Click **Apply** → đợi download.

---

## Bước 3: Tạo Emulator (hoặc dùng device thật)

### Option A: Emulator
1. Android Studio → **More Actions** → **Virtual Device Manager**
2. Click **Create Device**
3. Chọn **Pixel 7** (hoặc bất kỳ) → **Next**
4. Chọn system image **API 35** → **Download** nếu chưa có → **Next**
5. Đặt tên, **Finish**

### Option B: Device thật (khuyến nghị cho video player)
1. Bật **Developer Options** trên điện thoại:
   - Settings → About Phone → tap **Build Number** 7 lần
2. Bật **USB Debugging**:
   - Settings → Developer Options → USB Debugging → ON
3. Cắm USB vào máy tính
4. Cho phép debug khi popup xuất hiện trên điện thoại

> **Khuyến nghị**: Dùng device thật để test video player vì emulator không hỗ trợ tốt hardware decoding và gesture.

---

## Bước 4: Tạo Project CxPlayer

1. Mở Android Studio → **New Project**
2. Chọn template: **Empty Activity** (Compose)
3. Cấu hình:
   - **Name**: `CxPlayer`
   - **Package name**: `com.cxplayer`
   - **Save location**: `D:\Projects\Canhan\CxFileExplorer\CxPlayer`
   - **Language**: Kotlin
   - **Minimum SDK**: API 24 (Android 7.0 Nougat)
   - **Build configuration language**: Kotlin DSL (build.gradle.kts) hoặc Groovy
4. Click **Finish**

---

## Bước 5: Cấu hình Dependencies (Phase 1)

> **Lưu ý**: Project sử dụng Kotlin DSL (`.gradle.kts`) + Version Catalog (`libs.versions.toml`).
> AGP 9.x đã tích hợp sẵn Kotlin — không cần plugin `org.jetbrains.kotlin.android` riêng.
> Dùng KSP thay cho kapt (hiệu suất build tốt hơn).

### `gradle/libs.versions.toml` (Version Catalog)
```toml
[versions]
agp = "9.2.0"
kotlin = "2.2.10"
ksp = "2.2.10-2.0.2"
composeBom = "2026.02.01"
coreKtx = "1.10.1"
lifecycleRuntimeKtx = "2.6.1"
activityCompose = "1.8.0"
junit = "4.13.2"
junitVersion = "1.1.5"
espressoCore = "3.5.1"

# Phase 1: Core Player
media3 = "1.10.0"
hilt = "2.59.2"
material = "1.12.0"
appcompat = "1.7.0"
lifecycleViewmodelKtx = "2.8.7"

[libraries]
# AndroidX Core
androidx-core-ktx = { group = "androidx.core", name = "core-ktx", version.ref = "coreKtx" }
androidx-lifecycle-runtime-ktx = { group = "androidx.lifecycle", name = "lifecycle-runtime-ktx", version.ref = "lifecycleRuntimeKtx" }
androidx-lifecycle-viewmodel-ktx = { group = "androidx.lifecycle", name = "lifecycle-viewmodel-ktx", version.ref = "lifecycleViewmodelKtx" }
androidx-appcompat = { group = "androidx.appcompat", name = "appcompat", version.ref = "appcompat" }
google-material = { group = "com.google.android.material", name = "material", version.ref = "material" }

# Compose
androidx-activity-compose = { group = "androidx.activity", name = "activity-compose", version.ref = "activityCompose" }
androidx-compose-bom = { group = "androidx.compose", name = "compose-bom", version.ref = "composeBom" }
androidx-compose-ui = { group = "androidx.compose.ui", name = "ui" }
androidx-compose-ui-graphics = { group = "androidx.compose.ui", name = "ui-graphics" }
androidx-compose-ui-tooling = { group = "androidx.compose.ui", name = "ui-tooling" }
androidx-compose-ui-tooling-preview = { group = "androidx.compose.ui", name = "ui-tooling-preview" }
androidx-compose-ui-test-manifest = { group = "androidx.compose.ui", name = "ui-test-manifest" }
androidx-compose-ui-test-junit4 = { group = "androidx.compose.ui", name = "ui-test-junit4" }
androidx-compose-material3 = { group = "androidx.compose.material3", name = "material3" }

# Media3 / ExoPlayer (Phase 1)
androidx-media3-exoplayer = { group = "androidx.media3", name = "media3-exoplayer", version.ref = "media3" }
androidx-media3-ui = { group = "androidx.media3", name = "media3-ui", version.ref = "media3" }
androidx-media3-common = { group = "androidx.media3", name = "media3-common", version.ref = "media3" }
androidx-media3-datasource = { group = "androidx.media3", name = "media3-datasource", version.ref = "media3" }
androidx-media3-extractor = { group = "androidx.media3", name = "media3-extractor", version.ref = "media3" }
androidx-media3-session = { group = "androidx.media3", name = "media3-session", version.ref = "media3" }

# Hilt DI (Phase 1)
hilt-android = { group = "com.google.dagger", name = "hilt-android", version.ref = "hilt" }
hilt-compiler = { group = "com.google.dagger", name = "hilt-compiler", version.ref = "hilt" }

# Test
junit = { group = "junit", name = "junit", version.ref = "junit" }
androidx-junit = { group = "androidx.test.ext", name = "junit", version.ref = "junitVersion" }
androidx-espresso-core = { group = "androidx.test.espresso", name = "espresso-core", version.ref = "espressoCore" }

[plugins]
android-application = { id = "com.android.application", version.ref = "agp" }
kotlin-compose = { id = "org.jetbrains.kotlin.plugin.compose", version.ref = "kotlin" }
ksp = { id = "com.google.devtools.ksp", version.ref = "ksp" }
hilt = { id = "com.google.dagger.hilt.android", version.ref = "hilt" }
```

### `gradle.properties` — thêm dòng sau
```properties
# Allow KSP to add Kotlin source sets with AGP 9.x built-in Kotlin
android.disallowKotlinSourceSets=false
```

### `build.gradle.kts` (project root)
```kotlin
plugins {
    alias(libs.plugins.android.application) apply false
    alias(libs.plugins.kotlin.compose) apply false
    alias(libs.plugins.ksp) apply false
    alias(libs.plugins.hilt) apply false
}
```

### `app/build.gradle.kts`
```kotlin
plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.compose)
    alias(libs.plugins.ksp)
    alias(libs.plugins.hilt)
}

android {
    namespace = "com.cxplayer"
    compileSdk {
        version = release(36) {
            minorApiLevel = 1
        }
    }

    defaultConfig {
        applicationId = "com.cxplayer"
        minSdk = 24
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    buildFeatures {
        compose = true
        viewBinding = true
    }
}

dependencies {
    // Compose
    implementation(platform(libs.androidx.compose.bom))
    implementation(libs.androidx.activity.compose)
    implementation(libs.androidx.compose.material3)
    implementation(libs.androidx.compose.ui)
    implementation(libs.androidx.compose.ui.graphics)
    implementation(libs.androidx.compose.ui.tooling.preview)

    // AndroidX Core
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.lifecycle.runtime.ktx)
    implementation(libs.androidx.lifecycle.viewmodel.ktx)
    implementation(libs.androidx.appcompat)

    // Material Design (for XML views)
    implementation(libs.google.material)

    // Media3 / ExoPlayer (Phase 1)
    implementation(libs.androidx.media3.exoplayer)
    implementation(libs.androidx.media3.ui)
    implementation(libs.androidx.media3.common)
    implementation(libs.androidx.media3.datasource)
    implementation(libs.androidx.media3.extractor)
    implementation(libs.androidx.media3.session)

    // Hilt DI (Phase 1)
    implementation(libs.hilt.android)
    ksp(libs.hilt.compiler)

    // Test
    testImplementation(libs.junit)
    androidTestImplementation(platform(libs.androidx.compose.bom))
    androidTestImplementation(libs.androidx.compose.ui.test.junit4)
    androidTestImplementation(libs.androidx.espresso.core)
    androidTestImplementation(libs.androidx.junit)
    debugImplementation(libs.androidx.compose.ui.test.manifest)
    debugImplementation(libs.androidx.compose.ui.tooling)
}
```

---

## Bước 6: Sync & Build

1. Android Studio sẽ tự hiện banner **Sync Now** → click nó
2. Đợi Gradle sync hoàn thành (lần đầu mất ~2-5 phút tải dependencies)
3. Run → chọn device/emulator → ▶️ Run

---

## Bước 7: Thiết lập Environment Variables (optional)

Mở PowerShell (admin) và chạy:

```powershell
# Thêm Android SDK vào PATH (thay <username> bằng tên user)
[Environment]::SetEnvironmentVariable("ANDROID_HOME", "$env:LOCALAPPDATA\Android\Sdk", "User")
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$env:LOCALAPPDATA\Android\Sdk\platform-tools", "User")
```

Sau đó restart terminal. Kiểm tra:
```powershell
adb devices   # Nên thấy device/emulator
```

---

## Checklist xác nhận

Sau khi hoàn thành, kiểm tra:

- [ ] Android Studio mở được, không lỗi
- [ ] SDK Manager hiện API 35 đã cài
- [ ] Emulator chạy được HOẶC device thật kết nối (`adb devices` thấy)
- [ ] Project CxPlayer sync Gradle thành công
- [ ] Chạy app lên device/emulator → thấy màn hình trắng (empty activity)

---

## Troubleshooting

| Vấn đề | Giải pháp |
|--------|-----------|
| Gradle sync fail: "SDK not found" | File → Project Structure → SDK Location → chỉ đúng path |
| "JAVA_HOME is not set" | Android Studio dùng JDK bundled, thường không cần set. Nếu cần: `File → Settings → Build → Gradle → Gradle JDK` chọn "Embedded JDK" |
| Emulator chậm | Bật Hyper-V hoặc HAXM trong BIOS. Hoặc dùng device thật |
| Device không thấy trong Android Studio | Cài driver USB (Samsung: Samsung USB Driver, khác: Google USB Driver trong SDK Manager) |
| "minSdk 24 nhưng device là API 23" | Dùng device Android 7.0+ hoặc emulator API 24+ |

---

## Sau khi setup xong

Quay lại file [`phase-1-core-player.md`](./plans/phase-1-core-player.md) và bắt đầu triển khai từ task **1.1 Project Setup & Dependencies**.
