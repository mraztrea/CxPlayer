# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$o;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$o;
.super Ljava/lang/Object;

# Fields
.field a:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$o;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method a(Ljava/lang/String; Landroid/os/Bundle;)V
    .registers 3
    const-string v1, "result"
    invoke-virtual v2, v1, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, +024h
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$o;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    iget-boolean v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H1 Z
    if-eqz v2, +01eh
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v1
    if-eqz v1, +018h
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$o;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v1
    invoke-interface v1, Lax/P0/H;->b()Z
    move-result v1
    if-nez v1, +00ch
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$o;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v1
    const/4 v2, 1
    invoke-interface v1, v2, Lax/P0/H;->L(Z)V
    return-void 
.end method
