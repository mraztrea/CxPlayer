# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$h;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$h;
.super Ljava/lang/Object;

# Fields
.field a:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$h;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method a(Z)V
    .registers 3
    const/4 v0, 1
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R(Z)Z
    if-nez v2, +006h
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->U(Z)Z
    return-void 
    const/4 v2, 0
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->U(Z)Z
    return-void 
.end method
