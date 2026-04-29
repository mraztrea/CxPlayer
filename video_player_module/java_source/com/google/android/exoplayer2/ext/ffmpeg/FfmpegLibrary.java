// Decompiled from: Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;
// Package: com.google.android.exoplayer2.ext.ffmpeg

package com.google.android.exoplayer2.ext.ffmpeg;
public final class FfmpegLibrary {
    private static boolean a;
    private static boolean b;
    private static String c;
    private static int d;

    static FfmpegLibrary()
    {
        ax.P0.z.a("media3.decoder.ffmpeg");
        com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.d = -1;
        return;
    }

    private static String a()
    {
        if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.a) {
            if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.b) {
                return 0;
            } else {
                return com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.fmFfmpegGetVersion();
            }
        } else {
            return com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.exFfmpegGetVersion();
        }
    }

    private static boolean b(String p1)
    {
        if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.a) {
            if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.b) {
                return 0;
            } else {
                return com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.fmFfmpegHasDecoder(p1);
            }
        } else {
            return com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.exFfmpegHasDecoder(p1);
        }
    }

    static String c(String p2)
    {
        p2.getClass();
        int v0 = -1;
        switch (p2.hashCode()) {
            case -2123537834:
                if (p2.equals("audio/eac3-joc")) {
                    v0 = 0;
                } else {
                }
                break;
            case -1606874997:
                if (p2.equals("audio/amr-wb")) {
                    v0 = 1;
                } else {
                }
                break;
            case -1095064472:
                if (p2.equals("audio/vnd.dts")) {
                    v0 = 2;
                } else {
                }
                break;
            case -1003765268:
                if (p2.equals("audio/vorbis")) {
                    v0 = 3;
                } else {
                }
                break;
            case -432837260:
                if (p2.equals("audio/mpeg-L1")) {
                    v0 = 4;
                } else {
                }
                break;
            case -432837259:
                if (p2.equals("audio/mpeg-L2")) {
                    v0 = 5;
                } else {
                }
                break;
            case -53558318:
                if (p2.equals("audio/mp4a-latm")) {
                    v0 = 6;
                } else {
                }
                break;
            case 187078296:
                if (p2.equals("audio/ac3")) {
                    v0 = 7;
                } else {
                }
                break;
            case 1503095341:
                if (p2.equals("audio/3gpp")) {
                    v0 = 8;
                } else {
                }
                break;
            case 1504470054:
                if (p2.equals("audio/alac")) {
                    v0 = 9;
                } else {
                }
                break;
            case 1504578661:
                if (p2.equals("audio/eac3")) {
                    v0 = 10;
                } else {
                }
                break;
            case 1504619009:
                if (p2.equals("audio/flac")) {
                    v0 = 11;
                } else {
                }
                break;
            case 1504831518:
                if (p2.equals("audio/mpeg")) {
                    v0 = 12;
                } else {
                }
                break;
            case 1504891608:
                if (p2.equals("audio/opus")) {
                    v0 = 13;
                } else {
                }
                break;
            case 1505942594:
                if (p2.equals("audio/vnd.dts.hd")) {
                    v0 = 14;
                } else {
                }
                break;
            case 1556697186:
                if (p2.equals("audio/true-hd")) {
                    v0 = 15;
                } else {
                }
                break;
            case 1903231877:
                if (p2.equals("audio/g711-alaw")) {
                    v0 = 16;
                } else {
                }
                break;
            case 1903589369:
                if (p2.equals("audio/g711-mlaw")) {
                    v0 = 17;
                } else {
                }
                break;
            default:
        }
        switch (v0) {
            case 0:
            case 10:
                return "eac3";
            case 1:
                return "amrwb";
            case 2:
            case 14:
                return "dca";
            case 3:
                return "vorbis";
            case 4:
            case 5:
            case 12:
                return "mp3";
            case 6:
                return "aac";
            case 7:
                return "ac3";
            case 8:
                return "amrnb";
            case 9:
                return "alac";
            case 11:
                return "flac";
            case 13:
                return "opus";
            case 15:
                return "truehd";
            case 16:
                return "pcm_alaw";
            case 17:
                return "pcm_mulaw";
            default:
                return 0;
        }
    }

    public static int d()
    {
        if (com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.f()) {
            if (com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.d == -1) {
                com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.d = 64;
            }
            return com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.d;
        } else {
            return -1;
        }
    }

    public static String e()
    {
        if (com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.f()) {
            try {
                if (com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.c == null) {
                    com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.c = com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.a();
                }
            } catch (Error) {
                return 0;
            }
            return com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.c;
        } else {
            return 0;
        }
    }

    private static native String exFfmpegGetVersion();

    private static native boolean exFfmpegHasDecoder();

    public static boolean f()
    {
        if ((!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.a) && (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.b)) {
            return 0;
        } else {
            return 1;
        }
    }

    private static native String fmFfmpegGetVersion();

    private static native boolean fmFfmpegHasDecoder();

    public static boolean g()
    {
        return com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.a;
    }

    public static boolean h()
    {
        return com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.b;
    }

    public static void i(boolean p0)
    {
        com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.a = p0;
        return;
    }

    public static void j(boolean p0)
    {
        com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.b = p0;
        return;
    }

    public static boolean k(String p4)
    {
        if (com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.f()) {
            int v4_4 = com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.c(p4);
            if (v4_4 != 0) {
                try {
                    if (com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.b(v4_4)) {
                        return 1;
                    } else {
                        StringBuilder v2_1 = new StringBuilder();
                        v2_1.append("No ");
                        v2_1.append(v4_4);
                        v2_1.append(" decoder available. Check the FFmpeg build configuration.");
                        ax.S0.u.h("FfmpegLibrary", v2_1.toString());
                        return 0;
                    }
                } catch (Error) {
                    return 0;
                }
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }
}
