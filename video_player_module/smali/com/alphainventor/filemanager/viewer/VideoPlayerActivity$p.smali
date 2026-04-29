# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$p;
# Superclass: Lax/i/r;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$p;
.super Lax/i/r;

# Fields
.field d:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    .registers 3
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$p;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, v2, Lax/i/r;-><init>(Z)V
    return-void 
.end method

.method d()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$p;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/ui/PlayerView;
    move-result-object v0
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->V()V
    return-void 
.end method
