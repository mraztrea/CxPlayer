# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y$a;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y$a;
.super Ljava/lang/Object;

# Fields
.field q:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y$a;->q Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method run()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y$a;->q Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a Landroid/app/Activity;
    invoke-virtual v0, Landroid/app/Activity;->isFinishing()Z
    move-result v0
    if-eqz v0, +003h
    return-void 
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y$a;->q Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a Landroid/app/Activity;
    const/4 v1, -1
    invoke-virtual v0, v1, Landroid/app/Activity;->setRequestedOrientation(I)V
    return-void 
.end method
