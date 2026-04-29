# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;
# Superclass: Landroid/view/GestureDetector$SimpleOnGestureListener;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;
.super Landroid/view/GestureDetector$SimpleOnGestureListener;

# Fields
.field a:F
.field b:F
.field c:J
.field d:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Landroid/view/GestureDetector$SimpleOnGestureListener;-><init>()V
    return-void 
.end method

.method onDoubleTap(Landroid/view/MotionEvent;)Z
    .registers 9
    iget-object v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v0
    const/4 v1, 0
    if-nez v0, +003h
    return v1
    iget-object v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/ui/PlayerView;
    move-result-object v0
    invoke-virtual v0, Landroid/view/View;->getWidth()I
    move-result v0
    const/4 v2, 2
    const/4 v3, 3
    const/4 v4, 1
    if-lez v0, +037h
    div-int/lit8 v5, v0, 3
    mul-int/lit8 v0, v0, 2
    div-int/2addr v0, v3
    invoke-virtual v8, Landroid/view/MotionEvent;->getX()F
    move-result v6
    int-to-float v5, v5
    cmpg-float v5, v6, v5
    if-gez v5, +011h
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lax/p3/m;->r(Landroid/content/Context;)Z
    move-result v8
    if-nez v8, +003h
    return v1
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    return v4
    invoke-virtual v8, Landroid/view/MotionEvent;->getX()F
    move-result v8
    int-to-float v0, v0
    cmpl-float v8, v8, v0
    if-lez v8, +011h
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lax/p3/m;->r(Landroid/content/Context;)Z
    move-result v8
    if-nez v8, +003h
    return v1
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    return v4
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v8
    invoke-interface v8, Lax/P0/H;->i()I
    move-result v8
    if-eq v8, v2, +00eh
    if-ne v8, v3, +003h
    goto +ah
    const/4 v0, 4
    if-ne v8, v0, +00dh
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    goto +6h
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return v4
.end method

.method onDoubleTapEvent(Landroid/view/MotionEvent;)Z
    .registers 2
    const/4 v1, 1
    return v1
.end method

.method onDown(Landroid/view/MotionEvent;)Z
    .registers 2
    const/4 v1, 1
    return v1
.end method

.method onFling(Landroid/view/MotionEvent; Landroid/view/MotionEvent; F F)Z
    .registers 5
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v1
    const/4 v2, 0
    if-nez v1, +003h
    return v2
    invoke-static v3, Ljava/lang/Math;->abs(F)F
    move-result v1
    invoke-static v4, Ljava/lang/Math;->abs(F)F
    move-result v3
    cmpg-float v1, v1, v3
    if-gez v1, +003h
    return v2
    const/4 v1, 1
    return v1
.end method

