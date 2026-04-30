package androidx.media3.decoder.ffmpeg;

import androidx.annotation.Nullable;
import androidx.media3.common.C;
import androidx.media3.common.MediaLibraryInfo;
import androidx.media3.common.MimeTypes;
import androidx.media3.common.util.Log;
import androidx.media3.common.util.UnstableApi;

@UnstableApi
public final class FfmpegLibrary {
    private static final String TAG = "FfmpegLibrary";
    private static final int INPUT_BUFFER_PADDING_SIZE = 64;

    @Nullable
    private static String version;

    static {
        MediaLibraryInfo.registerModule("media3.decoder.ffmpeg");
    }

    private FfmpegLibrary() {
    }

    public static boolean isAvailable() {
        return com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.isAvailable();
    }

    @Nullable
    public static String getVersion() {
        if (!isAvailable()) {
            return null;
        }
        if (version == null) {
            version = com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.getVersion();
        }
        return version;
    }

    public static int getInputBufferPaddingSize() {
        if (!isAvailable()) {
            return C.LENGTH_UNSET;
        }
        return INPUT_BUFFER_PADDING_SIZE;
    }

    public static boolean supportsFormat(String mimeType) {
        @Nullable String codecName = getCodecName(mimeType);
        if (codecName == null) {
            return false;
        }
        if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.hasDecoder(codecName)) {
            Log.w(TAG, "No " + codecName + " decoder available. Check the FFmpeg build configuration.");
            return false;
        }
        return true;
    }

    static boolean shouldUseExDecoder(String mimeType) {
        @Nullable String codecName = getCodecName(mimeType);
        if (codecName == null) {
            return false;
        }
        boolean exSupported = com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.hasDecoder(codecName, true);
        boolean fmSupported = com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.hasDecoder(codecName, false);
        return exSupported || !fmSupported;
    }

    @Nullable
    static String getCodecName(String mimeType) {
        switch (mimeType) {
            case MimeTypes.AUDIO_AAC:
                return "aac";
            case MimeTypes.AUDIO_MPEG:
            case MimeTypes.AUDIO_MPEG_L1:
            case MimeTypes.AUDIO_MPEG_L2:
                return "mp3";
            case MimeTypes.AUDIO_AC3:
                return "ac3";
            case MimeTypes.AUDIO_E_AC3:
            case MimeTypes.AUDIO_E_AC3_JOC:
                return "eac3";
            case MimeTypes.AUDIO_TRUEHD:
                return "truehd";
            case MimeTypes.AUDIO_DTS:
            case MimeTypes.AUDIO_DTS_HD:
                return "dca";
            case MimeTypes.AUDIO_VORBIS:
                return "vorbis";
            case MimeTypes.AUDIO_OPUS:
                return "opus";
            case MimeTypes.AUDIO_AMR_NB:
                return "amrnb";
            case MimeTypes.AUDIO_AMR_WB:
                return "amrwb";
            case MimeTypes.AUDIO_FLAC:
                return "flac";
            case MimeTypes.AUDIO_ALAC:
                return "alac";
            case MimeTypes.AUDIO_MLAW:
                return "pcm_mulaw";
            case MimeTypes.AUDIO_ALAW:
                return "pcm_alaw";
            default:
                return null;
        }
    }
}