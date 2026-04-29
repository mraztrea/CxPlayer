# Class: Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
# Superclass: Ljava/lang/Object;

.class Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
.super Ljava/lang/Object;

# Fields
.field a:Z

# Methods

.method <init>(Z)V
    .registers 2
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    iput-boolean v1, v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->a Z
    return-void 
.end method

.method exFfmpegDecode(J Ljava/nio/ByteBuffer; I Ljava/nio/ByteBuffer; I I)I
.end method

.method exFfmpegGetChannelCount(J)I
.end method

.method exFfmpegGetSampleRate(J)I
.end method

.method exFfmpegInitialize(Ljava/lang/String; [B Z I I)J
.end method

.method exFfmpegRelease(J)V
.end method

.method exFfmpegReset(J [B)J
.end method

.method fmFfmpegDecode(J Ljava/nio/ByteBuffer; I Ljava/nio/ByteBuffer; I I)I
.end method

.method fmFfmpegGetChannelCount(J)I
.end method

.method fmFfmpegGetSampleRate(J)I
.end method

.method fmFfmpegInitialize(Ljava/lang/String; [B Z I I)J
.end method

.method fmFfmpegRelease(J)V
.end method

.method fmFfmpegReset(J [B)J
.end method

.method a(J Ljava/nio/ByteBuffer; I Ljava/nio/ByteBuffer; I I)I
    .registers 9
    iget-boolean v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->a Z
    if-eqz v0, +007h
    invoke-direct/range v1 ... v8, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->exFfmpegDecode(J Ljava/nio/ByteBuffer; I Ljava/nio/ByteBuffer; I I)I
    move-result v2
    return v2
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->h()Z
    move-result v0
    if-eqz v0, +007h
    invoke-direct/range v1 ... v8, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->fmFfmpegDecode(J Ljava/nio/ByteBuffer; I Ljava/nio/ByteBuffer; I I)I
    move-result v2
    return v2
    const/4 v2, -2
    return v2
.end method

.method b(J)I
    .registers 4
    iget-boolean v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->a Z
    if-eqz v0, +007h
    invoke-direct v1, v2, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->exFfmpegGetChannelCount(J)I
    move-result v2
    return v2
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->h()Z
    move-result v0
    if-eqz v0, +007h
    invoke-direct v1, v2, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->fmFfmpegGetChannelCount(J)I
    move-result v2
    return v2
    const/4 v2, 0
    return v2
.end method

.method c(J)I
    .registers 4
    iget-boolean v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->a Z
    if-eqz v0, +007h
    invoke-direct v1, v2, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->exFfmpegGetSampleRate(J)I
    move-result v2
    return v2
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->h()Z
    move-result v0
    if-eqz v0, +007h
    invoke-direct v1, v2, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->fmFfmpegGetSampleRate(J)I
    move-result v2
    return v2
    const/4 v2, 0
    return v2
.end method

.method d(Ljava/lang/String; [B Z I I)J
    .registers 7
    iget-boolean v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->a Z
    if-eqz v0, +007h
    invoke-direct/range v1 ... v6, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->exFfmpegInitialize(Ljava/lang/String; [B Z I I)J
    move-result-wide v2
    return-wide v2
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->h()Z
    move-result v0
    if-eqz v0, +007h
    invoke-direct/range v1 ... v6, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->fmFfmpegInitialize(Ljava/lang/String; [B Z I I)J
    move-result-wide v2
    return-wide v2
    const-wide/16 v2, 0
    return-wide v2
.end method

.method e(J)V
    .registers 4
    iget-boolean v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->a Z
    if-eqz v0, +006h
    invoke-direct v1, v2, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->exFfmpegRelease(J)V
    return-void 
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->h()Z
    move-result v0
    if-eqz v0, +005h
    invoke-direct v1, v2, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->fmFfmpegRelease(J)V
    return-void 
.end method

.method f(J [B)J
    .registers 5
    iget-boolean v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->a Z
    if-eqz v0, +007h
    invoke-direct v1, v2, v3, v4, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->exFfmpegReset(J [B)J
    move-result-wide v2
    return-wide v2
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->h()Z
    move-result v0
    if-eqz v0, +007h
    invoke-direct v1, v2, v3, v4, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->fmFfmpegReset(J [B)J
    move-result-wide v2
    return-wide v2
    const-wide/16 v2, 0
    return-wide v2
.end method
