# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$b;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$b;
.super Ljava/lang/Object;

# Fields
.field q:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$b;->q Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method run()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$b;->q Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v0
    if-nez v0, +007h
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$b;->q Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method
