# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;
# Superclass: Lax/q3/q;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;
.super Lax/q3/q;

# Fields
.field h:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->h Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    sget-object v1, Lax/q3/q$e;->e0 Lax/q3/q$e;
    invoke-direct v0, v1, Lax/q3/q;-><init>(Lax/q3/q$e;)V
    return-void 
.end method

.method g([Ljava/lang/Object;)Ljava/lang/Object;
    .registers 2
    check-cast v1, [Ljava/lang/Void;
    invoke-virtual v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->w([Ljava/lang/Void;)Ljava/lang/Boolean;
    move-result-object v1
    return-object v1
.end method

.method o()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->h Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v0
    const/16 v1, 8
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method q(Ljava/lang/Object;)V
    .registers 2
    check-cast v1, Ljava/lang/Boolean;
    invoke-virtual v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->x(Ljava/lang/Boolean;)V
    return-void 
.end method

.method r()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->h Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v0
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    invoke-super v2, Lax/q3/q;->r()V
    return-void 
.end method

.method w([Ljava/lang/Void;)Ljava/lang/Boolean;
    .registers 2
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->h Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lax/s3/f;->d(Landroid/content/Context;)Z
    move-result v1
    invoke-static v1, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;
    move-result-object v1
    return-object v1
.end method

.method x(Ljava/lang/Boolean;)V
    .registers 4
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->h Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v0
    const/16 v1, 8
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    invoke-virtual v3, Ljava/lang/Boolean;->booleanValue()Z
    move-result v3
    if-eqz v3, +00dh
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->h Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v3, Lax/s3/f;->n(Landroid/content/Context;)Z
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->h Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-virtual v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z3()V
    return-void 
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;->h Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const v0, 2131951922
    invoke-static v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)V
    return-void 
.end method
