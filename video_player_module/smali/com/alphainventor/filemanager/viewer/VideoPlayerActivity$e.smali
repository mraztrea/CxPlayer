# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;
# Superclass: Landroid/view/ScaleGestureDetector$SimpleOnScaleGestureListener;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;
.super Landroid/view/ScaleGestureDetector$SimpleOnScaleGestureListener;

# Fields
.field a:F
.field b:F
.field c:F
.field d:F
.field e:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Landroid/view/ScaleGestureDetector$SimpleOnScaleGestureListener;-><init>()V
    return-void 
.end method

.method onScale(Landroid/view/ScaleGestureDetector;)Z
    .registers 10
    iget-object v0, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v0
    const/4 v1, 0
    if-nez v0, +043h
    iget-object v0, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v0
    if-eqz v0, +003h
    goto +39h
    iget-object v0, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v0
    if-nez v0, +003h
    return v1
    iget v0, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->c F
    invoke-virtual v9, Landroid/view/ScaleGestureDetector;->getFocusX()F
    move-result v1
    sub-float v6, v0, v1
    iget v0, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->d F
    invoke-virtual v9, Landroid/view/ScaleGestureDetector;->getFocusY()F
    move-result v1
    sub-float v7, v0, v1
    iget-object v2, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-virtual v9, Landroid/view/ScaleGestureDetector;->getScaleFactor()F
    move-result v3
    invoke-virtual v9, Landroid/view/ScaleGestureDetector;->getFocusX()F
    move-result v4
    invoke-virtual v9, Landroid/view/ScaleGestureDetector;->getFocusY()F
    move-result v5
    invoke-static/range v2 ... v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; F F F F F)V
    invoke-virtual v9, Landroid/view/ScaleGestureDetector;->getFocusX()F
    move-result v0
    iput v0, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->c F
    invoke-virtual v9, Landroid/view/ScaleGestureDetector;->getFocusY()F
    move-result v9
    iput v9, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->d F
    const/4 v9, 1
    return v9
    return v1
.end method

.method onScaleBegin(Landroid/view/ScaleGestureDetector;)Z
    .registers 4
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v0
    const/4 v1, 0
    if-nez v0, +040h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v0
    if-eqz v0, +003h
    goto +36h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lax/p3/m;->u(Landroid/content/Context;)Z
    move-result v0
    if-nez v0, +003h
    return v1
    invoke-virtual v3, Landroid/view/ScaleGestureDetector;->getFocusX()F
    move-result v0
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->a F
    invoke-virtual v3, Landroid/view/ScaleGestureDetector;->getFocusY()F
    move-result v0
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->b F
    invoke-virtual v3, Landroid/view/ScaleGestureDetector;->getFocusX()F
    move-result v0
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->c F
    invoke-virtual v3, Landroid/view/ScaleGestureDetector;->getFocusY()F
    move-result v3
    iput v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->d F
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v0, 1
    invoke-static v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v3
    if-nez v3, +007h
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return v0
    return v1
.end method

.method onScaleEnd(Landroid/view/ScaleGestureDetector;)V
    .registers 3
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v2
    if-nez v2, +01ah
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v2
    if-eqz v2, +003h
    goto +10h
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->e Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v0, 0
    invoke-static v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    const/4 v2, 0
    iput v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->a F
    iput v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->b F
    iput v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->c F
    iput v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;->d F
    return-void 
.end method
