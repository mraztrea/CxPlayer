// Decompiled from: Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
// Package: com.google.android.exoplayer2.ext.ffmpeg

package com.google.android.exoplayer2.ext.ffmpeg;
public class FfmpegDecoder {
    boolean a;

    FfmpegDecoder(boolean p1)
    {
        this.a = p1;
        return;
    }

    private native int exFfmpegDecode();

    private native int exFfmpegGetChannelCount();

    private native int exFfmpegGetSampleRate();

    private native long exFfmpegInitialize();

    private native void exFfmpegRelease();

    private native long exFfmpegReset();

    private native int fmFfmpegDecode();

    private native int fmFfmpegGetChannelCount();

    private native int fmFfmpegGetSampleRate();

    private native long fmFfmpegInitialize();

    private native void fmFfmpegRelease();

    private native long fmFfmpegReset();

    int a(long p2, java.nio.ByteBuffer p4, int p5, java.nio.ByteBuffer p6, int p7, int p8)
    {
        if (!this.a) {
            if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.h()) {
                return -2;
            } else {
                return this.fmFfmpegDecode(p2, p4, p5, p6, p7, p8);
            }
        } else {
            return this.exFfmpegDecode(p2, p4, p5, p6, p7, p8);
        }
    }

    int b(long p2)
    {
        if (!this.a) {
            if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.h()) {
                return 0;
            } else {
                return this.fmFfmpegGetChannelCount(p2);
            }
        } else {
            return this.exFfmpegGetChannelCount(p2);
        }
    }

    int c(long p2)
    {
        if (!this.a) {
            if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.h()) {
                return 0;
            } else {
                return this.fmFfmpegGetSampleRate(p2);
            }
        } else {
            return this.exFfmpegGetSampleRate(p2);
        }
    }

    long d(String p2, byte[] p3, boolean p4, int p5, int p6)
    {
        if (!this.a) {
            if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.h()) {
                return 0;
            } else {
                return this.fmFfmpegInitialize(p2, p3, p4, p5, p6);
            }
        } else {
            return this.exFfmpegInitialize(p2, p3, p4, p5, p6);
        }
    }

    void e(long p2)
    {
        if (!this.a) {
            if (com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.h()) {
                this.fmFfmpegRelease(p2);
            }
            return;
        } else {
            this.exFfmpegRelease(p2);
            return;
        }
    }

    long f(long p2, byte[] p4)
    {
        if (!this.a) {
            if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.h()) {
                return 0;
            } else {
                return this.fmFfmpegReset(p2, p4);
            }
        } else {
            return this.exFfmpegReset(p2, p4);
        }
    }
}
