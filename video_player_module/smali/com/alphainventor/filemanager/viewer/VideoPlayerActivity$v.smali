# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;
# Superclass: Lax/q3/q;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;
.super Lax/q3/q;

# Fields
.field h:I
.field i:Z
.field j:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I Z)V
    .registers 4
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    sget-object v1, Lax/q3/q$e;->d0 Lax/q3/q$e;
    invoke-direct v0, v1, Lax/q3/q;-><init>(Lax/q3/q$e;)V
    iput v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->h I
    iput-boolean v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->i Z
    return-void 
.end method

.method w(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->z()V
    return-void 
.end method

.method z()V
    .registers 4
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-virtual v0, Landroid/app/Activity;->isDestroyed()Z
    move-result v0
    if-eqz v0, +003h
    goto +12h
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v0
    if-nez v0, +003h
    goto +9h
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Lax/P0/y;
    move-result-object v0
    if-nez v0, +003h
    return-void 
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v0
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Lax/P0/y;
    move-result-object v1
    iget-boolean v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->i Z
    invoke-interface v0, v1, v2, Lax/P0/H;->w(Lax/P0/y; Z)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v0
    invoke-interface v0, Lax/P0/H;->k()V
    return-void 
    move-exception v0
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const v2, 2131951922
    invoke-static v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)V
    const-string v1, "EXOPLAYER ILLEGALSTATE"
    invoke-static v1, v0, Lax/K2/d;->c(Ljava/lang/String; Ljava/lang/Throwable;)V
    return-void 
.end method

.method g([Ljava/lang/Object;)Ljava/lang/Object;
    .registers 2
    check-cast v1, [Ljava/lang/Void;
    invoke-virtual v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->x([Ljava/lang/Void;)Ljava/lang/Boolean;
    move-result-object v1
    return-object v1
.end method

.method o()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v0
    const/16 v1, 8
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method q(Ljava/lang/Object;)V
    .registers 2
    check-cast v1, Ljava/lang/Boolean;
    invoke-virtual v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->y(Ljava/lang/Boolean;)V
    return-void 
.end method

.method r()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v0
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method x([Ljava/lang/Void;)Ljava/lang/Boolean;
    .registers 3
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    iget v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->h I
    invoke-static v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)Lax/P0/y;
    move-result-object v0
    invoke-static v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lax/P0/y;)Lax/P0/y;
    sget-object v2, Ljava/lang/Boolean;->TRUE Ljava/lang/Boolean;
    return-object v2
    sget-object v2, Ljava/lang/Boolean;->FALSE Ljava/lang/Boolean;
    return-object v2
.end method

.method y(Ljava/lang/Boolean;)V
    .registers 4
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v0
    const/16 v1, 8
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    invoke-virtual v3, Ljava/lang/Boolean;->booleanValue()Z
    move-result v3
    if-nez v3, +00bh
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const v0, 2131951922
    invoke-static v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)V
    return-void 
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v3
    if-nez v3, +003h
    return-void 
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v3
    if-eqz v3, +006h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->z()V
    return-void 
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;->j Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v$a;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v$a;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;)V
    invoke-static v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Ljava/lang/Runnable;)Ljava/lang/Runnable;
    return-void 
.end method