.method onLongPress(Landroid/view/MotionEvent;)V
    .registers 2
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v1
    if-eqz v1, +003h
    goto +12h
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v1
    if-eqz v1, +003h
    goto +9h
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lax/p3/m;->p(Landroid/content/Context;)Z
    move-result v1
    if-nez v1, +003h
    return-void 
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method onScroll(Landroid/view/MotionEvent; Landroid/view/MotionEvent; F F)Z
    .registers 14
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v0
    const/4 v1, 0
    if-nez v0, +003h
    return v1
    if-eqz v10, +1f1h
    if-nez v11, +004h
    goto/16 +1edh
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v0
    const/4 v2, 1
    if-eqz v0, +015h
    iget-object v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v10
    if-nez v10, +00ch
    iget-object v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)F
    move-result v11
    invoke-static v10, v11, v12, v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; F F F)V
    return v2
    return v1
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v0
    if-eqz v0, +003h
    return v1
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v0
    if-nez v0, +109h
    invoke-virtual v11, Landroid/view/MotionEvent;->getPointerCount()I
    move-result v0
    if-le v0, v2, +003h
    return v1
    invoke-static v12, Ljava/lang/Math;->abs(F)F
    move-result v0
    invoke-static v13, Ljava/lang/Math;->abs(F)F
    move-result v13
    cmpg-float v13, v0, v13
    if-gez v13, +0bdh
    invoke-virtual v10, Landroid/view/MotionEvent;->getY()F
    move-result v13
    invoke-virtual v11, Landroid/view/MotionEvent;->getY()F
    move-result v0
    sub-float/2addr v13, v0
    invoke-static v13, Ljava/lang/Math;->abs(F)F
    move-result v13
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v0
    int-to-float v0, v0
    cmpg-float v13, v13, v0
    if-gez v13, +003h
    return v1
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v13
    invoke-virtual v13, Landroid/view/View;->getHeight()I
    move-result v13
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v0
    mul-int/lit8 v0, v0, 10
    if-ge v13, v0, +009h
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v13
    goto +28h
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v13
    invoke-virtual v13, Landroid/view/View;->getHeight()I
    move-result v13
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v0
    mul-int/lit8 v0, v0, 10
    if-ge v13, v0, +009h
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v13
    goto +dh
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v13
    invoke-virtual v13, Landroid/view/View;->getHeight()I
    move-result v13
    div-int/lit8 v13, v13, 10
    invoke-virtual v10, Landroid/view/MotionEvent;->getY()F
    move-result v0
    int-to-float v3, v13
    cmpg-float v0, v0, v3
    if-ltz v0, +058h
    invoke-virtual v10, Landroid/view/MotionEvent;->getY()F
    move-result v0
    iget-object v3, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    move-result-object v3
    invoke-virtual v3, Landroid/view/View;->getHeight()I
    move-result v3
    sub-int/2addr v3, v13
    int-to-float v13, v3
    cmpl-float v13, v0, v13
    if-lez v13, +003h
    goto +42h
    invoke-virtual v10, Landroid/view/MotionEvent;->getY()F
    move-result v13
    iput v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->b F
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/ui/PlayerView;
    move-result-object v13
    if-eqz v13, +026h
    invoke-virtual v10, Landroid/view/MotionEvent;->getX()F
    move-result v13
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/ui/PlayerView;
    move-result-object v0
    invoke-virtual v0, Landroid/view/View;->getWidth()I
    move-result v0
    div-int/lit8 v0, v0, 2
    int-to-float v0, v0
    cmpg-float v13, v13, v0
    if-gez v13, +011h
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lax/p3/m;->n(Landroid/content/Context;)Z
    move-result v13
    if-nez v13, +003h
    return v1
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    goto +4ah
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lax/p3/m;->t(Landroid/content/Context;)Z
    move-result v13
    if-nez v13, +003h
    return v1
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    goto +3bh
    return v1
    invoke-virtual v10, Landroid/view/MotionEvent;->getX()F
    move-result v13
    invoke-virtual v11, Landroid/view/MotionEvent;->getX()F
    move-result v0
    sub-float/2addr v13, v0
    invoke-static v13, Ljava/lang/Math;->abs(F)F
    move-result v13
    iget-object v0, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v0
    int-to-float v0, v0
    cmpg-float v13, v13, v0
    if-gez v13, +003h
    return v1
    invoke-virtual v10, Landroid/view/MotionEvent;->getX()F
    move-result v13
    iput v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->a F
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v13
    invoke-interface v13, Lax/P0/H;->k0()J
    move-result-wide v3
    iput-wide v3, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->c J
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lax/p3/m;->s(Landroid/content/Context;)Z
    move-result v13
    if-nez v13, +003h
    return v1
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v13
    if-nez v13, +025h
    new-instance v11, Ljava/lang/StringBuilder;
    invoke-direct v11, Ljava/lang/StringBuilder;-><init>()V
    const-string v12, "what case is this : "
    invoke-virtual v11, v12, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    iget v12, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->a F
    invoke-virtual v11, v12, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;
    const-string v12, ","
    invoke-virtual v11, v12, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, Landroid/view/MotionEvent;->getX()F
    move-result v10
    invoke-virtual v11, v10, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;
    invoke-virtual v11, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v10
    invoke-static v10, Lax/q3/b;->e(Ljava/lang/String;)V
    return v2
    iget-object v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v10
    if-eqz v10, +049h
    invoke-virtual v11, Landroid/view/MotionEvent;->getX()F
    move-result v10
    iget v11, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->a F
    sub-float/2addr v10, v11
    iget-object v11, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    float-to-int v10, v10
    invoke-static v11, v10, Lax/q3/A;->f(Landroid/content/Context; I)I
    move-result v10
    int-to-long v10, v10
    const-wide/32 v3, 40000
    mul-long v10, v10, v3
    const-wide/16 v3, 360
    div-long/2addr v10, v3
    iget-wide v3, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->c J
    add-long/2addr v3, v10
    iget-object v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v10
    invoke-interface v10, Lax/P0/H;->Y()J
    move-result-wide v10
    const-wide v5, -9223372036854775807
    const-wide/16 v7, 0
    cmp-long v13, v10, v5
    if-nez v13, +003h
    move-wide v10, v7
    cmp-long v13, v3, v7
    if-gez v13, +004h
    move-wide v3, v7
    goto +6h
    cmp-long v13, v3, v10
    if-lez v13, +003h
    move-wide v3, v10
    iget-object v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v11, 0
    cmpl-float v11, v12, v11
    if-lez v11, +003h
    const/4 v1, 1
    invoke-static v10, v3, v4, v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; J Z Z)V
    return v2
    iget-object v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v10
    if-eqz v10, +016h
    iget v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->b F
    invoke-virtual v11, Landroid/view/MotionEvent;->getY()F
    move-result v11
    sub-float/2addr v10, v11
    iget-object v11, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    float-to-int v10, v10
    invoke-static v11, v10, Lax/q3/A;->f(Landroid/content/Context; I)I
    move-result v10
    iget-object v11, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v11, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)V
    return v2
    iget-object v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v10
    if-eqz v10, +016h
    iget v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->b F
    invoke-virtual v11, Landroid/view/MotionEvent;->getY()F
    move-result v11
    sub-float/2addr v10, v11
    iget-object v11, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    float-to-int v10, v10
    invoke-static v11, v10, Lax/q3/A;->f(Landroid/content/Context; I)I
    move-result v10
    iget-object v11, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v11, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)V
    return v2
    return v1
.end method

.method onSingleTapConfirmed(Landroid/view/MotionEvent;)Z
    .registers 2
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    const/4 v1, 1
    return v1
.end method

.method onSingleTapUp(Landroid/view/MotionEvent;)Z
    .registers 2
    const/4 v1, 1
    return v1
.end method
