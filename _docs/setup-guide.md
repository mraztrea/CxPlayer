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

Mở `app/build.gradle` (hoặc `build.gradle.kts`) và thêm dependencies:

### `settings.gradle` (project root)
```groovy
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolution {
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "CxPlayer"
include ':app'
```

### `build.gradle` (project root)
```groovy
plugins {
    id 'com.android.application' version '8.7.3' apply false
    id 'org.jetbrains.kotlin.android' version '2.1.0' apply false
    id 'com.google.dagger.hilt.android' version '2.53.1' apply false
}
```

### `app/build.gradle`
```groovy
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
    id 'com.google.dagger.hilt.android'
    id 'kotlin-kapt'
}

android {
    namespace 'com.cxplayer'
    compileSdk 35

    defaultConfig {
        applicationId "com.cxplayer"
        minSdk 24
        targetSdk 35
        versionCode 1
        versionName "1.0.0"
    }

    buildTypes {
        release {
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = '17'
    }

    buildFeatures {
        compose true
        viewBinding true
    }

    composeOptions {
        kotlinCompilerExtensionVersion '1.5.14'
    }
}

dependencies {
    // Media3 / ExoPlayer
    def media3 = "1.5.1"
    implementation "androidx.media3:media3-exoplayer:$media3"
    implementation "androidx.media3:media3-ui:$media3"
    implementation "androidx.media3:media3-common:$media3"
    implementation "androidx.media3:media3-datasource:$media3"
    implementation "androidx.media3:media3-extractor:$media3"
    implementation "androidx.media3:media3-session:$media3"

    // Android
    implementation "com.google.android.material:material:1.12.0"
    implementation "androidx.appcompat:appcompat:1.7.0"
    implementation "androidx.core:core-ktx:1.15.0"
    implementation "androidx.lifecycle:lifecycle-viewmodel-ktx:2.8.7"

    // Compose
    implementation platform("androidx.compose:compose-bom:2024.12.01")
    implementation "androidx.compose.ui:ui"
    implementation "androidx.compose.material3:material3"
    implementation "androidx.activity:activity-compose:1.9.3"

    // DI
    implementation "com.google.dagger:hilt-android:2.53.1"
    kapt "com.google.dagger:hilt-compiler:2.53.1"
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
