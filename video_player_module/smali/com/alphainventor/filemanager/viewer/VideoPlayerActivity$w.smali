# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;
.super Ljava/lang/Object;

# Fields
.field a:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;)V
    .registers 3
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method a(Ljava/lang/Throwable;)Landroid/util/Pair;
    .registers 2
    check-cast v1, Lax/P0/F;
    invoke-virtual v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;->b(Lax/P0/F;)Landroid/util/Pair;
    move-result-object v1
    return-object v1
.end method

.method b(Lax/P0/F;)Landroid/util/Pair;
    .registers 5
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const v1, 2131951953
    invoke-virtual v0, v1, Landroid/content/Context;->getString(I)Ljava/lang/String;
    move-result-object v0
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lax/p3/k;->m(Landroid/content/Context;)Z
    move-result v1
    if-eqz v1, +040h
    instance-of v1, v4, Landroidx/media3/exoplayer/s;
    const-string v2, ":"
    if-eqz v1, +024h
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct v1, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v1, v0, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, v2, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-object v0, v4
    check-cast v0, Landroidx/media3/exoplayer/s;
    iget v0, v0, Landroidx/media3/exoplayer/s;->k0 I
    invoke-virtual v1, v0, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual v1, v2, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v4, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;
    move-result-object v0
    invoke-virtual v1, v0, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    goto +17h
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct v1, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v1, v0, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, v2, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v4, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;
    move-result-object v0
    invoke-virtual v1, v0, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    instance-of v1, v4, Landroidx/media3/exoplayer/s;
    if-eqz v1, +03ch
    check-cast v4, Landroidx/media3/exoplayer/s;
    iget v1, v4, Landroidx/media3/exoplayer/s;->k0 I
    if-nez v1, +003h
    goto +34h
    const/4 v2, 1
    if-ne v1, v2, +032h
    invoke-virtual v4, Landroidx/media3/exoplayer/s;->h()Ljava/lang/Exception;
    move-result-object v4
    instance-of v1, v4, Lax/c1/L$c;
    if-eqz v1, +02ah
    check-cast v4, Lax/c1/L$c;
    iget-boolean v0, v4, Lax/c1/L$c;->c0 Z
    if-eqz v0, +01ch
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct v1, Ljava/lang/StringBuilder;-><init>()V
    iget-object v4, v4, Lax/c1/L$c;->q Ljava/lang/String;
    invoke-virtual v1, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v4, ":secure"
    invoke-virtual v1, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    goto +9h
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    iget-object v4, v4, Lax/c1/L$c;->q Ljava/lang/String;
    invoke-static v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    const/4 v4, 0
    invoke-static v4, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v4
    invoke-static v4, v0, Landroid/util/Pair;->create(Ljava/lang/Object; Ljava/lang/Object;)Landroid/util/Pair;
    move-result-object v4
    return-object v4
.end method
