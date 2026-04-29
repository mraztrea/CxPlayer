# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
# Superclass: Landroid/view/OrientationEventListener;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
.super Landroid/view/OrientationEventListener;

# Fields
.field a:Landroid/app/Activity;
.field b:Landroid/os/Handler;
.field c:Z

# Methods

.method <init>(Landroid/app/Activity; Landroid/os/Handler;)V
    .registers 3
    invoke-direct v0, v1, Landroid/view/OrientationEventListener;-><init>(Landroid/content/Context;)V
    iput-object v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->b Landroid/os/Handler;
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a Landroid/app/Activity;
    return-void 
.end method

.method a(I I)Z
    .registers 4
    add-int/lit8 v0, v3, -10
    if-le v2, v0, +008h
    add-int/lit8 v3, v3, 10
    if-ge v2, v3, +004h
    const/4 v2, 1
    return v2
    const/4 v2, 0
    return v2
.end method

.method b(I)Z
    .registers 3
    const/16 v0, 90
    invoke-direct v1, v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a(I I)Z
    move-result v0
    if-nez v0, +00dh
    const/16 v0, 270
    invoke-direct v1, v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a(I I)Z
    move-result v2
    if-eqz v2, +003h
    goto +3h
    const/4 v2, 0
    return v2
    const/4 v2, 1
    return v2
.end method

.method c(I)Z
    .registers 4
    const/4 v0, 0
    invoke-direct v2, v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a(I I)Z
    move-result v1
    if-nez v1, +00ch
    const/16 v1, 180
    invoke-direct v2, v3, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a(I I)Z
    move-result v3
    if-eqz v3, +003h
    goto +2h
    return v0
    const/4 v3, 1
    return v3
.end method

.method d()V
    .registers 6
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a Landroid/app/Activity;
    invoke-virtual v0, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
    move-result-object v0
    invoke-virtual v0, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;
    move-result-object v0
    iget v0, v0, Landroid/content/res/Configuration;->orientation I
    const/4 v1, 2
    const/4 v2, 1
    const/4 v3, 0
    if-ne v0, v1, +00ah
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a Landroid/app/Activity;
    const/4 v1, 7
    invoke-virtual v0, v1, Landroid/app/Activity;->setRequestedOrientation(I)V
    const/4 v0, 0
    goto +8h
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a Landroid/app/Activity;
    const/4 v1, 6
    invoke-virtual v0, v1, Landroid/app/Activity;->setRequestedOrientation(I)V
    const/4 v0, 1
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->a Landroid/app/Activity;
    invoke-virtual v1, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v1
    const-string v4, "accelerometer_rotation"
    invoke-static v1, v4, v3, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver; Ljava/lang/String; I)I
    move-result v1
    if-ne v1, v2, +005h
    invoke-virtual v5, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->e(Z)V
    return-void 
.end method

.method e(Z)V
    .registers 2
    iput-boolean v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->c Z
    invoke-virtual v0, Landroid/view/OrientationEventListener;->enable()V
    return-void 
.end method

.method onOrientationChanged(I)V
    .registers 5
    iget-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->c Z
    if-eqz v0, +008h
    invoke-direct v3, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->b(I)Z
    move-result v0
    if-nez v0, +00ch
    iget-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->c Z
    if-nez v0, +017h
    invoke-direct v3, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->c(I)Z
    move-result v4
    if-eqz v4, +011h
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->b Landroid/os/Handler;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y$a;
    invoke-direct v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y$a;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;)V
    const-wide/16 v1, 2000
    invoke-virtual v4, v0, v1, v2, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable; J)Z
    invoke-virtual v3, Landroid/view/OrientationEventListener;->disable()V
    return-void 
.end method
