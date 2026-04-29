# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$r;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$r;
.super Ljava/lang/Object;

# Fields
.field a:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$r;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method a(Landroid/view/MotionEvent;)V
    .registers 2
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$r;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v1
    if-eqz v1, +003h
    goto +9h
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$r;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lax/p3/m;->q(Landroid/content/Context;)Z
    move-result v1
    if-nez v1, +003h
    return-void 
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$r;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method
