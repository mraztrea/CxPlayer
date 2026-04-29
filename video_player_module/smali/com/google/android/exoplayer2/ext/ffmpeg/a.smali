# Class: Lcom/google/android/exoplayer2/ext/ffmpeg/a;
# Superclass: Lax/V0/k;

.class Lcom/google/android/exoplayer2/ext/ffmpeg/a;
.super Lax/V0/k;

# Fields
.field o:Ljava/lang/String;
.field p:[B
.field q:I
.field r:I
.field s:J
.field t:Z
.field u:I
.field v:I
.field w:I
.field x:Z
.field y:Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;

# Methods

.method <init>(Z Lax/P0/v; I I I Z I)V
    .registers 15
    const-string v0, "Initialization failed."
    new-array v10, v10, [Lax/V0/i;
    new-array v11, v11, [Lax/V0/l;
    invoke-direct v7, v10, v11, Lax/V0/k;-><init>([Lax/V0/i; [Lax/V0/j;)V
    iput-boolean v8, v7, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->x Z
    new-instance v10, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
    invoke-direct v10, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;-><init>(Z)V
    iput-object v10, v7, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->y Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->f()Z
    move-result v8
    if-eqz v8, +05dh
    iget-object v8, v9, Lax/P0/v;->o Ljava/lang/String;
    if-eqz v8, +04bh
    invoke-static v8, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->c(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    iput-object v2, v7, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->o Ljava/lang/String;
    if-eqz v2, +03bh
    iget-object v8, v9, Lax/P0/v;->o Ljava/lang/String;
    iget-object v10, v9, Lax/P0/v;->r Ljava/util/List;
    invoke-static v8, v10, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->F(Ljava/lang/String; Ljava/util/List;)[B
    move-result-object v3
    iput-object v3, v7, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->p [B
    if-eqz v13, +004h
    const/4 v8, 4
    goto +2h
    const/4 v8, 2
    iput v8, v7, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->q I
    if-eqz v13, +005h
    const/high16 v8, 131072
    goto +3h
    const/high16 v8, 65536
    iput v8, v7, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->r I
    iget-object v1, v7, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->y Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
    iget v5, v9, Lax/P0/v;->H I
    iget v6, v9, Lax/P0/v;->G I
    move v4, v13
    invoke-virtual/range v1 ... v6, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->d(Ljava/lang/String; [B Z I I)J
    move-result-wide v8
    iput-wide v8, v7, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->s J
    const-wide/16 v10, 0
    cmp-long v13, v8, v10
    if-eqz v13, +008h
    iput v14, v7, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->w I
    invoke-virtual v7, v12, Lax/V0/k;->x(I)V
    return-void 
    new-instance v8, Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    invoke-direct v8, v0, Lcom/google/android/exoplayer2/ext/ffmpeg/b;-><init>(Ljava/lang/String;)V
    throw v8
    new-instance v8, Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    const-string v9, "audio decoder codecName null."
    invoke-direct v8, v9, Lcom/google/android/exoplayer2/ext/ffmpeg/b;-><init>(Ljava/lang/String;)V
    throw v8
    new-instance v8, Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    const-string v9, "audio decoder sample mime type null."
    invoke-direct v8, v9, Lcom/google/android/exoplayer2/ext/ffmpeg/b;-><init>(Ljava/lang/String;)V
    throw v8
    new-instance v8, Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    invoke-direct v8, v0, Lcom/google/android/exoplayer2/ext/ffmpeg/b;-><init>(Ljava/lang/String;)V
    throw v8
    new-instance v8, Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    const-string v9, "Failed to load decoder native libraries."
    invoke-direct v8, v9, Lcom/google/android/exoplayer2/ext/ffmpeg/b;-><init>(Ljava/lang/String;)V
    throw v8
.end method

.method C(Ljava/util/List;)[B
    .registers 4
    const/4 v0, 0
    invoke-interface v3, v0, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v3
    check-cast v3, [B
    array-length v1, v3
    add-int/lit8 v1, v1, 12
    invoke-static v1, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;
    move-result-object v2
    invoke-virtual v2, v1, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;
    const v1, 1634492771
    invoke-virtual v2, v1, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;
    invoke-virtual v2, v0, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;
    array-length v1, v3
    invoke-virtual v2, v3, v0, v1, Ljava/nio/ByteBuffer;->put([B I I)Ljava/nio/ByteBuffer;
    invoke-virtual v2, Ljava/nio/ByteBuffer;->array()[B
    move-result-object v3
    return-object v3
.end method

.method F(Ljava/lang/String; Ljava/util/List;)[B
    .registers 5
    const/4 v0, 0
    invoke-virtual v3, Ljava/lang/Object;->getClass()Ljava/lang/Class;
    const/4 v1, -1
    invoke-virtual v3, Ljava/lang/String;->hashCode()I
    move-result v2
    sparse-switch v2, +0000045h
    goto +2ch
    const-string v2, "audio/opus"
    invoke-virtual v3, v2, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-nez v3, +003h
    goto +23h
    const/4 v1, 3
    goto +21h
    const-string v2, "audio/alac"
    invoke-virtual v3, v2, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-nez v3, +003h
    goto +18h
    const/4 v1, 2
    goto +16h
    const-string v2, "audio/mp4a-latm"
    invoke-virtual v3, v2, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-nez v3, +003h
    goto +dh
    const/4 v1, 1
    goto +bh
    const-string v2, "audio/vorbis"
    invoke-virtual v3, v2, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-nez v3, +003h
    goto +2h
    const/4 v1, 0
    packed-switch v1, +0000028h
    const/4 v3, 0
    return-object v3
    invoke-static v4, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->C(Ljava/util/List;)[B
    move-result-object v3
    return-object v3
    invoke-interface v4, v0, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v3
    check-cast v3, [B
    return-object v3
    invoke-static v4, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->I(Ljava/util/List;)[B
    move-result-object v3
    return-object v3
    sparse-switch-payload -3bd43e14 -3313c2e 59ac6426 59b2d2d8
    packed-switch-payload 0 1 2 3
.end method

.method I(Ljava/util/List;)[B
    .registers 6
    const/4 v0, 0
    invoke-interface v5, v0, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, [B
    const/4 v2, 1
    invoke-interface v5, v2, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v5
    check-cast v5, [B
    array-length v3, v1
    array-length v4, v5
    add-int/2addr v3, v4
    add-int/lit8 v3, v3, 6
    new-array v3, v3, [B
    array-length v4, v1
    shr-int/lit8 v4, v4, 8
    int-to-byte v4, v4
    aput-byte v4, v3, v0
    array-length v4, v1
    and-int/lit16 v4, v4, 255
    int-to-byte v4, v4
    aput-byte v4, v3, v2
    array-length v2, v1
    const/4 v4, 2
    invoke-static v1, v0, v3, v4, v2, Ljava/lang/System;->arraycopy(Ljava/lang/Object; I Ljava/lang/Object; I I)V
    array-length v2, v1
    add-int/2addr v2, v4
    aput-byte v0, v3, v2
    array-length v2, v1
    add-int/lit8 v2, v2, 3
    aput-byte v0, v3, v2
    array-length v2, v1
    add-int/lit8 v2, v2, 4
    array-length v4, v5
    shr-int/lit8 v4, v4, 8
    int-to-byte v4, v4
    aput-byte v4, v3, v2
    array-length v2, v1
    add-int/lit8 v2, v2, 5
    array-length v4, v5
    and-int/lit16 v4, v4, 255
    int-to-byte v4, v4
    aput-byte v4, v3, v2
    array-length v1, v1
    add-int/lit8 v1, v1, 6
    array-length v2, v5
    invoke-static v5, v0, v3, v1, v2, Ljava/lang/System;->arraycopy(Ljava/lang/Object; I Ljava/lang/Object; I I)V
    return-object v3
.end method

.method y(Lcom/google/android/exoplayer2/ext/ffmpeg/a; Lax/V0/j;)V
    .registers 2
    invoke-virtual v0, v1, Lax/V0/k;->u(Lax/V0/j;)V
    return-void 
.end method

.method A(Ljava/lang/Throwable;)Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    .registers 4
    new-instance v0, Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    const-string v1, "Unexpected decode error"
    invoke-direct v0, v1, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/b;-><init>(Ljava/lang/String; Ljava/lang/Throwable;)V
    return-object v0
.end method

.method B(Lax/V0/i; Lax/V0/l; Z)Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    .registers 12
    if-eqz v11, +020h
    iget-object v11, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->y Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
    iget-wide v0, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->s J
    iget-object v2, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->p [B
    invoke-virtual v11, v0, v1, v2, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->f(J [B)J
    move-result-wide v0
    iput-wide v0, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->s J
    const-wide/16 v2, 0
    cmp-long v11, v0, v2
    if-nez v11, +00eh
    new-instance v9, Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    const-string v10, "Error resetting (see logcat)."
    invoke-direct v9, v10, Lcom/google/android/exoplayer2/ext/ffmpeg/b;-><init>(Ljava/lang/String;)V
    return-object v9
    move-exception v0
    move-object v9, v0
    goto/16 +08fh
    iget-object v11, v9, Lax/V0/i;->e0 Ljava/nio/ByteBuffer;
    invoke-static v11, Lax/S0/c0;->h(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v11
    move-object v3, v11
    check-cast v3, Ljava/nio/ByteBuffer;
    if-nez v3, +00ah
    new-instance v9, Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    const-string v10, "Input data null."
    invoke-direct v9, v10, Lcom/google/android/exoplayer2/ext/ffmpeg/b;-><init>(Ljava/lang/String;)V
    return-object v9
    invoke-virtual v3, Ljava/nio/Buffer;->limit()I
    move-result v4
    iget-wide v0, v9, Lax/V0/i;->g0 J
    iget v9, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->r I
    invoke-virtual v10, v0, v1, v9, Lax/V0/l;->C(J I)Ljava/nio/ByteBuffer;
    move-result-object v5
    iget-object v0, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->y Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
    iget-wide v1, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->s J
    iget v6, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->r I
    iget v7, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->w I
    invoke-virtual/range v0 ... v7, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->a(J Ljava/nio/ByteBuffer; I Ljava/nio/ByteBuffer; I I)I
    move-result v9
    const/4 v11, -2
    if-ne v9, v11, +00ah
    new-instance v9, Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    const-string v10, "Error decoding (see logcat)."
    invoke-direct v9, v10, Lcom/google/android/exoplayer2/ext/ffmpeg/b;-><init>(Ljava/lang/String;)V
    return-object v9
    const/4 v11, -1
    const/4 v0, 0
    const/4 v1, 1
    if-ne v9, v11, +005h
    iput-boolean v1, v10, Lax/V0/j;->e0 Z
    return-object v0
    if-nez v9, +005h
    iput-boolean v1, v10, Lax/V0/j;->e0 Z
    return-object v0
    iget-boolean v10, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->t Z
    if-nez v10, +040h
    iget-object v10, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->y Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
    iget-wide v2, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->s J
    invoke-virtual v10, v2, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->b(J)I
    move-result v10
    iput v10, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->u I
    iget-object v10, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->y Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
    iget-wide v2, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->s J
    invoke-virtual v10, v2, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->c(J)I
    move-result v10
    iput v10, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->v I
    iget v10, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->v I
    if-nez v10, +026h
    const-string v10, "alac"
    iget-object v11, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->o Ljava/lang/String;
    invoke-virtual v10, v11, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v10
    if-eqz v10, +01ch
    iget-object v10, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->p [B
    invoke-static v10, Lax/S0/a;->e(Ljava/lang/Object;)Ljava/lang/Object;
    new-instance v10, Lax/S0/G;
    iget-object v11, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->p [B
    invoke-direct v10, v11, Lax/S0/G;-><init>([B)V
    iget-object v11, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->p [B
    array-length v11, v11
    add-int/lit8 v11, v11, -4
    invoke-virtual v10, v11, Lax/S0/G;->b0(I)V
    invoke-virtual v10, Lax/S0/G;->Q()I
    move-result v10
    iput v10, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->v I
    iput-boolean v1, v8, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->t Z
    const/4 v10, 0
    invoke-virtual v5, v10, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;
    invoke-virtual v5, v9, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;
    return-object v0
    invoke-virtual v8, v9, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->A(Ljava/lang/Throwable;)Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    move-result-object v9
    return-object v9
.end method

.method D()I
    .registers 2
    iget v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->u I
    return v0
.end method

.method E()I
    .registers 2
    iget v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->q I
    return v0
.end method

.method G()I
    .registers 2
    iget v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->w I
    return v0
.end method

.method H()I
    .registers 2
    iget v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->v I
    return v0
.end method

.method d()V
    .registers 4
    invoke-super v3, Lax/V0/k;->d()V
    iget-object v0, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->y Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;
    iget-wide v1, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->s J
    invoke-virtual v0, v1, v2, Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegDecoder;->e(J)V
    const-wide/16 v0, 0
    iput-wide v0, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->s J
    return-void 
.end method

.method getName()Ljava/lang/String;
    .registers 3
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct v0, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "ffmpeg"
    invoke-virtual v0, v1, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->e()Ljava/lang/String;
    move-result-object v1
    invoke-virtual v0, v1, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "-"
    invoke-virtual v0, v1, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    iget-object v1, v2, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->o Ljava/lang/String;
    invoke-virtual v0, v1, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v0, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method j()Lax/V0/i;
    .registers 4
    new-instance v0, Lax/V0/i;
    const/4 v1, 2
    invoke-static Lcom/google/android/exoplayer2/ext/ffmpeg/FfmpegLibrary;->d()I
    move-result v2
    invoke-direct v0, v1, v2, Lax/V0/i;-><init>(I I)V
    return-object v0
.end method

.method k()Lax/V0/j;
    .registers 2
    invoke-virtual v1, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->z()Lax/V0/l;
    move-result-object v0
    return-object v0
.end method

.method l(Ljava/lang/Throwable;)Lax/V0/h;
    .registers 2
    invoke-virtual v0, v1, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->A(Ljava/lang/Throwable;)Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    move-result-object v1
    return-object v1
.end method

.method m(Lax/V0/i; Lax/V0/j; Z)Lax/V0/h;
    .registers 4
    check-cast v2, Lax/V0/l;
    invoke-virtual v0, v1, v2, v3, Lcom/google/android/exoplayer2/ext/ffmpeg/a;->B(Lax/V0/i; Lax/V0/l; Z)Lcom/google/android/exoplayer2/ext/ffmpeg/b;
    move-result-object v1
    return-object v1
.end method

.method z()Lax/V0/l;
    .registers 3
    new-instance v0, Lax/V0/l;
    new-instance v1, Lax/y5/a;
    invoke-direct v1, v2, Lax/y5/a;-><init>(Lcom/google/android/exoplayer2/ext/ffmpeg/a;)V
    invoke-direct v0, v1, Lax/V0/l;-><init>(Lax/V0/j$a;)V
    return-object v0
.end method
