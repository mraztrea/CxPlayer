# Class: Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;
# Superclass: Ljava/lang/Object;

.class Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;
.super Ljava/lang/Object;

# Fields
.field a:Z
.field b:Z
.field c:Ljava/lang/String;
.field d:I

# Methods

.method <clinit>()V
    .registers 1
    const-string v0, "media3.decoder.ffmpeg"
    invoke-static v0, Lax/P0/z;->a(Ljava/lang/String;)V
    const/4 v0, -1
    sput v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->d I
    return-void 
.end method

.method a()Ljava/lang/String;
    .registers 1
    sget-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->a Z
    if-eqz v0, +007h
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->exFfmpegGetVersion()Ljava/lang/String;
    move-result-object v0
    return-object v0
    sget-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->b Z
    if-eqz v0, +007h
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->fmFfmpegGetVersion()Ljava/lang/String;
    move-result-object v0
    return-object v0
    const/4 v0, 0
    return-object v0
.end method

.method b(Ljava/lang/String;)Z
    .registers 2
    sget-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->a Z
    if-eqz v0, +007h
    invoke-static v1, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->exFfmpegHasDecoder(Ljava/lang/String;)Z
    move-result v1
    return v1
    sget-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->b Z
    if-eqz v0, +007h
    invoke-static v1, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->fmFfmpegHasDecoder(Ljava/lang/String;)Z
    move-result v1
    return v1
    const/4 v1, 0
    return v1
.end method

.method c(Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    invoke-virtual v2, Ljava/lang/Object;->getClass()Ljava/lang/Class;
    const/4 v0, -1
    invoke-virtual v2, Ljava/lang/String;->hashCode()I
    move-result v1
    sparse-switch v1, +0000118h
    goto/16 +0e5h
    const-string v1, "audio/g711-mlaw"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +0dbh
    const/16 v0, 17
    goto/16 +0d7h
    const-string v1, "audio/g711-alaw"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +0cdh
    const/16 v0, 16
    goto/16 +0c9h
    const-string v1, "audio/true-hd"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +0bfh
    const/16 v0, 15
    goto/16 +0bbh
    const-string v1, "audio/vnd.dts.hd"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +0b1h
    const/16 v0, 14
    goto/16 +0adh
    const-string v1, "audio/opus"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +0a3h
    const/16 v0, 13
    goto/16 +09fh
    const-string v1, "audio/mpeg"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +095h
    const/16 v0, 12
    goto/16 +091h
    const-string v1, "audio/flac"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +087h
    const/16 v0, 11
    goto/16 +083h
    const-string v1, "audio/eac3"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +079h
    const/16 v0, 10
    goto/16 +075h
    const-string v1, "audio/alac"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +06bh
    const/16 v0, 9
    goto/16 +067h
    const-string v1, "audio/3gpp"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +004h
    goto/16 +05dh
    const/16 v0, 8
    goto/16 +059h
    const-string v1, "audio/ac3"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +003h
    goto +4fh
    const/4 v0, 7
    goto +4dh
    const-string v1, "audio/mp4a-latm"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +003h
    goto +44h
    const/4 v0, 6
    goto +42h
    const-string v1, "audio/mpeg-L2"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +003h
    goto +39h
    const/4 v0, 5
    goto +37h
    const-string v1, "audio/mpeg-L1"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +003h
    goto +2eh
    const/4 v0, 4
    goto +2ch
    const-string v1, "audio/vorbis"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +003h
    goto +23h
    const/4 v0, 3
    goto +21h
    const-string v1, "audio/vnd.dts"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +003h
    goto +18h
    const/4 v0, 2
    goto +16h
    const-string v1, "audio/amr-wb"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +003h
    goto +dh
    const/4 v0, 1
    goto +bh
    const-string v1, "audio/eac3-joc"
    invoke-virtual v2, v1, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +003h
    goto +2h
    const/4 v0, 0
    packed-switch v0, +000007ah
    const/4 v2, 0
    return-object v2
    const-string v2, "pcm_mulaw"
    return-object v2
    const-string v2, "pcm_alaw"
    return-object v2
    const-string v2, "truehd"
    return-object v2
    const-string v2, "opus"
    return-object v2
    const-string v2, "flac"
    return-object v2
    const-string v2, "alac"
    return-object v2
    const-string v2, "amrnb"
    return-object v2
    const-string v2, "ac3"
    return-object v2
    const-string v2, "aac"
    return-object v2
    const-string v2, "mp3"
    return-object v2
    const-string v2, "vorbis"
    return-object v2
    const-string v2, "dca"
    return-object v2
    const-string v2, "amrwb"
    return-object v2
    const-string v2, "eac3"
    return-object v2
    nop 
    sparse-switch-payload -7e929daa -5fc6f775 -41455b98 -3bd43e14 -19cc928c -19cc928b -3313c2e b269698 59976a2d 59ac6426 59ae0c65 59aeaa01 59b1e81e 59b2d2d8 59c2dc42 5cc95062 71710385 717677f9
    packed-switch-payload 0 1 2 3 4 5 6 7 8 9 a b c d e f 10 11
.end method

.method d()I
    .registers 2
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->f()Z
    move-result v0
    const/4 v1, -1
    if-nez v0, +003h
    return v1
    sget v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->d I
    if-ne v0, v1, +006h
    const/16 v0, 64
    sput v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->d I
    sget v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->d I
    return v0
.end method

.method e()Ljava/lang/String;
    .registers 2
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->f()Z
    move-result v0
    const/4 v1, 0
    if-nez v0, +003h
    return-object v1
    sget-object v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->c Ljava/lang/String;
    if-nez v0, +008h
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->a()Ljava/lang/String;
    move-result-object v0
    sput-object v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->c Ljava/lang/String;
    sget-object v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->c Ljava/lang/String;
    return-object v0
    return-object v1
.end method

.method exFfmpegGetVersion()Ljava/lang/String;
.end method

.method exFfmpegHasDecoder(Ljava/lang/String;)Z
.end method

.method f()Z
    .registers 1
    sget-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->a Z
    if-nez v0, +009h
    sget-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->b Z
    if-eqz v0, +003h
    goto +3h
    const/4 v0, 0
    return v0
    const/4 v0, 1
    return v0
.end method

.method fmFfmpegGetVersion()Ljava/lang/String;
.end method

.method fmFfmpegHasDecoder(Ljava/lang/String;)Z
.end method

.method g()Z
    .registers 1
    sget-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->a Z
    return v0
.end method

.method h()Z
    .registers 1
    sget-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->b Z
    return v0
.end method

.method i(Z)V
    .registers 1
    sput-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->a Z
    return-void 
.end method

.method j(Z)V
    .registers 1
    sput-boolean v0, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->b Z
    return-void 
.end method

.method k(Ljava/lang/String;)Z
    .registers 5
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->f()Z
    move-result v0
    const/4 v1, 0
    if-nez v0, +003h
    return v1
    invoke-static v4, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->c(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v4
    if-nez v4, +003h
    return v1
    invoke-static v4, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->b(Ljava/lang/String;)Z
    move-result v0
    if-nez v0, +01eh
    const-string v0, "FfmpegLibrary"
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct v2, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "No "
    invoke-virtual v2, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v2, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v4, " decoder available. Check the FFmpeg build configuration."
    invoke-virtual v2, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v2, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static v0, v4, Lax/S0/u;->h(Ljava/lang/String; Ljava/lang/String;)V
    return v1
    const/4 v4, 1
    return v4
    return v1
.end method
