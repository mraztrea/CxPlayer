# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;
.super Ljava/lang/Object;

# Fields
.field a:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method surfaceChanged(Landroid/view/SurfaceHolder; I I I)V
    .registers 5
    return-void 
.end method

.method surfaceCreated(Landroid/view/SurfaceHolder;)V
    .registers 3
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v0, 1
    invoke-static v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Ljava/lang/Runnable;
    move-result-object v2
    if-eqz v2, +011h
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Ljava/lang/Runnable;
    move-result-object v2
    invoke-interface v2, Ljava/lang/Runnable;->run()V
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v0, 0
    invoke-static v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Ljava/lang/Runnable;)Ljava/lang/Runnable;
    return-void 
.end method

.method surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .registers 3
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v0, 0
    invoke-static v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    return-void 
.end method
