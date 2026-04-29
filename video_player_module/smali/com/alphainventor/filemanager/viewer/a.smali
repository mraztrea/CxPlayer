# Class: Lcom/alphainventor/filemanager/viewer/a;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/a;
.super Ljava/lang/Object;

# Fields
.field a:I
.field b:F
.field c:Landroid/os/Handler;
.field d:Lcom/alphainventor/filemanager/viewer/a$b;
.field e:Z
.field f:Z
.field g:Z
.field h:Landroid/view/MotionEvent;
.field i:Landroid/view/MotionEvent;
.field j:Landroid/view/MotionEvent;
.field k:F
.field l:F
.field m:F
.field n:F
.field o:I
.field p:Z

# Methods

.method <init>(Landroid/content/Context; F Lcom/alphainventor/filemanager/viewer/a$b;)V
    .registers 6
    const/4 v0, 0
    const/4 v1, 0
    invoke-direct v2, v3, v5, v0, v1, Lcom/alphainventor/filemanager/viewer/a;-><init>(Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/a$b; Landroid/os/Handler; I)V
    invoke-static Landroid/view/ViewConfiguration;->getLongPressTimeout()I
    move-result v3
    int-to-float v3, v3
    mul-float v3, v3, v4
    float-to-int v3, v3
    iput v3, v2, Lcom/alphainventor/filemanager/viewer/a;->o I
    return-void 
.end method

.method <init>(Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/a$b; Landroid/os/Handler; I)V
    .registers 5
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    if-eqz v3, +00ah
    new-instance v4, Lcom/alphainventor/filemanager/viewer/a$a;
    invoke-direct v4, v0, v3, Lcom/alphainventor/filemanager/viewer/a$a;-><init>(Lcom/alphainventor/filemanager/viewer/a; Landroid/os/Handler;)V
    iput-object v4, v0, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    goto +8h
    new-instance v3, Lcom/alphainventor/filemanager/viewer/a$a;
    invoke-direct v3, v0, Lcom/alphainventor/filemanager/viewer/a$a;-><init>(Lcom/alphainventor/filemanager/viewer/a;)V
    iput-object v3, v0, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    iput-object v2, v0, Lcom/alphainventor/filemanager/viewer/a;->d Lcom/alphainventor/filemanager/viewer/a$b;
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/a;->f(Landroid/content/Context;)V
    return-void 
.end method

