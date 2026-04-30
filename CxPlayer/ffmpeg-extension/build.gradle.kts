plugins {
    alias(libs.plugins.android.library)
}

android {
    namespace = "com.cxplayer.ffmpegextension"
    compileSdk {
        version = release(36) {
            minorApiLevel = 1
        }
    }

    defaultConfig {
        minSdk = 24
    }

    sourceSets {
        getByName("main") {
            jniLibs.srcDirs("../../video_player_module/native_libs")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

dependencies {
    implementation("androidx.annotation:annotation:1.9.1")
    implementation(libs.androidx.media3.common)
    implementation(libs.androidx.media3.exoplayer)
}