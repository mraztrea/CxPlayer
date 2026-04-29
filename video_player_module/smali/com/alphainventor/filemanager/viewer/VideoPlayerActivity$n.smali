# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$n;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$n;
.super Ljava/lang/Object;

# Fields
.field a:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$n;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method onSystemUiVisibilityChange(I)V
    .registers 3
    if-nez v2, +012h
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$n;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v2
    const/16 v0, 3846
    if-ne v2, v0, +008h
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$n;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v0, 0
    invoke-virtual v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I3(Z)V
    return-void 
.end method