.method a(Lcom/alphainventor/filemanager/viewer/a;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/a;->d()V
    return-void 
.end method

.method b()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    const/4 v1, 2
    invoke-virtual v0, v1, Landroid/os/Handler;->removeMessages(I)V
    const/4 v0, 0
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/a;->e Z
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/a;->g Z
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/a;->f Z
    return-void 
.end method

.method c()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    const/4 v1, 2
    invoke-virtual v0, v1, Landroid/os/Handler;->removeMessages(I)V
    const/4 v0, 0
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/a;->g Z
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/a;->f Z
    return-void 
.end method

.method d()V
    .registers 3
    const/4 v0, 1
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/a;->f Z
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/a;->d Lcom/alphainventor/filemanager/viewer/a$b;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/a;->h Landroid/view/MotionEvent;
    invoke-interface v0, v1, Lcom/alphainventor/filemanager/viewer/a$b;->a(Landroid/view/MotionEvent;)V
    return-void 
.end method

.method e()I
    .registers 2
    iget v0, v1, Lcom/alphainventor/filemanager/viewer/a;->o I
    return v0
.end method

.method f(Landroid/content/Context;)V
    .registers 5
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/a;->d Lcom/alphainventor/filemanager/viewer/a$b;
    if-eqz v0, +02eh
    const/4 v0, 1
    iput-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/a;->p Z
    invoke-static v4, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;
    move-result-object v4
    invoke-virtual v4, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I
    move-result v0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT I
    const/16 v2, 30
    if-lt v1, v2, +009h
    invoke-static v4, Lax/s3/b;->a(Landroid/view/ViewConfiguration;)F
    move-result v4
    iput v4, v3, Lcom/alphainventor/filemanager/viewer/a;->b F
    goto +10h
    const/16 v4, 29
    if-lt v1, v4, +009h
    invoke-static Lax/s3/c;->a()F
    move-result v4
    iput v4, v3, Lcom/alphainventor/filemanager/viewer/a;->b F
    goto +5h
    const/high16 v4, 1065353216
    iput v4, v3, Lcom/alphainventor/filemanager/viewer/a;->b F
    mul-int v0, v0, v0
    iput v0, v3, Lcom/alphainventor/filemanager/viewer/a;->a I
    return-void 
    new-instance v4, Ljava/lang/NullPointerException;
    const-string v0, "OnGestureListener must not be null"
    invoke-direct v4, v0, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V
    throw v4
.end method

.method g(Landroid/view/MotionEvent;)Z
    .registers 14
    invoke-virtual v13, Landroid/view/MotionEvent;->getAction()I
    move-result v0
    iget-object v1, v12, Lcom/alphainventor/filemanager/viewer/a;->i Landroid/view/MotionEvent;
    if-eqz v1, +005h
    invoke-virtual v1, Landroid/view/MotionEvent;->recycle()V
    invoke-static v13, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;
    move-result-object v1
    iput-object v1, v12, Lcom/alphainventor/filemanager/viewer/a;->i Landroid/view/MotionEvent;
    and-int/lit16 v0, v0, 255
    const/4 v1, 6
    const/4 v2, 1
    const/4 v3, 0
    if-ne v0, v1, +004h
    const/4 v4, 1
    goto +2h
    const/4 v4, 0
    if-eqz v4, +007h
    invoke-virtual v13, Landroid/view/MotionEvent;->getActionIndex()I
    move-result v5
    goto +2h
    const/4 v5, -1
    invoke-virtual v13, Landroid/view/MotionEvent;->getPointerCount()I
    move-result v6
    const/4 v7, 0
    const/4 v8, 0
    const/4 v9, 0
    if-ge v9, v6, +012h
    if-ne v5, v9, +003h
    goto +bh
    invoke-virtual v13, v9, Landroid/view/MotionEvent;->getX(I)F
    move-result v10
    add-float/2addr v7, v10
    invoke-virtual v13, v9, Landroid/view/MotionEvent;->getY(I)F
    move-result v10
    add-float/2addr v8, v10
    add-int/lit8 v9, v9, 1
    goto -11h
    if-eqz v4, +005h
    add-int/lit8 v4, v6, -1
    goto +2h
    move v4, v6
    int-to-float v4, v4
    div-float/2addr v7, v4
    div-float/2addr v8, v4
    if-eqz v0, +0dfh
    const/4 v4, 2
    if-eq v0, v2, +0c1h
    if-eq v0, v4, +057h
    const/4 v13, 3
    if-eq v0, v13, +050h
    const/4 v13, 5
    if-eq v0, v13, +014h
    if-eq v0, v1, +004h
    goto/16 +0b4h
    iput v7, v12, Lcom/alphainventor/filemanager/viewer/a;->k F
    iput v7, v12, Lcom/alphainventor/filemanager/viewer/a;->m F
    iput v8, v12, Lcom/alphainventor/filemanager/viewer/a;->l F
    iput v8, v12, Lcom/alphainventor/filemanager/viewer/a;->n F
    if-ne v6, v4, +0aah
    invoke-direct v12, Lcom/alphainventor/filemanager/viewer/a;->c()V
    return v3
    iput v7, v12, Lcom/alphainventor/filemanager/viewer/a;->k F
    iput v7, v12, Lcom/alphainventor/filemanager/viewer/a;->m F
    iput v8, v12, Lcom/alphainventor/filemanager/viewer/a;->l F
    iput v8, v12, Lcom/alphainventor/filemanager/viewer/a;->n F
    if-ne v6, v4, +02dh
    iget-boolean v13, v12, Lcom/alphainventor/filemanager/viewer/a;->p Z
    if-eqz v13, +098h
    iget-object v13, v12, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    invoke-virtual v13, v4, Landroid/os/Handler;->removeMessages(I)V
    iget-object v13, v12, Lcom/alphainventor/filemanager/viewer/a;->h Landroid/view/MotionEvent;
    if-eqz v13, +00dh
    invoke-virtual v13, Landroid/view/MotionEvent;->getDownTime()J
    move-result-wide v0
    invoke-direct v12, Lcom/alphainventor/filemanager/viewer/a;->e()I
    move-result v13
    int-to-long v5, v13
    add-long/2addr v0, v5
    goto +ah
    invoke-static Landroid/os/SystemClock;->uptimeMillis()J
    move-result-wide v0
    invoke-direct v12, Lcom/alphainventor/filemanager/viewer/a;->e()I
    move-result v13
    goto -bh
    iget-object v13, v12, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    invoke-virtual v13, v4, v3, v3, Landroid/os/Handler;->obtainMessage(I I I)Landroid/os/Message;
    move-result-object v2
    invoke-virtual v13, v2, v0, v1, Landroid/os/Handler;->sendMessageAtTime(Landroid/os/Message; J)Z
    return v3
    invoke-direct v12, Lcom/alphainventor/filemanager/viewer/a;->c()V
    return v3
    invoke-direct v12, Lcom/alphainventor/filemanager/viewer/a;->b()V
    return v3
    iget-boolean v0, v12, Lcom/alphainventor/filemanager/viewer/a;->f Z
    if-eqz v0, +003h
    goto +63h
    iget-boolean v0, v12, Lcom/alphainventor/filemanager/viewer/a;->g Z
    if-eqz v0, +060h
    iget v0, v12, Lcom/alphainventor/filemanager/viewer/a;->m F
    sub-float v0, v7, v0
    float-to-int v0, v0
    iget v1, v12, Lcom/alphainventor/filemanager/viewer/a;->n F
    sub-float v1, v8, v1
    float-to-int v1, v1
    mul-int v0, v0, v0
    mul-int v1, v1, v1
    add-int/2addr v0, v1
    iget v1, v12, Lcom/alphainventor/filemanager/viewer/a;->a I
    sget v5, Landroid/os/Build$VERSION;->SDK_INT I
    const/16 v6, 29
    if-lt v5, v6, +03ch
    invoke-static v13, Lax/s3/a;->a(Landroid/view/MotionEvent;)I
    move-result v5
    iget-object v6, v12, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    invoke-virtual v6, v4, Landroid/os/Handler;->hasMessages(I)Z
    move-result v6
    if-ne v5, v2, +003h
    goto +2h
    const/4 v2, 0
    if-eqz v6, +02ch
    if-eqz v2, +02ah
    if-le v0, v1, +020h
    iget-object v2, v12, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    invoke-virtual v2, v4, Landroid/os/Handler;->removeMessages(I)V
    invoke-direct v12, Lcom/alphainventor/filemanager/viewer/a;->e()I
    move-result v2
    int-to-long v5, v2
    iget-object v2, v12, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    invoke-virtual v2, v4, v3, v3, Landroid/os/Handler;->obtainMessage(I I I)Landroid/os/Message;
    move-result-object v9
    invoke-virtual v13, Landroid/view/MotionEvent;->getDownTime()J
    move-result-wide v10
    long-to-float v13, v5
    iget v5, v12, Lcom/alphainventor/filemanager/viewer/a;->b F
    mul-float v13, v13, v5
    float-to-long v5, v13
    add-long/2addr v10, v5
    invoke-virtual v2, v9, v10, v11, Landroid/os/Handler;->sendMessageAtTime(Landroid/os/Message; J)Z
    int-to-float v13, v1
    iget v1, v12, Lcom/alphainventor/filemanager/viewer/a;->b F
    mul-float v1, v1, v1
    mul-float v13, v13, v1
    float-to-int v1, v13
    if-le v0, v1, +00dh
    iput v7, v12, Lcom/alphainventor/filemanager/viewer/a;->k F
    iput v8, v12, Lcom/alphainventor/filemanager/viewer/a;->l F
    iput-boolean v3, v12, Lcom/alphainventor/filemanager/viewer/a;->g Z
    iget-object v13, v12, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    invoke-virtual v13, v4, Landroid/os/Handler;->removeMessages(I)V
    return v3
    iput-boolean v3, v12, Lcom/alphainventor/filemanager/viewer/a;->e Z
    invoke-static v13, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;
    move-result-object v13
    iget-boolean v0, v12, Lcom/alphainventor/filemanager/viewer/a;->f Z
    if-eqz v0, +004h
    iput-boolean v3, v12, Lcom/alphainventor/filemanager/viewer/a;->f Z
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/a;->j Landroid/view/MotionEvent;
    if-eqz v0, +005h
    invoke-virtual v0, Landroid/view/MotionEvent;->recycle()V
    iput-object v13, v12, Lcom/alphainventor/filemanager/viewer/a;->j Landroid/view/MotionEvent;
    iget-object v13, v12, Lcom/alphainventor/filemanager/viewer/a;->c Landroid/os/Handler;
    invoke-virtual v13, v4, Landroid/os/Handler;->removeMessages(I)V
    return v3
    iput v7, v12, Lcom/alphainventor/filemanager/viewer/a;->k F
    iput v7, v12, Lcom/alphainventor/filemanager/viewer/a;->m F
    iput v8, v12, Lcom/alphainventor/filemanager/viewer/a;->l F
    iput v8, v12, Lcom/alphainventor/filemanager/viewer/a;->n F
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/a;->h Landroid/view/MotionEvent;
    if-eqz v0, +005h
    invoke-virtual v0, Landroid/view/MotionEvent;->recycle()V
    invoke-static v13, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;
    move-result-object v13
    iput-object v13, v12, Lcom/alphainventor/filemanager/viewer/a;->h Landroid/view/MotionEvent;
    iput-boolean v2, v12, Lcom/alphainventor/filemanager/viewer/a;->g Z
    iput-boolean v2, v12, Lcom/alphainventor/filemanager/viewer/a;->e Z
    iput-boolean v3, v12, Lcom/alphainventor/filemanager/viewer/a;->f Z
    return v3
.end method
