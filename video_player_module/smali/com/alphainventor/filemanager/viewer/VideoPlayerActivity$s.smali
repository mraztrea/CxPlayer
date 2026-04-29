# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;
.super Ljava/lang/Object;

# Fields
.field a:Landroid/view/ScaleGestureDetector;
.field b:Landroid/view/GestureDetector;
.field c:Lcom/alphainventor/filemanager/viewer/a;
.field d:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Landroid/view/ScaleGestureDetector; Landroid/view/GestureDetector; Lcom/alphainventor/filemanager/viewer/a;)V
    .registers 5
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    iput-object v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->a Landroid/view/ScaleGestureDetector;
    iput-object v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->b Landroid/view/GestureDetector;
    iput-object v4, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->c Lcom/alphainventor/filemanager/viewer/a;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method onTouch(Landroid/view/View; Landroid/view/MotionEvent;)Z
    .registers 6
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v4
    const/4 v0, 0
    if-eqz v4, +003h
    return v0
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->a Landroid/view/ScaleGestureDetector;
    invoke-virtual v4, v5, Landroid/view/ScaleGestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z
    move-result v4
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->b Landroid/view/GestureDetector;
    invoke-virtual v1, v5, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z
    move-result v1
    const/4 v2, 1
    if-nez v1, +004h
    if-eqz v4, +003h
    const/4 v0, 1
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->c Lcom/alphainventor/filemanager/viewer/a;
    invoke-virtual v4, v5, Lcom/alphainventor/filemanager/viewer/a;->g(Landroid/view/MotionEvent;)Z
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v4
    if-eqz v4, +01ah
    invoke-virtual v5, Landroid/view/MotionEvent;->getAction()I
    move-result v4
    if-ne v4, v2, +013h
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)F
    move-result v4
    const/high16 v5, 1065353216
    cmpg-float v4, v4, v5
    if-gtz v4, +007h
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return v2
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v4
    if-eqz v4, +00eh
    invoke-virtual v5, Landroid/view/MotionEvent;->getAction()I
    move-result v4
    if-ne v4, v2, +007h
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return v2
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v4
    if-eqz v4, +00eh
    invoke-virtual v5, Landroid/view/MotionEvent;->getAction()I
    move-result v4
    if-ne v4, v2, +007h
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return v2
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v4
    if-eqz v4, +00eh
    invoke-virtual v5, Landroid/view/MotionEvent;->getAction()I
    move-result v4
    if-ne v4, v2, +007h
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return v2
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v4
    if-eqz v4, +00eh
    invoke-virtual v5, Landroid/view/MotionEvent;->getAction()I
    move-result v4
    if-ne v4, v2, +007h
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;->d Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return v2
    return v0
.end method
