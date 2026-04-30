package com.google.android.exoplayer2.ext.ffmpeg;

import androidx.annotation.Nullable;
import java.nio.ByteBuffer;

public final class FfmpegDecoder {
    private final boolean useExDecoder;

    public FfmpegDecoder(boolean useExDecoder) {
        this.useExDecoder = useExDecoder;
    }

    public int decode(
            long context,
            ByteBuffer inputData,
            int inputSize,
            ByteBuffer outputData,
            int outputSize,
            int outputMode) {
        if (useExDecoder) {
            return exFfmpegDecode(context, inputData, inputSize, outputData, outputSize, outputMode);
        }
        if (!FfmpegLibrary.isFmAvailable()) {
            return -2;
        }
        return fmFfmpegDecode(context, inputData, inputSize, outputData, outputSize, outputMode);
    }

    public int getChannelCount(long context) {
        if (useExDecoder) {
            return exFfmpegGetChannelCount(context);
        }
        if (!FfmpegLibrary.isFmAvailable()) {
            return 0;
        }
        return fmFfmpegGetChannelCount(context);
    }

    public int getSampleRate(long context) {
        if (useExDecoder) {
            return exFfmpegGetSampleRate(context);
        }
        if (!FfmpegLibrary.isFmAvailable()) {
            return 0;
        }
        return fmFfmpegGetSampleRate(context);
    }

    public long initialize(
            String codecName,
            @Nullable byte[] extraData,
            boolean outputFloat,
            int rawSampleRate,
            int rawChannelCount) {
        if (useExDecoder) {
            return exFfmpegInitialize(codecName, extraData, outputFloat, rawSampleRate, rawChannelCount);
        }
        if (!FfmpegLibrary.isFmAvailable()) {
            return 0L;
        }
        return fmFfmpegInitialize(codecName, extraData, outputFloat, rawSampleRate, rawChannelCount);
    }

    public void release(long context) {
        if (useExDecoder) {
            exFfmpegRelease(context);
            return;
        }
        if (FfmpegLibrary.isFmAvailable()) {
            fmFfmpegRelease(context);
        }
    }

    public long reset(long context, @Nullable byte[] extraData) {
        if (useExDecoder) {
            return exFfmpegReset(context, extraData);
        }
        if (!FfmpegLibrary.isFmAvailable()) {
            return 0L;
        }
        return fmFfmpegReset(context, extraData);
    }

    private native int exFfmpegDecode(
            long context,
            ByteBuffer inputData,
            int inputSize,
            ByteBuffer outputData,
            int outputSize,
            int outputMode);

    private native int exFfmpegGetChannelCount(long context);

    private native int exFfmpegGetSampleRate(long context);

    private native long exFfmpegInitialize(
            String codecName,
            @Nullable byte[] extraData,
            boolean outputFloat,
            int rawSampleRate,
            int rawChannelCount);

    private native void exFfmpegRelease(long context);

    private native long exFfmpegReset(long context, @Nullable byte[] extraData);

    private native int fmFfmpegDecode(
            long context,
            ByteBuffer inputData,
            int inputSize,
            ByteBuffer outputData,
            int outputSize,
            int outputMode);

    private native int fmFfmpegGetChannelCount(long context);

    private native int fmFfmpegGetSampleRate(long context);

    private native long fmFfmpegInitialize(
            String codecName,
            @Nullable byte[] extraData,
            boolean outputFloat,
            int rawSampleRate,
            int rawChannelCount);

    private native void fmFfmpegRelease(long context);

    private native long fmFfmpegReset(long context, @Nullable byte[] extraData);
}