package com.google.android.exoplayer2.ext.ffmpeg;

import android.util.Log;
import androidx.annotation.Nullable;

public final class FfmpegLibrary {
    private static final String TAG = "LegacyFfmpegLibrary";
    private static final String EX_LIBRARY = "ex.ffmpeg.exo";
    private static final String FM_LIBRARY = "fm.ffmpeg.exo";

    private static boolean loadAttempted;
    private static boolean exAvailable;
    private static boolean fmAvailable;

    private FfmpegLibrary() {
    }

    public static synchronized boolean isAvailable() {
        ensureLoaded();
        return exAvailable || fmAvailable;
    }

    public static synchronized boolean isExAvailable() {
        ensureLoaded();
        return exAvailable;
    }

    public static synchronized boolean isFmAvailable() {
        ensureLoaded();
        return fmAvailable;
    }

    @Nullable
    public static synchronized String getVersion() {
        ensureLoaded();
        if (exAvailable) {
            return exFfmpegGetVersion();
        }
        if (fmAvailable) {
            return fmFfmpegGetVersion();
        }
        return null;
    }

    public static synchronized boolean hasDecoder(String codecName) {
        ensureLoaded();
        return hasDecoder(codecName, true) || hasDecoder(codecName, false);
    }

    public static synchronized boolean hasDecoder(String codecName, boolean useExDecoder) {
        ensureLoaded();
        if (useExDecoder) {
            return exAvailable && exFfmpegHasDecoder(codecName);
        }
        return fmAvailable && fmFfmpegHasDecoder(codecName);
    }

    private static void ensureLoaded() {
        if (loadAttempted) {
            return;
        }
        loadAttempted = true;
        exAvailable = tryLoad(EX_LIBRARY);
        fmAvailable = tryLoad(FM_LIBRARY);
    }

    private static boolean tryLoad(String libraryName) {
        try {
            System.loadLibrary(libraryName);
            return true;
        } catch (UnsatisfiedLinkError error) {
            Log.w(TAG, "Unable to load " + libraryName, error);
            return false;
        }
    }

    private static native String exFfmpegGetVersion();

    private static native boolean exFfmpegHasDecoder(String codecName);

    private static native String fmFfmpegGetVersion();

    private static native boolean fmFfmpegHasDecoder(String codecName);
}