# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;
.super Ljava/lang/Object;

# Fields
.field a:J
.field b:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method G(Landroidx/media3/ui/G; J)V
    .registers 4
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v1
    if-nez v1, +009h
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iput-wide v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->a J
    return-void 
.end method

.method T(Landroidx/media3/ui/G; J)V
    .registers 8
    iget-object v5, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    iget-wide v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->a J
    const/4 v2, 0
    cmp-long v3, v0, v6
    if-lez v3, +004h
    const/4 v0, 1
    goto +2h
    const/4 v0, 0
    invoke-static v5, v6, v7, v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; J Z Z)V
    iput-wide v6, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->a J
    return-void 
.end method

.method W(Landroidx/media3/ui/G; J Z)V
    .registers 5
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v1
    if-eqz v1, +00ch
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; J)J
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method
