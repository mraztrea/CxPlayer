# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
# Superclass: Lax/n/c;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
.super Lax/n/c;

# Fields
.field R1:Ljava/util/logging/Logger;
.field S1:Z
.field T1:Z
.field A:Landroid/widget/TextView;
.field A0:Z
.field A1:Landroid/os/Handler;
.field B:Landroid/view/View;
.field B0:Landroid/media/AudioManager;
.field B1:I
.field C:Landroid/widget/ImageView;
.field C0:Z
.field C1:I
.field D:Landroid/widget/ProgressBar;
.field D0:I
.field D1:Lcom/alphainventor/filemanager/viewer/f;
.field E:Landroid/widget/TextView;
.field E0:I
.field E1:I
.field F:Landroidx/media3/ui/AspectRatioFrameLayout;
.field F0:Z
.field F1:I
.field G:Lcom/google/android/material/snackbar/Snackbar;
.field G0:F
.field G1:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;
.field H:Landroid/view/View;
.field H0:Z
.field H1:Z
.field I:Landroidx/appcompat/widget/Toolbar;
.field I0:I
.field I1:Lax/i/r;
.field J:Landroid/view/ViewGroup;
.field J0:Z
.field J1:Ljava/lang/Runnable;
.field K:Landroid/view/ViewGroup;
.field K0:Z
.field K1:Landroidx/media3/ui/G$a;
.field L:Landroid/view/View;
.field L0:J
.field L1:Ljava/lang/Runnable;
.field M:Landroid/view/View;
.field M0:J
.field M1:Landroid/view/ScaleGestureDetector$SimpleOnScaleGestureListener;
.field N:Landroid/view/View;
.field N0:Lax/g1/n;
.field N1:Landroid/view/GestureDetector$SimpleOnGestureListener;
.field O:Z
.field O0:Lax/g1/n$e;
.field O1:Landroid/view/View$OnClickListener;
.field P:Z
.field P0:Lax/p7/z;
.field P1:Lcom/alphainventor/filemanager/viewer/f$h;
.field Q:Ljava/lang/String;
.field Q0:Landroid/graphics/drawable/Drawable;
.field Q1:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
.field R:Ljava/lang/String;
.field R0:Landroid/graphics/drawable/Drawable;
.field S:Landroidx/media3/ui/b;
.field S0:Landroid/graphics/drawable/Drawable;
.field T:Landroid/widget/TextView;
.field T0:Landroid/graphics/drawable/Drawable;
.field U:Lax/U0/g$a;
.field U0:Landroid/graphics/drawable/Drawable;
.field V:Lax/e1/M;
.field V0:Landroid/graphics/drawable/Drawable;
.field W:Landroidx/media3/exoplayer/ExoPlayer;
.field W0:Landroid/graphics/drawable/Drawable;
.field X:Lax/a1/O;
.field X0:Landroid/graphics/drawable/Drawable;
.field Y:Lax/P0/y;
.field Y0:Landroid/graphics/drawable/Drawable;
.field Z:[Landroid/net/Uri;
.field Z0:Landroid/graphics/drawable/Drawable;
.field a:Landroid/view/View;
.field a0:[Landroid/net/Uri;
.field a1:Ljava/lang/String;
.field b:Landroidx/media3/ui/PlayerView;
.field b0:[Landroid/net/Uri;
.field b1:Ljava/lang/String;
.field c:Z
.field c0:Ljava/util/List;
.field c1:Ljava/lang/String;
.field d:Ljava/lang/Runnable;
.field d0:Z
.field d1:Ljava/lang/String;
.field e:Landroidx/media3/ui/d;
.field e0:Z
.field e1:Ljava/lang/String;
.field f:Landroid/view/ViewGroup;
.field f0:[Z
.field f1:Ljava/lang/String;
.field g:Landroid/view/View;
.field g0:I
.field g1:Ljava/lang/String;
.field h:Landroid/view/View;
.field h0:I
.field h1:Ljava/lang/String;
.field i:Landroid/view/View;
.field i0:I
.field i1:Ljava/lang/String;
.field j:Landroid/view/View;
.field j0:Z
.field j1:Ljava/lang/String;
.field k:Landroid/widget/ImageButton;
.field k0:Z
.field k1:F
.field l:Landroid/view/View;
.field l0:I
.field l1:F
.field m:Landroid/view/View;
.field m0:I
.field m1:Z
.field n:Landroid/view/View;
.field n0:Z
.field n1:I
.field o:Landroid/view/View;
.field o0:I
.field o1:J
.field p:Landroid/view/View;
.field p0:F
.field p1:Ljava/lang/String;
.field q:Landroid/view/View;
.field q0:Z
.field q1:I
.field r:Landroid/widget/ImageButton;
.field r0:Z
.field r1:Z
.field s:Landroid/view/View;
.field s0:Z
.field s1:Z
.field t:Landroid/widget/ImageView;
.field t0:J
.field t1:Lax/W2/F;
.field u:Landroid/widget/ImageButton;
.field u0:J
.field u1:Z
.field v:Landroid/widget/ImageButton;
.field v0:Z
.field v1:Landroid/net/Uri;
.field w:Landroid/widget/ImageButton;
.field w0:I
.field w1:J
.field x:Landroid/widget/ImageButton;
.field x0:I
.field x1:Z
.field y:Landroidx/appcompat/widget/MySpinner;
.field y0:F
.field y1:I
.field z:Landroid/view/View;
.field z0:Z
.field z1:Z

# Methods

.method <clinit>()V
    .registers 1
    const-string v0, "FileManager.VideoPlayer"
    invoke-static v0, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;
    move-result-object v0
    sput-object v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R1 Ljava/util/logging/Logger;
    const/4 v0, 0
    sput-boolean v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S1 Z
    sput-boolean v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T1 Z
    return-void 
.end method

.method <init>()V
    .registers 3
    invoke-direct v2, Lax/n/c;-><init>()V
    const/4 v0, 0
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k0 Z
    const/high16 v0, 1065353216
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p0 F
    const-wide/16 v0, 150
    iput-wide v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w1 J
    new-instance v0, Landroid/os/Handler;
    invoke-direct v0, Landroid/os/Handler;-><init>()V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A1 Landroid/os/Handler;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$p;
    const/4 v1, 1
    invoke-direct v0, v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$p;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I1 Lax/i/r;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$b;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$b;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J1 Ljava/lang/Runnable;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K1 Landroidx/media3/ui/G$a;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$d;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$d;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L1 Ljava/lang/Runnable;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M1 Landroid/view/ScaleGestureDetector$SimpleOnScaleGestureListener;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N1 Landroid/view/GestureDetector$SimpleOnGestureListener;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$g;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$g;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$h;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$h;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P1 Lcom/alphainventor/filemanager/viewer/f$h;
    return-void 
.end method

.method A0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/net/Uri;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v1 Landroid/net/Uri;
    return-object v0
.end method

.method A1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z3()V
    return-void 
.end method

.method A2(I)I
    .registers 3
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0 Z
    if-eqz v0, +00eh
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0 Ljava/util/List;
    invoke-interface v0, v2, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/Integer;
    invoke-virtual v2, Ljava/lang/Integer;->intValue()I
    move-result v2
    return v2
.end method

.method A3()V
    .registers 3
    iget-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P Z
    if-eqz v0, +005h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e2()V
    const/4 v0, 1
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J0 Z
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P2()Z
    move-result v0
    if-eqz v0, +028h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R2()Z
    move-result v0
    if-eqz v0, +014h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K Landroid/view/ViewGroup;
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/view/View;->setBackgroundColor(I)V
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$i;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$i;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    invoke-static v2, v0, Lax/M2/b;->j(Landroid/app/Activity; Lax/M2/b$a;)Landroid/view/View;
    move-result-object v0
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N Landroid/view/View;
    return-void 
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K Landroid/view/ViewGroup;
    const/4 v1, -1
    invoke-virtual v0, v1, Landroid/view/View;->setBackgroundColor(I)V
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$j;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$j;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    invoke-static v2, v0, Lax/M2/b;->k(Landroid/app/Activity; Lax/M2/b$c;)V
    return-void 
.end method

.method A4(F F F F F)V
    .registers 10
    invoke-direct v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d3()Z
    move-result v0
    if-nez v0, +006h
    invoke-direct v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f2()V
    return-void 
    iget v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    mul-float v0, v0, v5
    iput v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    const/high16 v1, 1065353216
    cmpg-float v2, v0, v1
    if-gez v2, +005h
    iput v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    goto +9h
    const/high16 v2, 1077936128
    cmpl-float v0, v0, v2
    if-lez v0, +004h
    iput v2, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    iget v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    invoke-static v0, Ljava/lang/Float;->isNaN(F)Z
    move-result v0
    if-eqz v0, +008h
    iput v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    invoke-direct v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f2()V
    return-void 
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    iget v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    invoke-virtual v0, v1, Landroid/view/View;->setScaleX(F)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    iget v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    invoke-virtual v0, v1, Landroid/view/View;->setScaleY(F)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroid/view/View;->getWidth()I
    move-result v0
    int-to-float v0, v0
    const/high16 v1, 1073741824
    div-float/2addr v0, v1
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v2, Landroid/view/View;->getHeight()I
    move-result v2
    int-to-float v2, v2
    div-float/2addr v2, v1
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    invoke-virtual v1, Landroid/view/View;->getTranslationX()F
    move-result v1
    iget-object v3, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    invoke-virtual v3, Landroid/view/View;->getTranslationY()F
    move-result v3
    invoke-direct v4, v1, v0, v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a2(F F F F)F
    move-result v6
    invoke-direct v4, v3, v2, v7, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a2(F F F F)F
    move-result v5
    iget v7, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    add-float/2addr v6, v8
    add-float/2addr v5, v9
    invoke-direct v4, v7, v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p3(F F F)V
    return-void 
.end method

.method B0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Landroid/net/Uri;)Landroid/net/Uri;
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v1 Landroid/net/Uri;
    return-object v1
.end method

.method B1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c3()Z
    move-result v0
    return v0
.end method

.method B2(Lax/p7/z; Ljava/lang/String;)Ljava/lang/String;
    .registers 10
    const/4 v0, 0
    if-nez v8, +003h
    return-object v0
    const/4 v1, 0
    const/4 v2, 0
    invoke-virtual v8, Ljava/util/AbstractCollection;->size()I
    move-result v3
    if-ge v2, v3, +026h
    invoke-interface v8, v2, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Lax/P0/U$a;
    const/4 v4, 0
    iget v5, v3, Lax/P0/U$a;->a I
    if-ge v4, v5, +018h
    invoke-virtual v3, v4, Lax/P0/U$a;->b(I)Lax/P0/v;
    move-result-object v5
    if-eqz v5, +00fh
    iget-object v6, v5, Lax/P0/v;->o Ljava/lang/String;
    if-eqz v6, +00bh
    invoke-virtual v6, v9, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v6
    if-eqz v6, +005h
    iget-object v8, v5, Lax/P0/v;->o Ljava/lang/String;
    return-object v8
    add-int/lit8 v4, v4, 1
    goto -19h
    add-int/lit8 v2, v2, 1
    goto -29h
    return-object v0
.end method

.method B3()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q1 Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
    if-nez v0, +00bh
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A1 Landroid/os/Handler;
    invoke-direct v0, v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;-><init>(Landroid/app/Activity; Landroid/os/Handler;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q1 Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q1 Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
    invoke-virtual v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;->d()V
    return-void 
.end method

.method B4()V
    .registers 2
    const/4 v0, 1
    iput-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A0 Z
    return-void 
.end method

.method C0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v4()V
    return-void 
.end method

.method C1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; F F F)V
    .registers 4
    invoke-direct v0, v1, v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p3(F F F)V
    return-void 
.end method

.method C2()I
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    if-nez v0, +004h
    const/4 v0, 0
    return v0
    array-length v0, v0
    return v0
.end method

.method C3(I)V
    .registers 5
    const/16 v0, 255
    mul-int/lit16 v4, v4, 255
    div-int/lit16 v4, v4, 360
    iget v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G0 F
    const/high16 v2, 1132396544
    mul-float v1, v1, v2
    float-to-int v1, v1
    add-int/2addr v1, v4
    if-le v1, v0, +003h
    goto +6h
    if-gez v1, +004h
    const/4 v0, 0
    goto +2h
    move v0, v1
    invoke-virtual v3, Landroid/app/Activity;->getWindow()Landroid/view/Window;
    move-result-object v4
    invoke-virtual v4, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;
    move-result-object v4
    int-to-float v1, v0
    div-float/2addr v1, v2
    iput v1, v4, Landroid/view/WindowManager$LayoutParams;->screenBrightness F
    invoke-virtual v3, Landroid/app/Activity;->getWindow()Landroid/view/Window;
    move-result-object v1
    invoke-virtual v1, v4, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D Landroid/widget/ProgressBar;
    invoke-virtual v4, v0, Landroid/widget/ProgressBar;->setProgress(I)V
    return-void 
.end method

.method D0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h2()V
    return-void 
.end method

.method D1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    .registers 1
    iget v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x0 I
    return v0
.end method

.method D3(I)V
    .registers 5
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B0 Landroid/media/AudioManager;
    if-nez v0, +00fh
    const-string v0, "audio"
    invoke-virtual v3, v0, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/media/AudioManager;
    iput-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B0 Landroid/media/AudioManager;
    if-nez v0, +003h
    goto +25h
    iget v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D0 I
    mul-int v4, v4, v0
    div-int/lit16 v4, v4, 360
    iget v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E0 I
    add-int/2addr v1, v4
    const/4 v4, 0
    if-le v1, v0, +003h
    goto +6h
    if-gez v1, +004h
    const/4 v0, 0
    goto +2h
    move v0, v1
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B0 Landroid/media/AudioManager;
    const/4 v2, 3
    invoke-virtual v1, v2, v0, v4, Landroid/media/AudioManager;->setStreamVolume(I I I)V
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D Landroid/widget/ProgressBar;
    invoke-virtual v4, v0, Landroid/widget/ProgressBar;->setProgress(I)V
    return-void 
    move-exception v4
    const-string v0, "video set volume exception"
    invoke-static v0, v4, Lax/K2/d;->c(Ljava/lang/String; Ljava/lang/Throwable;)V
    return-void 
.end method

.method E0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Y2()Z
    move-result v0
    return v0
.end method

.method E1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a Landroid/view/View;
    return-object v0
.end method

.method E2()Z
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J0 Z
    return v0
.end method

.method E3(Z Landroid/view/View;)V
    .registers 3
    if-nez v2, +003h
    return-void 
    invoke-virtual v2, v1, Landroid/view/View;->setEnabled(Z)V
    if-eqz v1, +005h
    iget v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k1 F
    goto +3h
    iget v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l1 F
    invoke-virtual v2, v1, Landroid/view/View;->setAlpha(F)V
    const/4 v1, 0
    invoke-virtual v2, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method F0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; J)J
    .registers 3
    iput-wide v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w1 J
    return-wide v1
.end method

.method F1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    .registers 1
    iget v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B1 I
    return v0
.end method

.method F2([Landroid/net/Uri;)Z
    .registers 7
    array-length v0, v6
    const/4 v1, 0
    const/4 v2, 0
    if-ge v2, v0, +026h
    aget-object v3, v6, v2
    invoke-virtual v3, Landroid/net/Uri;->getScheme()Ljava/lang/String;
    move-result-object v4
    invoke-static v4, Lax/W2/w;->J(Ljava/lang/String;)Z
    move-result v4
    if-eqz v4, +017h
    invoke-virtual v3, Landroid/net/Uri;->getHost()Ljava/lang/String;
    move-result-object v4
    const/4 v5, 1
    if-nez v4, +003h
    return v5
    invoke-virtual v3, Landroid/net/Uri;->getHost()Ljava/lang/String;
    move-result-object v3
    const-string v4, "."
    invoke-virtual v3, v4, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v3
    if-eqz v3, +003h
    return v5
    add-int/lit8 v2, v2, 1
    goto -25h
    return v1
.end method

.method F3(Z)V
    .registers 2
    iput-boolean v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n0 Z
    invoke-static v0, v1, Lax/p3/m;->i(Landroid/content/Context; Z)V
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m4()V
    invoke-virtual v0, Lax/n/c;->invalidateOptionsMenu()V
    return-void 
.end method

.method G(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    iget-boolean v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c Z
    return v0
.end method

.method G0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/ui/b;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S Landroidx/media3/ui/b;
    return-object v0
.end method

.method G1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    .registers 1
    iget v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C1 I
    return v0
.end method

.method G2()V
    .registers 2
    invoke-virtual v1, Lax/n/c;->getSupportActionBar()Lax/n/a;
    move-result-object v0
    if-nez v0, +003h
    return-void 
    invoke-virtual v0, Lax/n/a;->n()V
    return-void 
.end method

.method G3(I)V
    .registers 2
    iput v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i0 I
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n4()V
    return-void 
.end method

.method H(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    .registers 2
    iput-boolean v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c Z
    return v1
.end method

.method H0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l2()V
    return-void 
.end method

.method H1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V1()V
    return-void 
.end method

.method H2()V
    .registers 3
    invoke-virtual v2, Lax/n/c;->getSupportActionBar()Lax/n/a;
    move-result-object v0
    if-eqz v0, +00bh
    const-string v1, ""
    invoke-virtual v0, v1, Lax/n/a;->H(Ljava/lang/CharSequence;)V
    const/4 v1, 1
    invoke-virtual v0, v1, Lax/n/a;->x(Z)V
    return-void 
.end method

.method H3()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    if-eqz v0, +018h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y2()Landroid/net/Uri;
    move-result-object v0
    if-eqz v0, +012h
    new-instance v0, Landroid/content/Intent;
    invoke-direct v0, Landroid/content/Intent;-><init>()V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x2()Landroid/net/Uri;
    move-result-object v1
    invoke-virtual v0, v1, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;
    const/4 v1, -1
    invoke-virtual v2, v1, v0, Landroid/app/Activity;->setResult(I Landroid/content/Intent;)V
    return-void 
.end method

.method I(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Ljava/lang/Runnable;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d Ljava/lang/Runnable;
    return-object v0
.end method

.method I0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m4()V
    return-void 
.end method

.method I1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y4()V
    return-void 
.end method

.method I2()V
    .registers 2
    invoke-static v1, Lax/p3/m;->o(Landroid/content/Context;)Z
    move-result v0
    if-eqz v0, +00dh
    invoke-static v1, Lax/s3/f;->r(Landroid/content/Context;)Z
    move-result v0
    if-eqz v0, +007h
    invoke-static v1, Lax/s3/f;->m(Landroid/content/Context;)Z
    move-result v0
    goto +2h
    const/4 v0, 0
    if-nez v0, +005h
    invoke-static v1, Lax/s3/f;->n(Landroid/content/Context;)Z
    return-void 
.end method

.method J(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h3()Z
    move-result v0
    return v0
.end method

.method J0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k4()V
    return-void 
.end method

.method J1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    .registers 1
    iget v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w0 I
    return v0
.end method

.method J2()V
    .registers 3
    invoke-static v2, Lax/p3/m;->a(Landroid/content/Context;)Z
    move-result v0
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n0 Z
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m4()V
    invoke-static v2, Lax/p3/m;->c(Landroid/content/Context;)I
    move-result v0
    invoke-direct v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L3(I)V
    iget v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p0 F
    const/4 v1, 0
    cmpl-float v1, v0, v1
    if-eqz v1, +011h
    const/4 v1, 1
    invoke-direct v2, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K3(F Z)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y Landroidx/appcompat/widget/MySpinner;
    iget v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p0 F
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/d;->c(F)I
    move-result v1
    invoke-virtual v0, v1, Landroid/widget/AdapterView;->setSelection(I)V
    invoke-virtual v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t4()V
    return-void 
.end method

.method J3(Z)V
    .registers 3
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setKeepScreenOn(Z)V
    return-void 
.end method

.method K(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B3()V
    return-void 
.end method

.method K0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n4()V
    return-void 
.end method

.method K1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)V
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D3(I)V
    return-void 
.end method

.method K2()V
    .registers 4
    invoke-virtual v3, Lax/n/c;->getResources()Landroid/content/res/Resources;
    move-result-object v0
    const v1, 2131231203
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q0 Landroid/graphics/drawable/Drawable;
    const v1, 2131231205
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R0 Landroid/graphics/drawable/Drawable;
    const v1, 2131231204
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S0 Landroid/graphics/drawable/Drawable;
    const v1, 2131231230
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W0 Landroid/graphics/drawable/Drawable;
    const v1, 2131231231
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X0 Landroid/graphics/drawable/Drawable;
    const v1, 2131231019
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T0 Landroid/graphics/drawable/Drawable;
    const v1, 2131231020
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->U0 Landroid/graphics/drawable/Drawable;
    const v1, 2131231018
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V0 Landroid/graphics/drawable/Drawable;
    const v1, 2131231024
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z0 Landroid/graphics/drawable/Drawable;
    const v1, 2131231023
    invoke-static v3, v1, Lax/o3/a;->c(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Y0 Landroid/graphics/drawable/Drawable;
    const v1, 2131952540
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a1 Ljava/lang/String;
    const v1, 2131952542
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b1 Ljava/lang/String;
    const v1, 2131952541
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c1 Ljava/lang/String;
    const v1, 2131951980
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d1 Ljava/lang/String;
    const v1, 2131951981
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e1 Ljava/lang/String;
    const v1, 2131951979
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f1 Ljava/lang/String;
    const v1, 2131951966
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g1 Ljava/lang/String;
    const v1, 2131951965
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h1 Ljava/lang/String;
    const v1, 2131951987
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i1 Ljava/lang/String;
    const v1, 2131951986
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j1 Ljava/lang/String;
    const v1, 2131427337
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getInteger(I)I
    move-result v1
    int-to-float v1, v1
    const/high16 v2, 1120403456
    div-float/2addr v1, v2
    iput v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k1 F
    const v1, 2131427336
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getInteger(I)I
    move-result v0
    int-to-float v0, v0
    div-float/2addr v0, v2
    iput v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l1 F
    return-void 
.end method

.method K3(F Z)V
    .registers 4
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    goto +17h
    if-eqz v3, +004h
    iput v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p0 F
    invoke-interface v0, Lax/P0/H;->g()Lax/P0/G;
    move-result-object v3
    if-eqz v3, +00fh
    iget-object v3, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v3, Lax/P0/H;->g()Lax/P0/G;
    move-result-object v3
    iget v3, v3, Lax/P0/G;->a F
    cmpl-float v3, v3, v2
    if-nez v3, +003h
    return-void 
    const/high16 v3, 1065353216
    cmpl-float v3, v2, v3
    if-nez v3, +00ah
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    sget-object v3, Lax/P0/G;->d Lax/P0/G;
    invoke-interface v2, v3, Lax/P0/H;->e(Lax/P0/G;)V
    return-void 
    iget-object v3, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    new-instance v0, Lax/P0/G;
    invoke-direct v0, v2, Lax/P0/G;-><init>(F)V
    invoke-interface v3, v0, Lax/P0/H;->e(Lax/P0/G;)V
    return-void 
.end method

.method L0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l4()V
    return-void 
.end method

.method L1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)V
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C3(I)V
    return-void 
.end method

.method L2()V
    .registers 11
    const/4 v0, 0
    const/4 v1, 1
    iget-object v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    if-eqz v2, +004h
    goto/16 +1a0h
    invoke-virtual v10, Landroid/app/Activity;->getIntent()Landroid/content/Intent;
    move-result-object v2
    invoke-virtual v2, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v3
    const/4 v4, -1
    iput v4, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g0 I
    iput v4, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h0 I
    const-string v5, "android.intent.action.VIEW"
    invoke-virtual v5, v3, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    const v5, 2131951922
    if-eqz v3, +193h
    invoke-virtual v2, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v3
    if-eqz v3, +18dh
    invoke-static Lcom/alphainventor/filemanager/viewer/e;->b()Lcom/alphainventor/filemanager/viewer/e;
    move-result-object v3
    invoke-virtual v3, Lcom/alphainventor/filemanager/viewer/e;->c()Ljava/util/ArrayList;
    move-result-object v3
    if-eqz v3, +099h
    invoke-virtual v3, Ljava/util/ArrayList;->size()I
    move-result v6
    new-array v6, v6, [Landroid/net/Uri;
    iput-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z [Landroid/net/Uri;
    invoke-virtual v3, Ljava/util/ArrayList;->size()I
    move-result v6
    new-array v6, v6, [Landroid/net/Uri;
    iput-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    invoke-virtual v3, Ljava/util/ArrayList;->size()I
    move-result v6
    new-array v6, v6, [Landroid/net/Uri;
    iput-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b0 [Landroid/net/Uri;
    new-instance v6, Ljava/util/ArrayList;
    invoke-direct v6, Ljava/util/ArrayList;-><init>()V
    iput-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0 Ljava/util/List;
    const/4 v6, 0
    invoke-virtual v3, Ljava/util/ArrayList;->size()I
    move-result v7
    if-ge v6, v7, +00dh
    iget-object v7, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0 Ljava/util/List;
    invoke-static v6, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v8
    invoke-interface v7, v8, Ljava/util/List;->add(Ljava/lang/Object;)Z
    add-int/2addr v6, v1
    goto -10h
    iget-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0 Ljava/util/List;
    invoke-static v6, Ljava/util/Collections;->shuffle(Ljava/util/List;)V
    const/4 v6, 0
    invoke-virtual v3, Ljava/util/ArrayList;->size()I
    move-result v7
    if-ge v6, v7, +024h
    invoke-virtual v3, v6, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
    move-result-object v7
    check-cast v7, Lcom/alphainventor/filemanager/viewer/e$a;
    iget-object v8, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z [Landroid/net/Uri;
    iget-object v9, v7, Lcom/alphainventor/filemanager/viewer/e$a;->a Landroid/net/Uri;
    aput-object v9, v8, v6
    iget-object v8, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    invoke-direct v10, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i2(Landroid/net/Uri;)Landroid/net/Uri;
    move-result-object v9
    aput-object v9, v8, v6
    iget-object v7, v7, Lcom/alphainventor/filemanager/viewer/e$a;->b Landroid/net/Uri;
    if-eqz v7, +00ah
    iget-object v8, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b0 [Landroid/net/Uri;
    invoke-direct v10, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i2(Landroid/net/Uri;)Landroid/net/Uri;
    move-result-object v7
    aput-object v7, v8, v6
    add-int/2addr v6, v1
    goto -27h
    const/4 v3, 0
    iget-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z [Landroid/net/Uri;
    array-length v6, v6
    if-ge v3, v6, +078h
    iget-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0 Ljava/util/List;
    invoke-interface v6, v3, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v6
    check-cast v6, Ljava/lang/Integer;
    invoke-virtual v6, Ljava/lang/Integer;->intValue()I
    move-result v6
    iget-object v7, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z [Landroid/net/Uri;
    aget-object v7, v7, v3
    if-eqz v7, +00eh
    invoke-virtual v2, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v8
    invoke-virtual v7, v8, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z
    move-result v7
    if-eqz v7, +004h
    iput v3, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g0 I
    iget-object v7, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z [Landroid/net/Uri;
    aget-object v6, v7, v6
    if-eqz v6, +00eh
    invoke-virtual v2, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v7
    invoke-virtual v6, v7, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z
    move-result v6
    if-eqz v6, +004h
    iput v3, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h0 I
    add-int/2addr v3, v1
    goto -36h
    sget-object v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R1 Ljava/util/logging/Logger;
    new-instance v6, Ljava/lang/StringBuilder;
    invoke-direct v6, Ljava/lang/StringBuilder;-><init>()V
    const-string v7, "Video play : "
    invoke-virtual v6, v7, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v2, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v7
    invoke-virtual v6, v7, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    invoke-virtual v6, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v6
    invoke-virtual v3, v6, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V
    invoke-virtual v2, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v3
    new-array v6, v1, [Landroid/net/Uri;
    aput-object v3, v6, v0
    iput-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z [Landroid/net/Uri;
    invoke-virtual v2, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v3
    invoke-direct v10, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i2(Landroid/net/Uri;)Landroid/net/Uri;
    move-result-object v3
    new-array v6, v1, [Landroid/net/Uri;
    aput-object v3, v6, v0
    iput-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    new-instance v3, Ljava/util/ArrayList;
    invoke-direct v3, Ljava/util/ArrayList;-><init>()V
    iput-object v3, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0 Ljava/util/List;
    invoke-static v0, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v6
    invoke-interface v3, v6, Ljava/util/List;->add(Ljava/lang/Object;)Z
    new-array v3, v1, [Landroid/net/Uri;
    iput-object v3, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b0 [Landroid/net/Uri;
    const-string v3, "detect_subtitle"
    invoke-virtual v2, v3, v1, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String; Z)Z
    move-result v2
    iput-boolean v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e0 Z
    if-eqz v2, +009h
    iget-object v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    array-length v2, v2
    new-array v2, v2, [Z
    iput-object v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f0 [Z
    iget-boolean v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0 Z
    if-eqz v2, +00eh
    iget v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h0 I
    if-ne v2, v4, +006h
    invoke-direct v10, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G3(I)V
    goto +10h
    invoke-direct v10, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G3(I)V
    goto +ch
    iget v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g0 I
    if-ne v2, v4, +006h
    invoke-direct v10, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G3(I)V
    goto +4h
    invoke-direct v10, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G3(I)V
    iget-object v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    array-length v3, v2
    const/4 v4, 0
    if-ge v4, v3, +02dh
    aget-object v6, v2, v4
    invoke-static v10, v6, Lcom/alphainventor/filemanager/service/b;->k(Landroid/content/Context; Landroid/net/Uri;)Z
    move-result v7
    if-eqz v7, +017h
    iput-boolean v1, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x1 Z
    iput-boolean v1, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s1 Z
    invoke-virtual v6, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v6
    invoke-static v6, Lax/k3/c;->z(Ljava/lang/String;)Lax/T2/j;
    move-result-object v6
    if-eqz v6, +015h
    invoke-virtual v6, Lax/T2/j;->d()Lax/W2/F;
    move-result-object v6
    iput-object v6, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t1 Lax/W2/F;
    goto +dh
    invoke-virtual v6, Landroid/net/Uri;->getScheme()Ljava/lang/String;
    move-result-object v6
    invoke-static v6, Lax/W2/w;->J(Ljava/lang/String;)Z
    move-result v6
    if-eqz v6, +004h
    iput-boolean v1, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x1 Z
    add-int/2addr v4, v1
    goto -2ch
    iget-boolean v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s1 Z
    if-eqz v2, +00fh
    iget-object v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t1 Lax/W2/F;
    if-eqz v2, +00bh
    invoke-static v10, Lcom/alphainventor/filemanager/service/b;->f(Landroid/content/Context;)Lcom/alphainventor/filemanager/service/b;
    move-result-object v2
    iget-object v3, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t1 Lax/W2/F;
    invoke-virtual v2, v1, v3, Lcom/alphainventor/filemanager/service/b;->l(Z Lax/W2/F;)V
    iget-object v2, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    array-length v2, v2
    new-array v2, v2, [Lax/P0/y;
    iget-object v3, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    array-length v4, v3
    if-ge v0, v4, +00ch
    aget-object v3, v3, v0
    invoke-static v3, Lax/P0/y;->b(Landroid/net/Uri;)Lax/P0/y;
    move-result-object v3
    aput-object v3, v2, v0
    add-int/2addr v0, v1
    goto -eh
    invoke-static v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F2([Landroid/net/Uri;)Z
    move-result v0
    if-nez v0, +01ch
    invoke-static v2, Lax/S0/c0;->l([Lax/P0/y;)Z
    move-result v0
    if-nez v0, +003h
    goto +14h
    invoke-static Lax/R2/Q;->y0()Z
    move-result v0
    if-eqz v0, +009h
    invoke-static Lax/q3/o;->c()Z
    move-result v0
    if-eqz v0, +003h
    return-void 
    iget-object v0, v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    invoke-static v10, v0, Lax/S0/c0;->T0(Landroid/app/Activity; [Landroid/net/Uri;)Z
    return-void 
    invoke-direct v10, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V3(I)V
    return-void 
    invoke-direct v10, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V3(I)V
    invoke-virtual v10, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->finish()V
    return-void 
.end method

.method L3(I)V
    .registers 3
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    return-void 
    iput v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o0 I
    invoke-interface v0, v2, Lax/P0/H;->j(I)V
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q4()V
    return-void 
.end method

.method M(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a4()V
    return-void 
.end method

.method M0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J3(Z)V
    return-void 
.end method

.method M1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l3()V
    return-void 
.end method

.method M2()V
    .registers 7
    invoke-static v6, Lax/p3/m;->e(Landroid/content/Context;)Z
    move-result v0
    invoke-direct v6, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M3(Z)V
    invoke-direct v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L2()V
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    const/4 v1, 1
    if-eqz v0, +0cfh
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +0cbh
    invoke-direct v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I2()V
    invoke-static Lax/R2/J;->i()Z
    move-result v0
    const/4 v2, 2
    if-eqz v0, +005h
    invoke-static v2, Lax/W0/a;->H0(I)V
    new-instance v0, Lax/g1/a$b;
    invoke-direct v0, Lax/g1/a$b;-><init>()V
    new-instance v3, Lax/X0/d;
    invoke-direct v3, v6, Lax/X0/d;-><init>(Landroid/content/Context;)V
    invoke-virtual v3, v1, Lax/X0/d;->o(I)Lax/X0/d;
    invoke-static v6, Lax/p3/m;->h(Landroid/content/Context;)Z
    move-result v4
    if-eqz v4, +017h
    invoke-static v6, Lax/p3/m;->f(Landroid/content/Context;)Ljava/lang/String;
    move-result-object v4
    invoke-static v4, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
    move-result v5
    if-nez v5, +00ah
    const-string v5, "default"
    invoke-virtual v5, v4, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-eqz v5, +007h
    iget-object v4, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q Ljava/lang/String;
    goto +3h
    const-string v4, ""
    iput-object v4, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R Ljava/lang/String;
    new-instance v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$u;
    invoke-direct v5, v6, v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$u;-><init>(Landroid/content/Context; Lax/g1/D$b; Ljava/lang/String;)V
    iput-object v5, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N0 Lax/g1/n;
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O0 Lax/g1/n$e;
    invoke-virtual v5, v0, Lax/g1/n;->m(Lax/P0/S;)V
    const/4 v0, 0
    iput-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P0 Lax/p7/z;
    new-instance v4, Landroidx/media3/exoplayer/j;
    invoke-direct v4, Landroidx/media3/exoplayer/j;-><init>()V
    new-instance v5, Landroidx/media3/exoplayer/ExoPlayer$b;
    invoke-direct v5, v6, v3, Landroidx/media3/exoplayer/ExoPlayer$b;-><init>(Landroid/content/Context; Lax/X0/W;)V
    iget-object v3, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N0 Lax/g1/n;
    invoke-virtual v5, v3, Landroidx/media3/exoplayer/ExoPlayer$b;->k(Lax/g1/J;)Landroidx/media3/exoplayer/ExoPlayer$b;
    invoke-virtual v5, v4, Landroidx/media3/exoplayer/ExoPlayer$b;->h(Landroidx/media3/exoplayer/m0;)Landroidx/media3/exoplayer/ExoPlayer$b;
    const-wide/16 v3, 10000
    invoke-virtual v5, v3, v4, Landroidx/media3/exoplayer/ExoPlayer$b;->i(J)Landroidx/media3/exoplayer/ExoPlayer$b;
    invoke-virtual v5, v3, v4, Landroidx/media3/exoplayer/ExoPlayer$b;->j(J)Landroidx/media3/exoplayer/ExoPlayer$b;
    invoke-virtual v5, Landroidx/media3/exoplayer/ExoPlayer$b;->g()Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v3
    iput-object v3, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    sget-object v4, Lax/X0/Y;->g Lax/X0/Y;
    invoke-interface v3, v4, Landroidx/media3/exoplayer/ExoPlayer;->a(Lax/X0/Y;)V
    iget-object v3, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    new-instance v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;
    invoke-direct v4, v6, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;)V
    invoke-interface v3, v4, Lax/P0/H;->H(Lax/P0/H$d;)V
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    iget-boolean v3, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m1 Z
    invoke-interface v0, v3, Lax/P0/H;->L(Z)V
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    new-instance v3, Lax/i1/a;
    iget-object v4, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N0 Lax/g1/n;
    invoke-direct v3, v4, Lax/i1/a;-><init>(Lax/g1/G;)V
    invoke-interface v0, v3, Landroidx/media3/exoplayer/ExoPlayer;->j0(Lax/Y0/c;)V
    iget-boolean v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x1 Z
    if-eqz v0, +008h
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, v2, Landroidx/media3/exoplayer/ExoPlayer;->c(I)V
    goto +6h
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, v1, Landroidx/media3/exoplayer/ExoPlayer;->c(I)V
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    iget-object v2, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-virtual v0, v2, Landroidx/media3/ui/PlayerView;->setPlayer(Lax/P0/H;)V
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->G()V
    new-instance v0, Lcom/alphainventor/filemanager/viewer/a;
    new-instance v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$r;
    invoke-direct v2, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$r;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    const/high16 v3, 1069547520
    invoke-direct v0, v6, v3, v2, Lcom/alphainventor/filemanager/viewer/a;-><init>(Landroid/content/Context; F Lcom/alphainventor/filemanager/viewer/a$b;)V
    new-instance v2, Landroid/view/ScaleGestureDetector;
    iget-object v3, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M1 Landroid/view/ScaleGestureDetector$SimpleOnScaleGestureListener;
    invoke-direct v2, v6, v3, Landroid/view/ScaleGestureDetector;-><init>(Landroid/content/Context; Landroid/view/ScaleGestureDetector$OnScaleGestureListener;)V
    new-instance v3, Landroid/view/GestureDetector;
    iget-object v4, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N1 Landroid/view/GestureDetector$SimpleOnGestureListener;
    invoke-direct v3, v6, v4, Landroid/view/GestureDetector;-><init>(Landroid/content/Context; Landroid/view/GestureDetector$OnGestureListener;)V
    iget-object v4, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    new-instance v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;
    invoke-direct v5, v6, v2, v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Landroid/view/ScaleGestureDetector; Landroid/view/GestureDetector; Lcom/alphainventor/filemanager/viewer/a;)V
    invoke-virtual v4, v5, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    iget-object v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-eqz v0, +022h
    iget v2, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n1 I
    const/4 v3, -1
    if-eq v2, v3, +004h
    const/4 v3, 1
    goto +2h
    const/4 v3, 0
    if-eqz v3, +007h
    iget-wide v4, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1 J
    invoke-interface v0, v2, v4, v5, Lax/P0/H;->p(I J)V
    invoke-direct v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J2()V
    invoke-direct v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k4()V
    invoke-direct v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n4()V
    invoke-direct v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    xor-int/2addr v1, v3
    invoke-direct v6, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r3(I Z)V
    return-void 
.end method

.method M3(Z)V
    .registers 2
    iput-boolean v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0 Z
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r4()V
    return-void 
.end method

.method N(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d Ljava/lang/Runnable;
    return-object v1
.end method

.method N0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c2()V
    return-void 
.end method

.method N1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F3(Z)V
    return-void 
.end method

.method N2(F)V
    .registers 7
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-eqz v0, +0bdh
    invoke-interface v0, Lax/P0/H;->b()Z
    move-result v0
    if-eqz v0, +0b7h
    const/4 v0, 1
    iput-boolean v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H0 Z
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E Landroid/widget/TextView;
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Lax/P0/H;->G()Lax/S0/I;
    move-result-object v0
    const/high16 v2, 1056964608
    cmpl-float v2, v6, v2
    if-nez v2, +00ah
    iget-object v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E Landroid/widget/TextView;
    const-string v3, "0.5X▶▶"
    invoke-virtual v2, v3, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    goto +28h
    const/high16 v2, 1073741824
    cmpl-float v2, v6, v2
    if-nez v2, +00ah
    iget-object v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E Landroid/widget/TextView;
    const-string v3, "2X▶▶"
    invoke-virtual v2, v3, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    goto +1ah
    invoke-static Lax/q3/b;->f()V
    iget-object v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E Landroid/widget/TextView;
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct v3, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v3, v6, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;
    const-string v4, "X▶▶"
    invoke-virtual v3, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v3, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-virtual v2, v3, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    invoke-virtual v0, Lax/S0/I;->a()I
    move-result v2
    const/4 v3, -1
    if-eq v2, v3, +033h
    iget-object v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v2, Landroid/view/View;->getHeight()I
    move-result v2
    if-eqz v2, +02bh
    iget-object v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v2, Landroid/view/View;->getHeight()I
    move-result v2
    invoke-virtual v0, Lax/S0/I;->a()I
    move-result v3
    if-le v2, v3, +01fh
    const/16 v2, 10
    invoke-static v5, v2, Lax/q3/A;->e(Landroid/content/Context; I)I
    move-result v2
    iget-object v3, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v3, Landroid/view/View;->getHeight()I
    move-result v3
    invoke-virtual v0, Lax/S0/I;->a()I
    move-result v0
    sub-int/2addr v3, v0
    div-int/lit8 v3, v3, 2
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E Landroid/widget/TextView;
    invoke-virtual v0, Landroid/view/View;->getHeight()I
    move-result v0
    sub-int/2addr v3, v0
    sub-int/2addr v3, v2
    if-gez v3, +003h
    const/4 v3, 0
    if-nez v3, +025h
    invoke-virtual v5, Lax/n/c;->getSupportActionBar()Lax/n/a;
    move-result-object v0
    if-eqz v0, +00dh
    invoke-virtual v0, Lax/n/a;->p()Z
    move-result v2
    if-eqz v2, +007h
    invoke-virtual v0, Lax/n/a;->l()I
    move-result v0
    goto +2h
    const/4 v0, 0
    if-lez v0, +00bh
    const/16 v2, 25
    invoke-static v5, v2, Lax/q3/A;->e(Landroid/content/Context; I)I
    move-result v2
    add-int v3, v2, v0
    goto +7h
    const/4 v2, 5
    invoke-static v5, v2, Lax/q3/A;->e(Landroid/content/Context; I)I
    move-result v2
    goto -8h
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E Landroid/widget/TextView;
    invoke-virtual v0, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;
    move-result-object v0
    check-cast v0, Landroid/view/ViewGroup$MarginLayoutParams;
    invoke-virtual v0, v1, v3, v1, v1, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(I I I I)V
    iget-object v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E Landroid/widget/TextView;
    invoke-virtual v2, v0, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V
    invoke-direct v5, v6, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K3(F Z)V
    return-void 
.end method

.method N3(I Z)V
    .registers 11
    iget-object v0, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->getSubtitleView()Landroidx/media3/ui/SubtitleView;
    move-result-object v0
    if-eqz v10, +006h
    sget-object v10, Landroid/graphics/Typeface;->DEFAULT_BOLD Landroid/graphics/Typeface;
    move-object v7, v10
    goto +4h
    sget-object v10, Landroid/graphics/Typeface;->DEFAULT Landroid/graphics/Typeface;
    goto -4h
    new-instance v1, Lax/V1/a;
    const/4 v5, 2
    const/high16 v6, -16777216
    const/4 v2, -1
    const/4 v3, 0
    const/4 v4, 0
    invoke-direct/range v1 ... v7, Lax/V1/a;-><init>(I I I I I Landroid/graphics/Typeface;)V
    invoke-virtual v0, v1, Landroidx/media3/ui/SubtitleView;->setStyle(Lax/V1/a;)V
    const/4 v10, 2
    int-to-float v9, v9
    invoke-virtual v0, v10, v9, Landroidx/media3/ui/SubtitleView;->b(I F)V
    return-void 
.end method

.method O0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h4()V
    return-void 
.end method

.method O1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c4()V
    return-void 
.end method

.method O2()Z
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K0 Z
    return v0
.end method

.method O3(Ljava/lang/String;)V
    .registers 3
    invoke-virtual v1, Lax/n/c;->getSupportActionBar()Lax/n/a;
    move-result-object v0
    if-eqz v0, +005h
    invoke-virtual v0, v2, Lax/n/a;->H(Ljava/lang/CharSequence;)V
    return-void 
.end method

.method P(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e4()V
    return-void 
.end method

.method P0(Lax/P0/F;)Z
    .registers 1
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S2(Lax/P0/F;)Z
    move-result v0
    return v0
.end method

.method P1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n3()V
    return-void 
.end method

.method P2()Z
    .registers 2
    iget v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I0 I
    if-eqz v0, +004h
    const/4 v0, 1
    return v0
    const/4 v0, 0
    return v0
.end method

.method P3()V
    .registers 2
    invoke-virtual v1, Lax/n/c;->getSupportActionBar()Lax/n/a;
    move-result-object v0
    if-nez v0, +003h
    return-void 
    invoke-virtual v0, Lax/n/a;->J()V
    return-void 
.end method

.method Q()Z
    .registers 1
    sget-boolean v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T1 Z
    return v0
.end method

.method Q0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g2()V
    return-void 
.end method

.method Q1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u3()V
    return-void 
.end method

.method Q2()Z
    .registers 6
    iget-wide v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M0 J
    const-wide/16 v2, 0
    cmp-long v4, v0, v2
    if-eqz v4, +012h
    invoke-static Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0
    iget-wide v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M0 J
    sub-long/2addr v0, v2
    const-wide/32 v2, 90000
    cmp-long v4, v0, v2
    if-lez v4, +004h
    const/4 v0, 1
    goto +2h
    const/4 v0, 0
    if-eqz v0, +009h
    sget-object v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R1 Ljava/util/logging/Logger;
    const-string v2, "ad is expired"
    invoke-virtual v1, v2, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V
    return v0
.end method

.method Q3(Ljava/lang/String;)V
    .registers 4
    invoke-direct v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z2(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    invoke-static v2, Lax/s3/f;->s(Landroid/content/Context;)Z
    move-result v1
    if-nez v1, +02fh
    invoke-static v2, Lax/p3/m;->o(Landroid/content/Context;)Z
    move-result v1
    if-eqz v1, +008h
    invoke-static v2, Lax/s3/f;->r(Landroid/content/Context;)Z
    move-result v1
    if-nez v1, +023h
    invoke-static v3, Lax/s3/f;->q(Ljava/lang/String;)Z
    move-result v3
    if-eqz v3, +01dh
    invoke-static Lax/s3/f;->k()Ljava/lang/String;
    move-result-object v3
    if-eqz v3, +017h
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a Landroid/view/View;
    const/4 v1, -2
    invoke-static v3, v0, v1, Lax/q3/A;->Y(Landroid/view/View; Ljava/lang/CharSequence; I)Lcom/google/android/material/snackbar/Snackbar;
    move-result-object v3
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$a;
    invoke-direct v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$a;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    const v1, 2131951910
    invoke-virtual v3, v1, v0, Lcom/google/android/material/snackbar/Snackbar;->q0(I Landroid/view/View$OnClickListener;)Lcom/google/android/material/snackbar/Snackbar;
    iput-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G Lcom/google/android/material/snackbar/Snackbar;
    goto +8h
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a Landroid/view/View;
    const/4 v1, 0
    invoke-static v3, v0, v1, Lax/q3/A;->Y(Landroid/view/View; Ljava/lang/CharSequence; I)Lcom/google/android/material/snackbar/Snackbar;
    move-result-object v3
    invoke-virtual v3, Lcom/google/android/material/snackbar/Snackbar;->a0()V
    return-void 
.end method

.method R(Z)Z
    .registers 1
    sput-boolean v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T1 Z
    return v0
.end method

.method R0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M2()V
    return-void 
.end method

.method R1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d4()V
    return-void 
.end method

.method R2()Z
    .registers 5
    iget v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I0 I
    const/16 v1, 33
    const/4 v2, 1
    const/4 v3, 0
    if-eq v0, v1, +012h
    const/16 v1, 34
    if-ne v0, v1, +003h
    goto +ch
    const/16 v1, 17
    if-eq v0, v1, +008h
    const/16 v1, 18
    if-ne v0, v1, +003h
    goto +2h
    return v3
    return v2
    new-instance v0, Ljava/util/Random;
    invoke-direct v0, Ljava/util/Random;-><init>()V
    invoke-virtual v0, Ljava/util/Random;->nextBoolean()Z
    move-result v0
    if-eqz v0, +003h
    return v2
    return v3
.end method

.method R3()V
    .registers 1
    return-void 
.end method

.method S()Z
    .registers 1
    sget-boolean v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S1 Z
    return v0
.end method

.method S0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j3(Z)V
    return-void 
.end method

.method S1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f4()V
    return-void 
.end method

.method S2(Lax/P0/F;)Z
    .registers 3
    instance-of v0, v2, Landroidx/media3/exoplayer/s;
    const/4 v1, 0
    if-eqz v0, +014h
    check-cast v2, Landroidx/media3/exoplayer/s;
    iget v0, v2, Landroidx/media3/exoplayer/s;->k0 I
    if-eqz v0, +003h
    return v1
    invoke-virtual v2, Landroidx/media3/exoplayer/s;->i()Ljava/io/IOException;
    move-result-object v2
    if-eqz v2, +014h
    invoke-virtual v2, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;
    move-result-object v2
    goto -6h
    if-eqz v2, +00dh
    invoke-virtual v2, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;
    move-result-object v2
    if-eqz v2, +007h
    invoke-virtual v2, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;
    move-result-object v2
    goto -6h
    return v1
.end method

.method S3(Z)V
    .registers 3
    if-eqz v2, +009h
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z Landroid/view/View;
    const/4 v0, 0
    invoke-virtual v2, v0, Landroid/view/View;->setVisibility(I)V
    goto +8h
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z Landroid/view/View;
    const/16 v0, 8
    invoke-virtual v2, v0, Landroid/view/View;->setVisibility(I)V
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j4()V
    return-void 
.end method

.method T0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Lcom/alphainventor/filemanager/viewer/f;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D1 Lcom/alphainventor/filemanager/viewer/f;
    return-object v0
.end method

.method T1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d2()V
    return-void 
.end method

.method T2()Z
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F0 Z
    return v0
.end method

.method T3(Z)V
    .registers 5
    const v0, 2131362382
    invoke-virtual v3, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ImageView;
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setVisibility(I)V
    if-eqz v4, +009h
    const v4, 2131231119
    invoke-virtual v0, v4, Landroid/widget/ImageView;->setImageResource(I)V
    goto +7h
    const v4, 2131231118
    invoke-virtual v0, v4, Landroid/widget/ImageView;->setImageResource(I)V
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setVisibility(I)V
    new-instance v4, Landroid/view/animation/AlphaAnimation;
    const/4 v1, 0
    const/high16 v2, 1065353216
    invoke-direct v4, v1, v2, Landroid/view/animation/AlphaAnimation;-><init>(F F)V
    const-wide/16 v1, 750
    invoke-virtual v4, v1, v2, Landroid/view/animation/Animation;->setDuration(J)V
    new-instance v1, Landroid/view/animation/DecelerateInterpolator;
    invoke-direct v1, Landroid/view/animation/DecelerateInterpolator;-><init>()V
    invoke-virtual v4, v1, Landroid/view/animation/Animation;->setInterpolator(Landroid/view/animation/Interpolator;)V
    invoke-virtual v0, v4, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    new-instance v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$q;
    invoke-direct v1, v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$q;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Landroid/widget/ImageView;)V
    invoke-virtual v4, v1, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V
    return-void 
.end method

.method U(Z)Z
    .registers 1
    sput-boolean v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S1 Z
    return v0
.end method

.method U0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Lax/p7/z;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P0 Lax/p7/z;
    return-object v0
.end method

.method U1()V
    .registers 3
    const/4 v0, 0
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F0 Z
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B Landroid/view/View;
    const/16 v1, 8
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method U2(I)Z
    .registers 2
    const/16 v0, 23
    if-eq v1, v0, +00ch
    const/16 v0, 66
    if-eq v1, v0, +008h
    const/16 v0, 160
    if-eq v1, v0, +004h
    const/4 v1, 0
    return v1
    const/4 v1, 1
    return v1
.end method

.method U3(I)V
    .registers 4
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a Landroid/view/View;
    const/4 v1, 0
    invoke-static v0, v3, v1, Lax/q3/A;->X(Landroid/view/View; I I)Lcom/google/android/material/snackbar/Snackbar;
    move-result-object v3
    invoke-virtual v3, Lcom/google/android/material/snackbar/Snackbar;->a0()V
    return-void 
.end method

.method V(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Ljava/lang/String;)Ljava/lang/String;
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z2(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method V0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lax/p7/z;)Lax/p7/z;
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P0 Lax/p7/z;
    return-object v1
.end method

.method V1()V
    .registers 3
    invoke-virtual v2, Landroid/app/Activity;->getWindow()Landroid/view/Window;
    move-result-object v0
    invoke-virtual v0, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->screenBrightness F
    const/4 v1, 0
    cmpl-float v1, v0, v1
    if-ltz v1, +00bh
    const/high16 v1, 1065353216
    cmpg-float v1, v0, v1
    if-gtz v1, +005h
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G0 F
    goto +5h
    const/high16 v0, 1056964608
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G0 F
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D Landroid/widget/ProgressBar;
    const/16 v1, 255
    invoke-virtual v0, v1, Landroid/widget/ProgressBar;->setMax(I)V
    const/4 v0, 1
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F0 Z
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B Landroid/view/View;
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D Landroid/widget/ProgressBar;
    const v1, 2131231544
    invoke-static v2, v1, Lax/o/a;->b(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    invoke-virtual v0, v1, Landroid/widget/ProgressBar;->setProgressDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C Landroid/widget/ImageView;
    const v1, 2131231196
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setImageResource(I)V
    return-void 
.end method

.method V2()Z
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s0 Z
    return v0
.end method

.method V3(I)V
    .registers 2
    invoke-virtual v0, v1, Landroid/content/Context;->getString(I)Ljava/lang/String;
    move-result-object v1
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W3(Ljava/lang/String;)V
    return-void 
.end method

.method W(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m3()V
    return-void 
.end method

.method W0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    .registers 2
    iput-boolean v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k0 Z
    return v1
.end method

.method W1()Lax/U0/g$a;
    .registers 4
    new-instance v0, Lax/h1/h$b;
    invoke-direct v0, v3, Lax/h1/h$b;-><init>(Landroid/content/Context;)V
    new-instance v1, Lax/U0/m;
    invoke-virtual v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D2()Ljava/lang/String;
    move-result-object v2
    invoke-virtual v0, Lax/h1/h$b;->a()Lax/h1/h;
    move-result-object v0
    invoke-direct v1, v3, v2, v0, Lax/U0/m;-><init>(Landroid/content/Context; Ljava/lang/String; Lax/U0/z;)V
    return-object v1
.end method

.method W2()Z
    .registers 2
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V2()Z
    move-result v0
    if-nez v0, +011h
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g3()Z
    move-result v0
    if-nez v0, +00bh
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T2()Z
    move-result v0
    if-eqz v0, +003h
    goto +3h
    const/4 v0, 0
    return v0
    const/4 v0, 1
    return v0
.end method

.method W3(Ljava/lang/String;)V
    .registers 3
    const/4 v0, 1
    invoke-static v1, v2, v0, Landroid/widget/Toast;->makeText(Landroid/content/Context; Ljava/lang/CharSequence; I)Landroid/widget/Toast;
    move-result-object v2
    invoke-virtual v2, Landroid/widget/Toast;->show()V
    return-void 
.end method

.method X(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    iget-boolean v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r1 Z
    return v0
.end method

.method X0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)I
    .registers 2
    iput v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l0 I
    return v1
.end method

.method X1(I)Lax/P0/y;
    .registers 4
    invoke-direct v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A2(I)I
    move-result v3
    iget-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e0 Z
    if-eqz v0, +01dh
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f0 [Z
    aget-boolean v0, v0, v3
    if-nez v0, +017h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b0 [Landroid/net/Uri;
    aget-object v1, v0, v3
    if-nez v1, +011h
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    aget-object v1, v1, v3
    invoke-direct v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t2(Landroid/net/Uri;)Landroid/net/Uri;
    move-result-object v1
    aput-object v1, v0, v3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f0 [Z
    const/4 v1, 1
    aput-boolean v1, v0, v3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    aget-object v0, v0, v3
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b0 [Landroid/net/Uri;
    aget-object v3, v1, v3
    const/4 v1, 0
    invoke-direct v2, v0, v3, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Y1(Landroid/net/Uri; Landroid/net/Uri; Ljava/lang/String;)Lax/P0/y;
    move-result-object v3
    return-object v3
.end method

.method X2()Z
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z Landroid/view/View;
    invoke-virtual v0, Landroid/view/View;->getVisibility()I
    move-result v0
    if-nez v0, +004h
    const/4 v0, 1
    return v0
    const/4 v0, 0
    return v0
.end method

.method X3()V
    .registers 5
    invoke-virtual v4, Landroidx/fragment/app/f;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;
    move-result-object v0
    invoke-virtual v0, Landroidx/fragment/app/FragmentManager;->P0()Z
    move-result v0
    if-eqz v0, +003h
    return-void 
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    const/4 v1, 1
    if-eqz v0, +010h
    invoke-interface v0, Lax/P0/H;->b()Z
    move-result v0
    if-eqz v0, +00ah
    iput-boolean v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H1 Z
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Lax/P0/H;->f()V
    goto +4h
    const/4 v0, 0
    iput-boolean v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H1 Z
    invoke-static Lax/U2/W;->i3()Lax/U2/W;
    move-result-object v0
    invoke-virtual v4, Landroidx/fragment/app/f;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;
    move-result-object v2
    const-string v3, "settings"
    invoke-static v2, v0, v3, v1, Lax/q3/A;->g0(Landroidx/fragment/app/FragmentManager; Landroidx/fragment/app/e; Ljava/lang/String; Z)V
    return-void 
.end method

.method Y0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    .registers 3
    iget v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l0 I
    add-int/lit8 v1, v0, 1
    iput v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l0 I
    return v0
.end method

.method Y1(Landroid/net/Uri; Landroid/net/Uri; Ljava/lang/String;)Lax/P0/y;
    .registers 5
    new-instance v4, Lax/P0/y$c;
    invoke-direct v4, Lax/P0/y$c;-><init>()V
    invoke-virtual v4, v2, Lax/P0/y$c;->f(Landroid/net/Uri;)Lax/P0/y$c;
    if-nez v3, +007h
    invoke-virtual v4, Lax/P0/y$c;->a()Lax/P0/y;
    move-result-object v2
    return-object v2
    invoke-virtual v3, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v2
    invoke-static v2, Lax/W2/Y;->f(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    invoke-static v2, Lax/W2/v;->n(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    new-instance v0, Lax/P0/y$k$a;
    invoke-direct v0, v3, Lax/P0/y$k$a;-><init>(Landroid/net/Uri;)V
    const/4 v3, 1
    invoke-virtual v0, v3, Lax/P0/y$k$a;->l(I)Lax/P0/y$k$a;
    invoke-virtual v0, v2, Lax/P0/y$k$a;->k(Ljava/lang/String;)Lax/P0/y$k$a;
    invoke-virtual v0, Lax/P0/y$k$a;->i()Lax/P0/y$k;
    move-result-object v2
    invoke-static v2, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;
    move-result-object v2
    invoke-virtual v4, v2, Lax/P0/y$c;->d(Ljava/util/List;)Lax/P0/y$c;
    invoke-virtual v4, Lax/P0/y$c;->a()Lax/P0/y;
    move-result-object v2
    return-object v2
.end method

.method Y2()Z
    .registers 4
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y2()Landroid/net/Uri;
    move-result-object v0
    const/4 v1, 0
    if-nez v0, +003h
    return v1
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y2()Landroid/net/Uri;
    move-result-object v0
    invoke-virtual v0, Landroid/net/Uri;->getScheme()Ljava/lang/String;
    move-result-object v0
    const-string v2, "file"
    invoke-virtual v2, v0, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +00ch
    const-string v2, "content"
    invoke-virtual v2, v0, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, +003h
    goto +2h
    return v1
    const/4 v0, 1
    return v0
.end method

.method Z(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)F
    .registers 1
    iget v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    return v0
.end method

.method Z0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)I
    .registers 2
    iput v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m0 I
    return v1
.end method

.method Z1(F I F F)F
    .registers 8
    sub-float/2addr v6, v7
    int-to-float v5, v5
    const/high16 v7, 1073741824
    div-float v0, v5, v7
    div-float/2addr v4, v7
    add-float v7, v6, v0
    sub-float v1, v7, v4
    add-float/2addr v7, v4
    const/4 v2, 0
    cmpl-float v1, v1, v2
    if-lez v1, +004h
    sub-float/2addr v4, v0
    return v4
    cmpg-float v5, v7, v5
    if-gez v5, +004h
    sub-float/2addr v0, v4
    return v0
    return v6
.end method

.method Z2()Z
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H0 Z
    return v0
.end method

.method Z3()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->I()Z
    move-result v0
    if-eqz v0, +008h
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->G()V
    return-void 
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->V()V
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c2()V
    return-void 
.end method

.method a0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z4()V
    return-void 
.end method

.method a1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    .registers 3
    iget v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m0 I
    add-int/lit8 v1, v0, 1
    iput v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m0 I
    return v0
.end method

.method a2(F F F F)F
    .registers 6
    add-float v0, v2, v3
    sub-float v0, v4, v0
    mul-float v5, v5, v0
    sub-float/2addr v4, v5
    sub-float/2addr v2, v4
    add-float/2addr v2, v3
    return v2
.end method

.method a3()Z
    .registers 2
    invoke-static v1, Lax/q3/y;->u(Landroid/content/Context;)Z
    move-result v0
    return v0
.end method

.method a4()V
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n0 Z
    xor-int/lit8 v0, v0, 1
    invoke-direct v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F3(Z)V
    return-void 
.end method

.method b0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V2()Z
    move-result v0
    return v0
.end method

.method b1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Lax/g1/n;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N0 Lax/g1/n;
    return-object v0
.end method

.method b2()V
    .registers 3
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f3()Z
    move-result v0
    if-eqz v0, +00ch
    const/4 v0, 1
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z1 Z
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A1 Landroid/os/Handler;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J1 Ljava/lang/Runnable;
    invoke-virtual v0, v1, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    return-void 
.end method

.method b3()Z
    .registers 3
    iget v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I0 I
    const/4 v1, 2
    if-eq v0, v1, +00dh
    const/16 v1, 18
    if-eq v0, v1, +009h
    const/16 v1, 34
    if-ne v0, v1, +003h
    goto +3h
    const/4 v0, 0
    return v0
    const/4 v0, 1
    return v0
.end method

.method b4()V
    .registers 4
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    goto +13h
    invoke-interface v0, Lax/P0/H;->r()Z
    move-result v0
    xor-int/lit8 v1, v0, 1
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v2, v1, Lax/P0/H;->L(Z)V
    if-nez v0, +007h
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->G()V
    return-void 
.end method

.method c0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o2()V
    return-void 
.end method

.method c1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    .registers 1
    iget v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q1 I
    return v0
.end method

.method c2()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->getControllerAutoShow()Z
    move-result v0
    if-nez v0, +00eh
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V2()Z
    move-result v0
    if-nez v0, +008h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    const/4 v1, 1
    invoke-virtual v0, v1, Landroidx/media3/ui/PlayerView;->setControllerAutoShow(Z)V
    return-void 
.end method

.method c3()Z
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z0 Z
    return v0
.end method

.method c4()V
    .registers 4
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    return-void 
    invoke-interface v0, Lax/P0/H;->o()I
    move-result v1
    const/4 v2, 3
    invoke-static v1, v2, Lax/S0/H;->a(I I)I
    move-result v1
    invoke-interface v0, v1, Lax/P0/H;->j(I)V
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q4()V
    return-void 
.end method

.method d0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g3()Z
    move-result v0
    return v0
.end method

.method d1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lax/p7/z; Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    invoke-direct v0, v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B2(Lax/p7/z; Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method d2()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D1 Lcom/alphainventor/filemanager/viewer/f;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    invoke-virtual v0, v1, Lcom/alphainventor/filemanager/viewer/f;->n(Landroid/view/View;)V
    return-void 
.end method

.method d3()Z
    .registers 5
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    const/4 v1, 0
    if-nez v0, +003h
    return v1
    invoke-interface v0, Lax/P0/H;->G()Lax/S0/I;
    move-result-object v0
    invoke-virtual v0, Lax/S0/I;->a()I
    move-result v2
    const/4 v3, -1
    if-eq v2, v3, +012h
    invoke-virtual v0, Lax/S0/I;->b()I
    move-result v0
    if-eq v0, v3, +00ch
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroid/view/View;->getHeight()I
    move-result v0
    if-eqz v0, +004h
    const/4 v0, 1
    return v0
    return v1
.end method

.method d4()V
    .registers 5
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->getResizeMode()I
    move-result v0
    const/4 v1, 3
    if-eqz v0, +01ch
    const/4 v2, 4
    if-eq v0, v1, +012h
    const/4 v1, 0
    if-eq v0, v2, +00ah
    invoke-static Lax/q3/b;->f()V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q0 Landroid/graphics/drawable/Drawable;
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a1 Ljava/lang/String;
    goto +11h
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q0 Landroid/graphics/drawable/Drawable;
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a1 Ljava/lang/String;
    goto +ch
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S0 Landroid/graphics/drawable/Drawable;
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c1 Ljava/lang/String;
    move-object v2, v1
    const/4 v1, 4
    goto +5h
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R0 Landroid/graphics/drawable/Drawable;
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b1 Ljava/lang/String;
    iget-object v3, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v3, v1, Landroidx/media3/ui/PlayerView;->setResizeMode(I)V
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r Landroid/widget/ImageButton;
    invoke-virtual v1, v0, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r Landroid/widget/ImageButton;
    invoke-virtual v0, v2, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L1 Ljava/lang/Runnable;
    invoke-virtual v0, v1, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    invoke-virtual v0, v2, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L1 Ljava/lang/Runnable;
    const-wide/16 v2, 1000
    invoke-virtual v0, v1, v2, v3, Landroid/view/View;->postDelayed(Ljava/lang/Runnable; J)Z
    return-void 
.end method

.method e0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x4()V
    return-void 
.end method

.method e1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Ljava/lang/String;
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k2()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method e2()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N Landroid/view/View;
    if-eqz v0, +005h
    invoke-static v0, v1, Lax/M2/b;->a(Ljava/lang/Object; Landroid/content/Context;)V
    const/4 v0, 0
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N Landroid/view/View;
    const/4 v0, 0
    iput-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P Z
    iput-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J0 Z
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K Landroid/view/ViewGroup;
    invoke-virtual v0, Landroid/view/ViewGroup;->removeAllViews()V
    return-void 
.end method

.method e3()Z
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P Z
    return v0
.end method

.method e4()V
    .registers 4
    iget-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0 Z
    xor-int/lit8 v0, v0, 1
    iput-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0 Z
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    iget-boolean v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0 Z
    if-eqz v1, +01fh
    const/4 v1, 0
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0 Ljava/util/List;
    invoke-interface v2, Ljava/util/List;->size()I
    move-result v2
    if-ge v1, v2, +025h
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0 Ljava/util/List;
    invoke-interface v2, v1, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/Integer;
    invoke-virtual v2, Ljava/lang/Integer;->intValue()I
    move-result v2
    if-ne v0, v2, +005h
    invoke-direct v3, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G3(I)V
    add-int/lit8 v1, v1, 1
    goto -1bh
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->c0 Ljava/util/List;
    invoke-interface v1, v0, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Ljava/lang/Integer;
    invoke-virtual v0, Ljava/lang/Integer;->intValue()I
    move-result v0
    invoke-direct v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G3(I)V
    iget-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0 Z
    invoke-static v3, v0, Lax/p3/m;->k(Landroid/content/Context; Z)V
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r4()V
    return-void 
.end method

.method f0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T2()Z
    move-result v0
    return v0
.end method

.method f1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Ljava/lang/String;)V
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q3(Ljava/lang/String;)V
    return-void 
.end method

.method f2()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    const/high16 v1, 1065353216
    invoke-virtual v0, v1, Landroid/view/View;->setScaleX(F)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    invoke-virtual v0, v1, Landroid/view/View;->setScaleY(F)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/view/View;->setTranslationX(F)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    invoke-virtual v0, v1, Landroid/view/View;->setTranslationY(F)V
    return-void 
.end method

.method f3()Z
    .registers 2
    iget v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y1 I
    if-ltz v0, +004h
    const/4 v0, 1
    return v0
    const/4 v0, 0
    return v0
.end method

.method f4()V
    .registers 4
    iget v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l0 I
    const/4 v1, 1
    if-ne v0, v1, +019h
    sput-boolean v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T1 Z
    iget-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k0 Z
    if-eqz v0, +00ah
    sput-boolean v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S1 Z
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D1 Lcom/alphainventor/filemanager/viewer/f;
    invoke-virtual v0, Lcom/alphainventor/filemanager/viewer/f;->l()V
    return-void 
    const/4 v0, 0
    sput-boolean v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S1 Z
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D1 Lcom/alphainventor/filemanager/viewer/f;
    invoke-virtual v0, Lcom/alphainventor/filemanager/viewer/f;->k()V
    return-void 
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D1 Lcom/alphainventor/filemanager/viewer/f;
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P1 Lcom/alphainventor/filemanager/viewer/f$h;
    invoke-virtual v0, v1, v2, Lcom/alphainventor/filemanager/viewer/f;->o(Landroid/view/View; Lcom/alphainventor/filemanager/viewer/f$h;)V
    return-void 
.end method

.method g0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->U1()V
    return-void 
.end method

.method g1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    .registers 2
    iput-boolean v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j0 Z
    return v1
.end method

.method g2()V
    .registers 3
    const/4 v0, 1
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m1 Z
    const/4 v0, -1
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n1 I
    const-wide v0, -9223372036854775807
    iput-wide v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1 J
    return-void 
.end method

.method g3()Z
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C0 Z
    return v0
.end method

.method g4()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    invoke-virtual v0, Landroidx/media3/ui/d;->n0()Z
    move-result v0
    if-nez v0, +006h
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G2()V
    return-void 
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X2()Z
    move-result v0
    if-eqz v0, +006h
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P3()V
    return-void 
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r1 Z
    if-eqz v0, +006h
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G2()V
    return-void 
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P3()V
    return-void 
.end method

.method h0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z2()Z
    move-result v0
    return v0
.end method

.method h1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u4()V
    return-void 
.end method

.method h2()V
    .registers 3
    const/4 v0, 1
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K0 Z
    invoke-static Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0
    iput-wide v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L0 J
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e2()V
    return-void 
.end method

.method h3()Z
    .registers 2
    iget-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A0 Z
    return v0
.end method

.method h4()V
    .registers 8
    iget-object v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    return-void 
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O2()Z
    move-result v0
    const/4 v1, 0
    if-eqz v0, +011h
    invoke-static Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v2
    iget-wide v4, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L0 J
    sub-long/2addr v2, v4
    const-wide/16 v4, 30000
    cmp-long v0, v2, v4
    if-lez v0, +004h
    iput-boolean v1, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K0 Z
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b3()Z
    move-result v0
    const/4 v2, 1
    if-eqz v0, +016h
    iget-object v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Lax/P0/H;->r()Z
    move-result v0
    if-eqz v0, +015h
    iget-object v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Lax/P0/H;->i()I
    move-result v0
    const/4 v3, 4
    if-ne v0, v3, +003h
    goto +ah
    const/4 v2, 0
    goto +8h
    iget-object v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Lax/P0/H;->r()Z
    move-result v0
    xor-int/2addr v2, v0
    const/16 v0, 8
    if-eqz v2, +092h
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O2()Z
    move-result v2
    if-nez v2, +08ch
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V2()Z
    move-result v2
    if-nez v2, +086h
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P2()Z
    move-result v2
    if-eqz v2, +080h
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a3()Z
    move-result v2
    if-eqz v2, +004h
    goto/16 +078h
    iget-object v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J Landroid/view/ViewGroup;
    invoke-virtual v2, v1, Landroid/view/View;->setVisibility(I)V
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E2()Z
    move-result v2
    if-eqz v2, +008h
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q2()Z
    move-result v2
    if-eqz v2, +005h
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A3()V
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e3()Z
    move-result v2
    if-eqz v2, +053h
    iget-wide v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M0 J
    const-wide/16 v4, 0
    cmp-long v6, v2, v4
    if-nez v6, +008h
    invoke-static Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v2
    iput-wide v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M0 J
    iget-boolean v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O Z
    if-eqz v2, +036h
    iget-object v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N Landroid/view/View;
    const v3, 2131362486
    invoke-virtual v2, v3, Landroid/view/View;->findViewById(I)Landroid/view/View;
    move-result-object v2
    if-eqz v2, +02bh
    invoke-virtual v7, Lax/n/c;->getResources()Landroid/content/res/Resources;
    move-result-object v3
    invoke-virtual v3, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;
    move-result-object v3
    iget v3, v3, Landroid/util/DisplayMetrics;->heightPixels I
    invoke-static v7, v3, Lax/q3/A;->f(Landroid/content/Context; I)I
    move-result v3
    const/16 v4, 150
    const/16 v5, 360
    if-gt v3, v5, +00ah
    sub-int/2addr v5, v3
    sub-int/2addr v4, v5
    const/16 v3, 60
    if-ge v4, v3, +004h
    const/16 v4, 60
    invoke-virtual v2, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;
    move-result-object v3
    invoke-static v7, v4, Lax/q3/A;->e(Landroid/content/Context; I)I
    move-result v4
    iput v4, v3, Landroid/view/ViewGroup$LayoutParams;->height I
    invoke-virtual v2, v3, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V
    iget-object v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M Landroid/view/View;
    invoke-virtual v2, v0, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
    iget-object v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M Landroid/view/View;
    invoke-virtual v2, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v1, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L Landroid/view/View;
    invoke-virtual v1, v0, Landroid/view/View;->setVisibility(I)V
    return-void 
    iget-object v1, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J Landroid/view/ViewGroup;
    invoke-virtual v1, v0, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method i0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k3()V
    return-void 
.end method

.method i1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i4()V
    return-void 
.end method

.method i2(Landroid/net/Uri;)Landroid/net/Uri;
    .registers 6
    invoke-static v5, Lcom/alphainventor/filemanager/provider/MyFileProvider;->w(Landroid/net/Uri;)Z
    move-result v0
    if-eqz v0, +033h
    invoke-static v5, Lcom/alphainventor/filemanager/provider/MyFileProvider;->d(Landroid/net/Uri;)Lax/T2/j;
    move-result-object v0
    invoke-virtual v0, Lax/T2/j;->e()Ljava/lang/String;
    move-result-object v1
    new-instance v2, Ljava/io/File;
    invoke-direct v2, v1, Ljava/io/File;-><init>(Ljava/lang/String;)V
    invoke-virtual v0, Lax/T2/j;->d()Lax/W2/F;
    move-result-object v0
    sget-object v3, Ljava/lang/Boolean;->FALSE Ljava/lang/Boolean;
    invoke-static v0, v1, v3, Lax/W2/Y;->v(Lax/W2/F; Ljava/lang/String; Ljava/lang/Boolean;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, +015h
    const-string v1, "/Android"
    invoke-virtual v0, v1, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, +00dh
    invoke-static v2, Lcom/alphainventor/filemanager/file/x;->K0(Ljava/io/File;)Lcom/alphainventor/filemanager/file/y;
    move-result-object v0
    invoke-virtual v0, Lcom/alphainventor/filemanager/file/y;->b1()Z
    move-result v0
    if-eqz v0, +003h
    goto +ch
    invoke-static v2, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;
    move-result-object v5
    return-object v5
    invoke-static v5, Lcom/alphainventor/filemanager/provider/MyFileProvider;->v(Landroid/net/Uri;)Z
    move-result v0
    if-eqz v0, +003h
    return-object v5
    invoke-static v5, Lcom/alphainventor/filemanager/provider/MyFileProvider;->y(Landroid/net/Uri;)Z
    return-object v5
.end method

.method i3(Z)V
    .registers 4
    invoke-static Lax/R2/Q;->t0()Z
    move-result v0
    const/4 v1, -1
    if-eqz v0, +00eh
    if-eqz v3, +008h
    const/16 v3, 14
    invoke-virtual v2, v3, Landroid/app/Activity;->setRequestedOrientation(I)V
    return-void 
    invoke-virtual v2, v1, Landroid/app/Activity;->setRequestedOrientation(I)V
    return-void 
    if-eqz v3, +00ah
    invoke-static v2, Lax/q3/y;->l(Landroid/app/Activity;)I
    move-result v3
    invoke-virtual v2, v3, Landroid/app/Activity;->setRequestedOrientation(I)V
    return-void 
    invoke-virtual v2, v1, Landroid/app/Activity;->setRequestedOrientation(I)V
    return-void 
.end method

.method i4()V
    .registers 3
    iget v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m0 I
    const/4 v1, 1
    if-le v0, v1, +009h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u Landroid/widget/ImageButton;
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u Landroid/widget/ImageButton;
    const/16 v1, 8
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method j0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/view/View;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H Landroid/view/View;
    return-object v0
.end method

.method j1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    .registers 1
    iget v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o0 I
    return v0
.end method

.method j3(Z)V
    .registers 3
    iput-boolean v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r1 Z
    if-eqz v2, +00ah
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    const/16 v0, 3000
    invoke-virtual v2, v0, Landroidx/media3/ui/PlayerView;->setControllerShowTimeoutMs(I)V
    goto +8h
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    const/16 v0, 5000
    invoke-virtual v2, v0, Landroidx/media3/ui/PlayerView;->setControllerShowTimeoutMs(I)V
    iget-boolean v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r1 Z
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i3(Z)V
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m4()V
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p4()V
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j4()V
    return-void 
.end method

.method j4()V
    .registers 3
    iget-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r1 Z
    if-eqz v0, +00ah
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X2()Z
    move-result v0
    if-nez v0, +004h
    const/4 v0, 1
    goto +2h
    const/4 v0, 0
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I1 Lax/i/r;
    invoke-virtual v1, v0, Lax/i/r;->j(Z)V
    return-void 
.end method

.method k0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Lax/P0/y;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Y Lax/P0/y;
    return-object v0
.end method

.method k1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)I
    .registers 2
    iput v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o0 I
    return v1
.end method

.method k2()Ljava/lang/String;
    .registers 2
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y2()Landroid/net/Uri;
    move-result-object v0
    if-nez v0, +005h
    const-string v0, ""
    return-object v0
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y2()Landroid/net/Uri;
    move-result-object v0
    invoke-virtual v0, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v0
    invoke-static v0, Lax/W2/q;->h(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method k3()V
    .registers 4
    const/4 v0, 0
    iput-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H0 Z
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E Landroid/widget/TextView;
    const/4 v2, 4
    invoke-virtual v1, v2, Landroid/view/View;->setVisibility(I)V
    iget v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p0 F
    invoke-direct v3, v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K3(F Z)V
    return-void 
.end method

.method k4()V
    .registers 1
    return-void 
.end method

.method l0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lax/P0/y;)Lax/P0/y;
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Y Lax/P0/y;
    return-object v1
.end method

.method l1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o3()V
    return-void 
.end method

.method l2()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y Landroidx/appcompat/widget/MySpinner;
    if-nez v0, +003h
    return-void 
    invoke-virtual v0, Landroidx/appcompat/widget/MySpinner;->c()V
    return-void 
.end method

.method l3()V
    .registers 2
    const/high16 v0, 1073741824
    invoke-direct v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N2(F)V
    return-void 
.end method

.method l4()V
    .registers 1
    return-void 
.end method

.method m0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)Lax/P0/y;
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X1(I)Lax/P0/y;
    move-result-object v0
    return-object v0
.end method

.method m1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q4()V
    return-void 
.end method

.method m2(Z)V
    .registers 18
    move-object/from16 v0, v16
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v1, +003h
    goto +36h
    invoke-interface v1, Lax/P0/H;->k0()J
    move-result-wide v1
    invoke-static v0, Lax/p3/m;->b(Landroid/content/Context;)I
    move-result v3
    int-to-long v3, v3
    const-wide/16 v5, 1000
    mul-long v3, v3, v5
    if-eqz v17, +005h
    add-long v7, v1, v3
    goto +3h
    sub-long v7, v1, v3
    iget-object v9, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v9, Lax/P0/H;->Y()J
    move-result-wide v9
    const-wide v11, -9223372036854775807
    const-wide/16 v13, 0
    cmp-long v15, v9, v11
    if-nez v15, +003h
    move-wide v9, v13
    cmp-long v11, v7, v13
    if-gez v11, +004h
    move-wide v7, v13
    goto +6h
    cmp-long v11, v7, v9
    if-lez v11, +003h
    move-wide v7, v9
    cmp-long v9, v1, v7
    if-nez v9, +003h
    return-void 
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    sget-object v2, Lax/X0/Y;->c Lax/X0/Y;
    invoke-interface v1, v2, Landroidx/media3/exoplayer/ExoPlayer;->a(Lax/X0/Y;)V
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v1, v7, v8, Lax/P0/H;->s(J)V
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    sget-object v2, Lax/X0/Y;->g Lax/X0/Y;
    invoke-interface v1, v2, Landroidx/media3/exoplayer/ExoPlayer;->a(Lax/X0/Y;)V
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    iget-object v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L1 Ljava/lang/Runnable;
    invoke-virtual v1, v2, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z
    if-eqz v17, +01dh
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct v2, Ljava/lang/StringBuilder;-><init>()V
    const-string v7, "+"
    invoke-virtual v2, v7, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-static v3, v4, Lax/q3/A;->q(J)Ljava/lang/String;
    move-result-object v3
    invoke-virtual v2, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v2, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-virtual v1, v2, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    goto +1bh
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct v2, Ljava/lang/StringBuilder;-><init>()V
    const-string v7, "-"
    invoke-virtual v2, v7, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-static v3, v4, Lax/q3/A;->q(J)Ljava/lang/String;
    move-result-object v3
    invoke-virtual v2, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v2, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-virtual v1, v2, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    iget-object v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L1 Ljava/lang/Runnable;
    invoke-virtual v1, v2, v5, v6, Landroid/view/View;->postDelayed(Ljava/lang/Runnable; J)Z
    return-void 
.end method

.method m3()V
    .registers 2
    const/high16 v0, 1056964608
    invoke-direct v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N2(F)V
    return-void 
.end method

.method m4()V
    .registers 4
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X2()Z
    move-result v0
    const/4 v1, 0
    const/16 v2, 8
    if-eqz v0, +03bh
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r Landroid/widget/ImageButton;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f Landroid/view/ViewGroup;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t Landroid/widget/ImageView;
    invoke-virtual v0, v2, Landroid/widget/ImageView;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    goto/16 +0bch
    iget-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r1 Z
    if-eqz v0, +01dh
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f Landroid/view/ViewGroup;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    goto/16 +09dh
    iget-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n0 Z
    if-eqz v0, +04eh
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r Landroid/widget/ImageButton;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f Landroid/view/ViewGroup;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t Landroid/widget/ImageView;
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t Landroid/widget/ImageView;
    const v2, 2131231112
    invoke-virtual v0, v2, Landroid/widget/ImageView;->setImageResource(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t Landroid/widget/ImageView;
    const v2, 2131952236
    invoke-virtual v3, v2, Landroid/content/Context;->getString(I)Ljava/lang/String;
    move-result-object v2
    invoke-virtual v0, v2, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    goto +4ch
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r Landroid/widget/ImageButton;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f Landroid/view/ViewGroup;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t Landroid/widget/ImageView;
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setVisibility(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t Landroid/widget/ImageView;
    const v2, 2131231134
    invoke-virtual v0, v2, Landroid/widget/ImageView;->setImageResource(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t Landroid/widget/ImageView;
    const v2, 2131952249
    invoke-virtual v3, v2, Landroid/content/Context;->getString(I)Ljava/lang/String;
    move-result-object v2
    invoke-virtual v0, v2, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s Landroid/view/View;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g4()V
    return-void 
.end method

.method n0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)V
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->U3(I)V
    return-void 
.end method

.method n1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p2()V
    return-void 
.end method

.method n2(J Z Z)V
    .registers 7
    if-eqz v6, +00bh
    iget-object v6, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    invoke-static v3, v4, Lax/q3/A;->q(J)Ljava/lang/String;
    move-result-object v0
    invoke-virtual v6, v0, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    iput-wide v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u0 J
    iget-boolean v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v0 Z
    if-eq v3, v5, +004h
    const/4 v3, 1
    goto +2h
    const/4 v3, 0
    iput-boolean v5, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v0 Z
    invoke-static Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v4
    if-nez v3, +00ch
    iget-wide v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t0 J
    sub-long/2addr v4, v0
    iget-wide v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w1 J
    cmp-long v6, v4, v0
    if-gez v6, +003h
    return-void 
    invoke-direct v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o4(Z)V
    return-void 
.end method

.method n3()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    goto +10h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C2()I
    move-result v1
    add-int/lit8 v1, v1, -1
    if-ge v0, v1, +005h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s3()V
    return-void 
.end method

.method n4()V
    .registers 6
    invoke-direct v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C2()I
    move-result v0
    const/4 v1, 0
    const/4 v2, 1
    if-lez v0, +004h
    const/4 v3, 1
    goto +2h
    const/4 v3, 0
    invoke-direct v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v4
    sub-int/2addr v0, v2
    if-ge v4, v0, +003h
    const/4 v1, 1
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o Landroid/view/View;
    invoke-direct v5, v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E3(Z Landroid/view/View;)V
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n Landroid/view/View;
    invoke-direct v5, v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E3(Z Landroid/view/View;)V
    return-void 
.end method

.method o0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    iget-boolean v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z1 Z
    return v0
.end method

.method o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    return-object v0
.end method

.method o2()V
    .registers 4
    const/4 v0, 0
    iput-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s0 Z
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    const-string v2, ""
    invoke-virtual v1, v2, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    iget-boolean v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q0 Z
    const/4 v2, 1
    if-nez v1, +007h
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v1, v2, Landroidx/media3/ui/PlayerView;->setUseController(Z)V
    iget-boolean v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r0 Z
    if-eqz v1, +009h
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-eqz v1, +005h
    invoke-interface v1, v2, Lax/P0/H;->L(Z)V
    invoke-direct v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o4(Z)V
    const-wide/16 v0, 0
    iput-wide v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t0 J
    iput-wide v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u0 J
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m4()V
    return-void 
.end method

.method o3()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    return-void 
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C2()I
    move-result v1
    add-int/lit8 v1, v1, -1
    if-ge v0, v1, +006h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s3()V
    return-void 
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q3()V
    return-void 
.end method

.method o4(Z)V
    .registers 7
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    goto +1eh
    invoke-interface v0, Lax/P0/H;->k0()J
    move-result-wide v0
    if-nez v6, +00dh
    iget-wide v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u0 J
    cmp-long v4, v0, v2
    if-gez v4, +007h
    iget-boolean v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v0 Z
    if-eqz v2, +003h
    goto +dh
    if-nez v6, +00dh
    iget-wide v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u0 J
    cmp-long v6, v0, v2
    if-lez v6, +007h
    iget-boolean v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v0 Z
    if-nez v6, +003h
    return-void 
    iget-boolean v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v0 Z
    if-eqz v6, +00ah
    iget-object v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    sget-object v0, Lax/X0/Y;->e Lax/X0/Y;
    invoke-interface v6, v0, Landroidx/media3/exoplayer/ExoPlayer;->a(Lax/X0/Y;)V
    goto +8h
    iget-object v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    sget-object v0, Lax/X0/Y;->f Lax/X0/Y;
    invoke-interface v6, v0, Landroidx/media3/exoplayer/ExoPlayer;->a(Lax/X0/Y;)V
    iget-object v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    iget-wide v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u0 J
    invoke-interface v6, v0, v1, Lax/P0/H;->s(J)V
    iget-object v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    sget-object v0, Lax/X0/Y;->g Lax/X0/Y;
    invoke-interface v6, v0, Landroidx/media3/exoplayer/ExoPlayer;->a(Lax/X0/Y;)V
    invoke-static Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0
    iput-wide v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t0 J
    return-void 
.end method

.method p0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r2()V
    return-void 
.end method

.method p1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; J Z Z)V
    .registers 5
    invoke-direct v0, v1, v2, v3, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n2(J Z Z)V
    return-void 
.end method

.method p2()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    goto +28h
    const/4 v0, 1
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s0 Z
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->I()Z
    move-result v0
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q0 Z
    const/4 v1, 0
    if-nez v0, +00ch
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, v1, Landroidx/media3/ui/PlayerView;->setUseController(Z)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, v1, Landroidx/media3/ui/PlayerView;->setControllerAutoShow(Z)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Lax/P0/H;->b()Z
    move-result v0
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r0 Z
    if-eqz v0, +007h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, v1, Lax/P0/H;->L(Z)V
    return-void 
.end method

.method p3(F F F)V
    .registers 8
    invoke-direct v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d3()Z
    move-result v0
    if-nez v0, +006h
    invoke-direct v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f2()V
    return-void 
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Lax/P0/H;->G()Lax/S0/I;
    move-result-object v0
    invoke-virtual v0, Lax/S0/I;->a()I
    move-result v1
    int-to-float v1, v1
    mul-float v1, v1, v5
    float-to-int v1, v1
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v2, Landroid/view/View;->getHeight()I
    move-result v2
    if-gt v1, v2, +003h
    goto +11h
    int-to-float v1, v1
    iget-object v3, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    invoke-virtual v3, Landroid/view/View;->getTranslationY()F
    move-result v3
    invoke-direct v4, v1, v2, v3, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z1(F I F F)F
    move-result v7
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    invoke-virtual v1, v7, Landroid/view/View;->setTranslationY(F)V
    invoke-virtual v0, Lax/S0/I;->b()I
    move-result v7
    int-to-float v7, v7
    mul-float v7, v7, v5
    float-to-int v5, v7
    iget-object v7, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v7, Landroid/view/View;->getWidth()I
    move-result v7
    if-gt v5, v7, +003h
    return-void 
    int-to-float v5, v5
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    invoke-virtual v0, Landroid/view/View;->getTranslationX()F
    move-result v0
    invoke-direct v4, v5, v7, v0, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z1(F I F F)F
    move-result v5
    iget-object v6, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    invoke-virtual v6, v5, Landroid/view/View;->setTranslationX(F)V
    return-void 
.end method

.method p4()V
    .registers 4
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    invoke-virtual v0, Landroidx/media3/ui/d;->n0()Z
    move-result v0
    const/4 v1, 1
    if-nez v0, +006h
    invoke-virtual v3, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I3(Z)V
    goto +17h
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X2()Z
    move-result v0
    const/4 v2, 0
    if-eqz v0, +006h
    invoke-virtual v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I3(Z)V
    goto +ch
    iget-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r1 Z
    if-eqz v0, +006h
    invoke-virtual v3, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I3(Z)V
    goto +4h
    invoke-virtual v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I3(Z)V
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g4()V
    return-void 
.end method

.method q0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; F Z)V
    .registers 3
    invoke-direct v0, v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K3(F Z)V
    return-void 
.end method

.method q1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; J)J
    .registers 3
    iput-wide v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u0 J
    return-wide v1
.end method

.method q2()Landroid/view/View;
    .registers 5
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I Landroidx/appcompat/widget/Toolbar;
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/view/ViewGroup;->setTouchscreenBlocksFocus(Z)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I Landroidx/appcompat/widget/Toolbar;
    invoke-virtual v0, v1, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;
    move-result-object v0
    instance-of v1, v0, Landroidx/appcompat/widget/p;
    const-string v2, "not work anymore"
    if-eqz v1, +025h
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I Landroidx/appcompat/widget/Toolbar;
    invoke-virtual v1, Landroidx/appcompat/widget/Toolbar;->getNavigationContentDescription()Ljava/lang/CharSequence;
    move-result-object v1
    if-eqz v1, +019h
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I Landroidx/appcompat/widget/Toolbar;
    invoke-virtual v1, Landroidx/appcompat/widget/Toolbar;->getNavigationContentDescription()Ljava/lang/CharSequence;
    move-result-object v1
    invoke-virtual v0, Landroid/view/View;->getContentDescription()Ljava/lang/CharSequence;
    move-result-object v3
    invoke-virtual v1, v3, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, +009h
    const v1, 16908332
    invoke-virtual v0, v1, Landroid/view/View;->setId(I)V
    return-object v0
    invoke-static v2, Lax/q3/b;->e(Ljava/lang/String;)V
    return-object v0
    invoke-static v2, Lax/q3/b;->e(Ljava/lang/String;)V
    return-object v0
.end method

.method q3()V
    .registers 3
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h3()Z
    move-result v0
    if-eqz v0, +005h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z4()V
    const/4 v0, 0
    invoke-direct v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G3(I)V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    const/4 v1, 1
    invoke-direct v2, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r3(I Z)V
    return-void 
.end method

.method q4()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +011h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T0 Landroid/graphics/drawable/Drawable;
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d1 Ljava/lang/String;
    invoke-virtual v0, v1, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    return-void 
    invoke-interface v0, Lax/P0/H;->o()I
    move-result v0
    if-eqz v0, +027h
    const/4 v1, 1
    if-eq v0, v1, +015h
    const/4 v1, 2
    if-eq v0, v1, +003h
    return-void 
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V0 Landroid/graphics/drawable/Drawable;
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f1 Ljava/lang/String;
    invoke-virtual v0, v1, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    return-void 
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->U0 Landroid/graphics/drawable/Drawable;
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e1 Ljava/lang/String;
    invoke-virtual v0, v1, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    return-void 
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T0 Landroid/graphics/drawable/Drawable;
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d1 Ljava/lang/String;
    invoke-virtual v0, v1, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    return-void 
.end method

.method r0()Ljava/util/logging/Logger;
    .registers 1
    sget-object v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R1 Ljava/util/logging/Logger;
    return-object v0
.end method

.method r1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/widget/TextView;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    return-object v0
.end method

.method r2()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A1 Landroid/os/Handler;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J1 Ljava/lang/Runnable;
    invoke-virtual v0, v1, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    const/4 v1, 0
    invoke-virtual v0, v1, Landroidx/media3/ui/PlayerView;->setUseController(Z)V
    invoke-virtual v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->finish()V
    return-void 
.end method

.method r3(I Z)V
    .registers 4
    if-ltz v2, +033h
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C2()I
    move-result v0
    if-lt v2, v0, +003h
    goto +2bh
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    return-void 
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G1 Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;
    if-eqz v0, +015h
    invoke-virtual v0, Lax/q3/q;->isCancelled()Z
    move-result v0
    if-nez v0, +00fh
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G1 Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;
    invoke-static v0, Lax/q3/q;->n(Lax/q3/q;)Z
    move-result v0
    if-eqz v0, +007h
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G1 Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;
    invoke-virtual v0, Lax/q3/q;->e()Z
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;
    invoke-direct v0, v1, v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I Z)V
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G1 Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;
    const/4 v2, 0
    new-array v2, v2, [Ljava/lang/Void;
    invoke-virtual v0, v2, Lax/q3/q;->i([Ljava/lang/Object;)Lax/q3/q;
    return-void 
    invoke-static Lax/q3/b;->f()V
    return-void 
.end method

.method r4()V
    .registers 3
    iget-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d0 Z
    if-eqz v0, +011h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z0 Landroid/graphics/drawable/Drawable;
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i1 Ljava/lang/String;
    invoke-virtual v0, v1, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    return-void 
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Y0 Landroid/graphics/drawable/Drawable;
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x Landroid/widget/ImageButton;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j1 Ljava/lang/String;
    invoke-virtual v0, v1, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    return-void 
.end method

.method s0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f3()Z
    move-result v0
    return v0
.end method

.method s1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W2()Z
    move-result v0
    return v0
.end method

.method s2(Ljava/lang/String; Ljava/util/List;)Ljava/lang/String;
    .registers 11
    invoke-static v9, Lax/W2/Y;->z(Ljava/lang/String;)Z
    move-result v0
    const/4 v1, 0
    if-nez v0, +029h
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v10
    invoke-virtual v10, Lax/za/b;->f()Lax/za/b;
    move-result-object v10
    const-string v0, "Invalid media path 3"
    invoke-virtual v10, v0, Lax/za/b;->b(Ljava/lang/String;)Lax/za/b;
    move-result-object v10
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct v0, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "path:"
    invoke-virtual v0, v2, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v0, v9, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v0, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v9
    invoke-virtual v10, v9, Lax/za/b;->g(Ljava/lang/Object;)Lax/za/b;
    move-result-object v9
    invoke-virtual v9, Lax/za/b;->h()V
    return-object v1
    if-nez v10, +003h
    return-object v1
    invoke-static v9, Lax/W2/Y;->l(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v9
    invoke-static Lax/W2/v;->o()[Ljava/lang/String;
    move-result-object v0
    array-length v2, v0
    const/4 v3, 0
    if-ge v3, v2, +03ah
    aget-object v4, v0, v3
    new-instance v5, Ljava/lang/StringBuilder;
    invoke-direct v5, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v5, v9, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v6, "."
    invoke-virtual v5, v6, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v5, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v5, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-interface v10, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v5
    invoke-interface v5, Ljava/util/Iterator;->hasNext()Z
    move-result v6
    if-eqz v6, +017h
    invoke-interface v5, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v6
    check-cast v6, Lcom/alphainventor/filemanager/file/n;
    invoke-virtual v6, Lcom/alphainventor/filemanager/file/n;->E()Ljava/lang/String;
    move-result-object v7
    invoke-virtual v4, v7, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v7
    if-eqz v7, -014h
    invoke-virtual v6, Lcom/alphainventor/filemanager/file/n;->B()Ljava/lang/String;
    move-result-object v9
    return-object v9
    add-int/lit8 v3, v3, 1
    goto -39h
    return-object v1
.end method

.method s3()V
    .registers 3
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C2()I
    move-result v1
    if-lt v0, v1, +008h
    const-string v0, "bad index"
    invoke-static v0, Lax/q3/b;->e(Ljava/lang/String;)V
    return-void 
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h3()Z
    move-result v0
    if-eqz v0, +005h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z4()V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    const/4 v1, 1
    add-int/2addr v0, v1
    invoke-direct v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G3(I)V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    invoke-direct v2, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r3(I Z)V
    return-void 
.end method

.method s4()V
    .registers 5
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-eqz v0, +01eh
    invoke-interface v0, Lax/P0/H;->r()Z
    move-result v0
    iput-boolean v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m1 Z
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Lax/P0/H;->I()I
    move-result v0
    iput v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n1 I
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Lax/P0/H;->N()J
    move-result-wide v0
    const-wide/16 v2, 0
    invoke-static v2, v3, v0, v1, Ljava/lang/Math;->max(J J)J
    move-result-wide v0
    iput-wide v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1 J
    return-void 
.end method

.method t0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S3(Z)V
    return-void 
.end method

.method t1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; F F F F F)V
    .registers 6
    invoke-direct/range v0 ... v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A4(F F F F F)V
    return-void 
.end method

.method t2(Landroid/net/Uri;)Landroid/net/Uri;
    .registers 8
    invoke-virtual v7, Landroid/net/Uri;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "file"
    invoke-virtual v7, Landroid/net/Uri;->getScheme()Ljava/lang/String;
    move-result-object v2
    invoke-virtual v1, v2, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, +00bh
    invoke-virtual v7, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v7
    invoke-direct v6, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v2(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v7
    return-object v7
    const-string v1, "content://media"
    invoke-virtual v0, v1, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    const/4 v1, 0
    if-eqz v0, +00eh
    invoke-static v6, v7, Lax/W2/I;->a(Landroid/content/Context; Landroid/net/Uri;)Ljava/lang/String;
    move-result-object v7
    if-eqz v7, +007h
    invoke-direct v6, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v2(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v7
    return-object v7
    return-object v1
    const-string v0, "content"
    invoke-virtual v7, Landroid/net/Uri;->getScheme()Ljava/lang/String;
    move-result-object v2
    invoke-virtual v0, v2, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    const-string v2, "subtitle uri : "
    if-eqz v0, +01bh
    invoke-direct v6, v6, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u2(Landroid/content/Context; Landroid/net/Uri;)Landroid/net/Uri;
    move-result-object v7
    sget-object v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R1 Ljava/util/logging/Logger;
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct v1, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v1, v2, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, v7, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    invoke-virtual v1, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-virtual v0, v1, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V
    return-object v7
    invoke-static v6, v7, Lcom/alphainventor/filemanager/service/b;->k(Landroid/content/Context; Landroid/net/Uri;)Z
    move-result v0
    if-eqz v0, +063h
    invoke-virtual v7, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v0
    invoke-static v0, Lax/k3/c;->z(Ljava/lang/String;)Lax/T2/j;
    move-result-object v0
    invoke-virtual v7, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v3
    invoke-static v3, Lax/W2/Y;->r(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-static v3, Lax/k3/c;->z(Ljava/lang/String;)Lax/T2/j;
    move-result-object v4
    if-eqz v4, +04dh
    if-eqz v0, +04bh
    invoke-virtual v4, Lax/T2/j;->d()Lax/W2/F;
    move-result-object v5
    invoke-static v5, Lax/W2/s;->e(Lax/W2/F;)Lcom/alphainventor/filemanager/file/o;
    move-result-object v5
    invoke-virtual v5, Lcom/alphainventor/filemanager/file/o;->a()Z
    move-result v5
    if-eqz v5, +03dh
    invoke-static Lax/T2/b;->k()Lax/T2/b;
    move-result-object v5
    invoke-virtual v4, Lax/T2/j;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-virtual v5, v4, Lax/T2/b;->h(Ljava/lang/String;)Ljava/util/List;
    move-result-object v4
    if-eqz v4, +02fh
    invoke-virtual v0, Lax/T2/j;->e()Ljava/lang/String;
    move-result-object v0
    invoke-direct v6, v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s2(Ljava/lang/String; Ljava/util/List;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, +025h
    invoke-virtual v7, Landroid/net/Uri;->buildUpon()Landroid/net/Uri$Builder;
    move-result-object v1
    invoke-static v3, v0, Lax/W2/Y;->N(Ljava/lang/String; Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual v1, v0, Landroid/net/Uri$Builder;->path(Ljava/lang/String;)Landroid/net/Uri$Builder;
    invoke-virtual v1, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;
    move-result-object v1
    sget-object v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R1 Ljava/util/logging/Logger;
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct v3, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v3, v2, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v3, v1, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    invoke-virtual v3, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-virtual v0, v2, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V
    sget-object v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R1 Ljava/util/logging/Logger;
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct v2, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "media uri : "
    invoke-virtual v2, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v2, v7, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    invoke-virtual v2, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-virtual v0, v7, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V
    return-object v1
.end method

.method t3()V
    .registers 3
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    if-gtz v0, +003h
    return-void 
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h3()Z
    move-result v0
    if-eqz v0, +005h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z4()V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    const/4 v1, 1
    sub-int/2addr v0, v1
    invoke-direct v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G3(I)V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    invoke-direct v2, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r3(I Z)V
    return-void 
.end method

.method u0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R3()V
    return-void 
.end method

.method u1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    .registers 2
    iput-boolean v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z0 Z
    return v1
.end method

.method u2(Landroid/content/Context; Landroid/net/Uri;)Landroid/net/Uri;
    .registers 11
    invoke-virtual v10, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v0
    invoke-static v0, Lax/W2/Y;->z(Ljava/lang/String;)Z
    move-result v1
    const/4 v2, 0
    if-nez v1, +029h
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v9
    invoke-virtual v9, Lax/za/b;->f()Lax/za/b;
    move-result-object v9
    const-string v10, "Invalid media path 2"
    invoke-virtual v9, v10, Lax/za/b;->b(Ljava/lang/String;)Lax/za/b;
    move-result-object v9
    new-instance v10, Ljava/lang/StringBuilder;
    invoke-direct v10, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "path:"
    invoke-virtual v10, v1, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, v0, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v10
    invoke-virtual v9, v10, Lax/za/b;->g(Ljava/lang/Object;)Lax/za/b;
    move-result-object v9
    invoke-virtual v9, Lax/za/b;->h()V
    return-object v2
    invoke-static v0, Lax/W2/Y;->l(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual v9, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v9
    invoke-static Lax/W2/v;->o()[Ljava/lang/String;
    move-result-object v1
    array-length v3, v1
    const/4 v4, 0
    if-ge v4, v3, +031h
    aget-object v5, v1, v4
    new-instance v6, Ljava/lang/StringBuilder;
    invoke-direct v6, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v6, v0, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v7, "."
    invoke-virtual v6, v7, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v6, v5, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v6, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-virtual v10, Landroid/net/Uri;->buildUpon()Landroid/net/Uri$Builder;
    move-result-object v6
    invoke-virtual v6, v5, Landroid/net/Uri$Builder;->path(Ljava/lang/String;)Landroid/net/Uri$Builder;
    move-result-object v5
    invoke-virtual v5, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;
    move-result-object v5
    const-string v6, "r"
    invoke-virtual v9, v5, v6, Landroid/content/ContentResolver;->openFileDescriptor(Landroid/net/Uri; Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;
    move-result-object v6
    invoke-virtual v6, Landroid/os/ParcelFileDescriptor;->close()V
    return-object v5
    add-int/lit8 v4, v4, 1
    goto -30h
    return-object v2
.end method

.method u3()V
    .registers 6
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +003h
    goto +24h
    invoke-interface v0, Lax/P0/H;->i()I
    move-result v0
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v1, Lax/P0/H;->k0()J
    move-result-wide v1
    invoke-direct v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v3
    if-eqz v3, +016h
    const/4 v3, 4
    if-eq v0, v3, +009h
    const-wide/16 v3, 3000
    cmp-long v0, v1, v3
    if-lez v0, +003h
    goto +bh
    invoke-direct v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    if-lez v0, +005h
    invoke-direct v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t3()V
    return-void 
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    const-wide/16 v1, 0
    invoke-interface v0, v1, v2, Lax/P0/H;->s(J)V
    return-void 
.end method

.method u4()V
    .registers 5
    iget-boolean v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j0 Z
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    invoke-direct v4, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E3(Z Landroid/view/View;)V
    iget-boolean v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j0 Z
    const/16 v1, 8
    if-eqz v0, +041h
    iget-boolean v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k0 Z
    const/4 v2, 0
    if-eqz v0, +01fh
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X0 Landroid/graphics/drawable/Drawable;
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g1 Ljava/lang/String;
    invoke-virtual v0, v1, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->getSubtitleView()Landroidx/media3/ui/SubtitleView;
    move-result-object v0
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    return-void 
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    iget-object v3, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W0 Landroid/graphics/drawable/Drawable;
    invoke-virtual v0, v3, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    iget-object v3, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h1 Ljava/lang/String;
    invoke-virtual v0, v3, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->getSubtitleView()Landroidx/media3/ui/SubtitleView;
    move-result-object v0
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W0 Landroid/graphics/drawable/Drawable;
    invoke-virtual v0, v2, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h1 Ljava/lang/String;
    invoke-virtual v0, v2, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->getSubtitleView()Landroidx/media3/ui/SubtitleView;
    move-result-object v0
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method v0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    .registers 1
    iget v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y1 I
    return v0
.end method

.method v1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B4()V
    return-void 
.end method

.method v2(Ljava/lang/String;)Landroid/net/Uri;
    .registers 9
    invoke-static v8, Lax/W2/Y;->z(Ljava/lang/String;)Z
    move-result v0
    const/4 v1, 0
    if-nez v0, +029h
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v0
    invoke-virtual v0, Lax/za/b;->f()Lax/za/b;
    move-result-object v0
    const-string v2, "Invalid media path 1"
    invoke-virtual v0, v2, Lax/za/b;->b(Ljava/lang/String;)Lax/za/b;
    move-result-object v0
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct v2, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "path:"
    invoke-virtual v2, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v2, v8, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v2, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v8
    invoke-virtual v0, v8, Lax/za/b;->g(Ljava/lang/Object;)Lax/za/b;
    move-result-object v8
    invoke-virtual v8, Lax/za/b;->h()V
    return-object v1
    invoke-static v8, Lax/W2/Y;->l(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v8
    invoke-static Lax/W2/v;->o()[Ljava/lang/String;
    move-result-object v0
    array-length v2, v0
    const/4 v3, 0
    if-ge v3, v2, +02bh
    aget-object v4, v0, v3
    new-instance v5, Ljava/lang/StringBuilder;
    invoke-direct v5, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v5, v8, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v6, "."
    invoke-virtual v5, v6, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v5, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v5, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    new-instance v5, Ljava/io/File;
    invoke-direct v5, v4, Ljava/io/File;-><init>(Ljava/lang/String;)V
    invoke-virtual v5, Ljava/io/File;->exists()Z
    move-result v4
    if-eqz v4, +007h
    invoke-static v5, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;
    move-result-object v8
    return-object v8
    add-int/lit8 v3, v3, 1
    goto -2ah
    return-object v1
.end method

.method v4()V
    .registers 5
    invoke-direct v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x2()Landroid/net/Uri;
    move-result-object v0
    const-string v1, ""
    if-nez v0, +006h
    invoke-direct v4, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O3(Ljava/lang/String;)V
    return-void 
    const-string v2, "file"
    invoke-virtual v0, Landroid/net/Uri;->getScheme()Ljava/lang/String;
    move-result-object v3
    invoke-virtual v2, v3, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, +029h
    invoke-virtual v0, Landroid/net/Uri;->getScheme()Ljava/lang/String;
    move-result-object v2
    invoke-static v2, Lax/W2/w;->J(Ljava/lang/String;)Z
    move-result v2
    if-nez v2, +01fh
    invoke-static v0, Lcom/alphainventor/filemanager/provider/MyFileProvider;->x(Landroid/net/Uri;)Z
    move-result v2
    if-eqz v2, +003h
    goto +17h
    const-string v1, "content"
    invoke-virtual v0, Landroid/net/Uri;->getScheme()Ljava/lang/String;
    move-result-object v2
    invoke-virtual v1, v2, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, +00bh
    invoke-static v4, v0, Lax/W2/w;->u(Landroid/content/Context; Landroid/net/Uri;)Lax/W2/Q;
    move-result-object v0
    iget-object v0, v0, Lax/W2/Q;->a Ljava/lang/String;
    invoke-direct v4, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O3(Ljava/lang/String;)V
    return-void 
    invoke-virtual v0, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v2
    if-eqz v2, +00eh
    invoke-virtual v0, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v0
    invoke-static v0, Lax/W2/Y;->h(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    invoke-direct v4, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O3(Ljava/lang/String;)V
    return-void 
    invoke-direct v4, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O3(Ljava/lang/String;)V
    return-void 
.end method

.method w0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/os/Handler;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A1 Landroid/os/Handler;
    return-object v0
.end method

.method w1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b2()V
    return-void 
.end method

.method w2()I
    .registers 3
    iget v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i0 I
    if-gez v0, +007h
    invoke-static Lax/q3/b;->f()V
    const/4 v0, 0
    return v0
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C2()I
    move-result v1
    if-lt v0, v1, +00ch
    invoke-static Lax/q3/b;->f()V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C2()I
    move-result v0
    add-int/lit8 v0, v0, -1
    return v0
    iget v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i0 I
    return v0
.end method

.method w3()V
    .registers 1
    return-void 
.end method

.method w4()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N0 Lax/g1/n;
    if-eqz v0, +008h
    invoke-virtual v0, Lax/g1/n;->K()Lax/g1/n$e;
    move-result-object v0
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O0 Lax/g1/n$e;
    return-void 
.end method

.method x0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/net/Uri;
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y2()Landroid/net/Uri;
    move-result-object v0
    return-object v0
.end method

.method x1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m2(Z)V
    return-void 
.end method

.method x2()Landroid/net/Uri;
    .registers 5
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z [Landroid/net/Uri;
    const/4 v1, 0
    if-nez v0, +006h
    invoke-static Lax/q3/b;->f()V
    return-object v1
    invoke-direct v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    invoke-direct v4, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A2(I)I
    move-result v0
    if-ltz v0, +00bh
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z [Landroid/net/Uri;
    array-length v3, v2
    if-lt v0, v3, +003h
    goto +4h
    aget-object v0, v2, v0
    return-object v0
    const-string v0, "what case is this"
    invoke-static v0, Lax/q3/b;->e(Ljava/lang/String;)V
    return-object v1
.end method

.method x3()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X Lax/a1/O;
    if-eqz v0, +008h
    invoke-virtual v0, Lax/a1/O;->d()V
    const/4 v0, 0
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X Lax/a1/O;
    return-void 
.end method

.method x4()V
    .registers 3
    const/4 v0, 0
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C0 Z
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B Landroid/view/View;
    const/16 v1, 8
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method y0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    .registers 1
    iget-boolean v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u1 Z
    return v0
.end method

.method y1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b4()V
    return-void 
.end method

.method y2()Landroid/net/Uri;
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    if-nez v0, +007h
    invoke-static Lax/q3/b;->f()V
    const/4 v0, 0
    return-object v0
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    invoke-direct v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A2(I)I
    move-result v0
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a0 [Landroid/net/Uri;
    aget-object v0, v1, v0
    return-object v0
.end method

.method y3()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-eqz v0, +014h
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w4()V
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s4()V
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-interface v0, Landroidx/media3/exoplayer/ExoPlayer;->d()V
    const/4 v0, 0
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Y Lax/P0/y;
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N0 Lax/g1/n;
    invoke-static Lax/R2/Q;->f1()Z
    move-result v0
    if-eqz v0, +005h
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x3()V
    return-void 
.end method

.method y4()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B0 Landroid/media/AudioManager;
    if-nez v0, +00fh
    const-string v0, "audio"
    invoke-virtual v2, v0, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/media/AudioManager;
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B0 Landroid/media/AudioManager;
    if-nez v0, +003h
    return-void 
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B0 Landroid/media/AudioManager;
    const/4 v1, 3
    invoke-virtual v0, v1, Landroid/media/AudioManager;->getStreamMaxVolume(I)I
    move-result v0
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D0 I
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B0 Landroid/media/AudioManager;
    invoke-virtual v0, v1, Landroid/media/AudioManager;->getStreamVolume(I)I
    move-result v0
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E0 I
    const/4 v0, 1
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C0 Z
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B Landroid/view/View;
    const/4 v1, 0
    invoke-virtual v0, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C Landroid/widget/ImageView;
    const v1, 2131231197
    invoke-virtual v0, v1, Landroid/widget/ImageView;->setImageResource(I)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D Landroid/widget/ProgressBar;
    const v1, 2131231543
    invoke-static v2, v1, Lax/o/a;->b(Landroid/content/Context; I)Landroid/graphics/drawable/Drawable;
    move-result-object v1
    invoke-virtual v0, v1, Landroid/widget/ProgressBar;->setProgressDrawable(Landroid/graphics/drawable/Drawable;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D Landroid/widget/ProgressBar;
    iget v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D0 I
    invoke-virtual v0, v1, Landroid/widget/ProgressBar;->setMax(I)V
    return-void 
.end method

.method z0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    .registers 2
    iput-boolean v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u1 Z
    return v1
.end method

.method z1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/ui/PlayerView;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    return-object v0
.end method

.method z2(Ljava/lang/String;)Ljava/lang/String;
    .registers 5
    invoke-static v4, Lax/s3/f;->b(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    invoke-static v0, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, +003h
    goto +2h
    move-object v4, v0
    const v0, 2131951943
    const/4 v1, 1
    new-array v1, v1, [Ljava/lang/Object;
    const/4 v2, 0
    aput-object v4, v1, v2
    invoke-virtual v3, v0, v1, Landroid/content/Context;->getString(I [Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v4
    return-object v4
.end method

.method z4()V
    .registers 2
    const/4 v0, 0
    iput-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A0 Z
    const/high16 v0, 1065353216
    iput v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0 F
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f2()V
    return-void 
.end method

.method D2()Ljava/lang/String;
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p1 Ljava/lang/String;
    if-nez v0, +00ah
    const-string v0, "CxFileExplorer"
    invoke-static v1, v0, Lax/S0/c0;->s0(Landroid/content/Context; Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p1 Ljava/lang/String;
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p1 Ljava/lang/String;
    return-object v0
.end method

.method I3(Z)V
    .registers 3
    if-eqz v2, +005h
    const/16 v2, 3846
    goto +3h
    const/16 v2, 1792
    iput v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q1 I
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a Landroid/view/View;
    invoke-virtual v0, v2, Landroid/view/View;->setSystemUiVisibility(I)V
    return-void 
.end method

.method T(I)V
    .registers 3
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p4()V
    const/16 v0, 8
    if-ne v2, v0, +00ah
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l2()V
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D1 Lcom/alphainventor/filemanager/viewer/f;
    invoke-virtual v0, Lcom/alphainventor/filemanager/viewer/f;->d()V
    if-nez v2, +00ch
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G Lcom/google/android/material/snackbar/Snackbar;
    if-eqz v2, +008h
    invoke-virtual v2, Lcom/google/android/material/snackbar/Snackbar;->x()V
    const/4 v2, 0
    iput-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G Lcom/google/android/material/snackbar/Snackbar;
    return-void 
.end method

.method Y3()V
    .registers 1
    invoke-virtual v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v3()V
    return-void 
.end method

.method c()Lax/P0/H;
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    return-object v0
.end method

.method dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    .registers 9
    invoke-virtual v8, Landroid/view/KeyEvent;->getKeyCode()I
    move-result v0
    invoke-virtual v8, Landroid/view/KeyEvent;->getAction()I
    move-result v1
    invoke-virtual v7, Landroid/app/Activity;->getCurrentFocus()Landroid/view/View;
    move-result-object v2
    const/4 v3, 0
    const/4 v4, 1
    if-eqz v1, +00bh
    if-ne v1, v4, +007h
    iget v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E1 I
    if-nez v5, +003h
    goto +3h
    const/4 v5, 0
    goto +2h
    const/4 v5, 1
    if-nez v1, +005h
    iput v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E1 I
    goto +5h
    if-ne v1, v4, +004h
    iput v3, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E1 I
    iget v6, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F1 I
    if-ne v6, v0, +007h
    if-ne v1, v4, +005h
    iput v3, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F1 I
    return v4
    if-eqz v5, +0e1h
    const/16 v5, 20
    if-ne v0, v5, +02ch
    iget-object v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-ne v2, v5, +011h
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    invoke-virtual v8, Landroidx/media3/ui/d;->n0()Z
    move-result v8
    if-nez v8, +0cch
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    invoke-virtual v8, Landroidx/media3/ui/d;->v0()V
    goto/16 +0c5h
    iget-object v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I Landroidx/appcompat/widget/Toolbar;
    invoke-static v5, v2, Lax/q3/y;->s(Landroid/view/ViewGroup; Landroid/view/View;)Z
    move-result v2
    if-eqz v2, +0c2h
    if-nez v1, +0c0h
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    invoke-virtual v8, Landroidx/media3/ui/d;->n0()Z
    move-result v8
    if-eqz v8, +0b3h
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z3()V
    goto/16 +0aeh
    const/16 v5, 19
    if-ne v0, v5, +033h
    iget-object v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-ne v2, v5, +018h
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    invoke-virtual v8, Landroidx/media3/ui/d;->n0()Z
    move-result v8
    if-nez v8, +09eh
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q2()Landroid/view/View;
    move-result-object v8
    iget-object v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    invoke-virtual v2, Landroidx/media3/ui/d;->v0()V
    invoke-virtual v8, Landroid/view/View;->requestFocus()Z
    goto/16 +090h
    iget-object v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f Landroid/view/ViewGroup;
    invoke-static v5, v2, Lax/q3/y;->s(Landroid/view/ViewGroup; Landroid/view/View;)Z
    move-result v2
    if-eqz v2, +08dh
    if-nez v1, +08bh
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    invoke-virtual v8, Landroidx/media3/ui/d;->n0()Z
    move-result v8
    if-eqz v8, +07eh
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z3()V
    goto/16 +079h
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->U2(I)Z
    move-result v5
    if-eqz v5, +00ah
    iget-object v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-ne v2, v5, +074h
    invoke-direct v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b4()V
    goto +6ah
    const/16 v5, 85
    if-eq v0, v5, +04dh
    const/16 v5, 62
    if-ne v0, v5, +003h
    goto +47h
    const/16 v5, 126
    if-ne v0, v5, +021h
    iget-object v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-ne v2, v5, +05fh
    iget-object v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-static v2, Lax/S0/c0;->o1(Lax/P0/H;)Z
    move-result v2
    if-eqz v2, +057h
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v8, v3, Landroidx/media3/ui/PlayerView;->setControllerAutoShow(Z)V
    invoke-direct v7, v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T3(Z)V
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-static v8, Lax/S0/c0;->v0(Lax/P0/H;)Z
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v8, v4, Landroidx/media3/ui/PlayerView;->setControllerAutoShow(Z)V
    goto +3eh
    const/16 v5, 127
    if-ne v0, v5, +040h
    iget-object v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-ne v2, v5, +03ch
    iget-object v2, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-static v2, Lax/S0/c0;->o1(Lax/P0/H;)Z
    move-result v2
    if-nez v2, +034h
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v8, v3, Landroidx/media3/ui/PlayerView;->setControllerAutoShow(Z)V
    invoke-direct v7, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T3(Z)V
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-static v8, Lax/S0/c0;->u0(Lax/P0/H;)Z
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v8, v4, Landroidx/media3/ui/PlayerView;->setControllerAutoShow(Z)V
    goto +1bh
    iget-object v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-ne v2, v5, +01dh
    invoke-virtual v5, v3, Landroidx/media3/ui/PlayerView;->setControllerAutoShow(Z)V
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-static v8, Lax/S0/c0;->o1(Lax/P0/H;)Z
    move-result v8
    invoke-direct v7, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T3(Z)V
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    invoke-static v8, Lax/S0/c0;->w0(Lax/P0/H;)Z
    iget-object v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v8, v4, Landroidx/media3/ui/PlayerView;->setControllerAutoShow(Z)V
    if-nez v1, +004h
    iput v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F1 I
    return v4
    iget-object v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v0, v8, Landroidx/media3/ui/PlayerView;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    move-result v0
    if-nez v0, +00ah
    invoke-super v7, v8, Lax/n/c;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    move-result v8
    if-eqz v8, +003h
    goto +2h
    return v3
    return v4
.end method

.method finish()V
    .registers 3
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f3()Z
    move-result v0
    if-eqz v0, +010h
    iget-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z1 Z
    if-eqz v0, +007h
    const/4 v0, 0
    invoke-virtual v2, v0, Landroid/app/Activity;->setResult(I)V
    goto +9h
    const/4 v0, -1
    invoke-virtual v2, v0, Landroid/app/Activity;->setResult(I)V
    goto +4h
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H3()V
    invoke-super v2, Landroid/app/Activity;->finish()V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f3()Z
    move-result v0
    if-eqz v0, +00fh
    iget-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z1 Z
    if-nez v0, +00bh
    const v0, 2130772017
    const v1, 2130772018
    invoke-virtual v2, v0, v1, Landroid/app/Activity;->overridePendingTransition(I I)V
    return-void 
.end method

.method j()Landroidx/media3/ui/d;
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    return-object v0
.end method

.method j2()Lax/g1/n$e;
    .registers 3
    new-instance v0, Lax/g1/n$f;
    invoke-direct v0, v2, Lax/g1/n$f;-><init>(Landroid/content/Context;)V
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q Ljava/lang/String;
    invoke-virtual v0, v1, Lax/g1/n$f;->c0(Ljava/lang/String;)Lax/g1/n$f;
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q Ljava/lang/String;
    invoke-virtual v0, v1, Lax/g1/n$f;->a0(Ljava/lang/String;)Lax/g1/n$f;
    const/4 v1, 1
    invoke-virtual v0, v1, Lax/g1/n$f;->f0(Z)Lax/g1/n$f;
    invoke-virtual v0, Lax/g1/n$f;->V()Lax/g1/n$e;
    move-result-object v0
    return-object v0
.end method

.method onConfigurationChanged(Landroid/content/res/Configuration;)V
    .registers 2
    invoke-super v0, v1, Lax/n/c;->onConfigurationChanged(Landroid/content/res/Configuration;)V
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h4()V
    return-void 
.end method

.method onCreate(Landroid/os/Bundle;)V
    .registers 7
    const/4 v0, 1
    invoke-static v5, v0, Lax/K2/b;->f(Landroid/content/Context; Z)V
    invoke-super v5, v6, Landroidx/fragment/app/f;->onCreate(Landroid/os/Bundle;)V
    invoke-static Lax/R2/Q;->M0()Z
    move-result v1
    const v2, 2131951922
    if-nez v1, +01eh
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v6
    invoke-virtual v6, Lax/za/b;->f()Lax/za/b;
    move-result-object v6
    const-string v1, "VIDEO PLAYER NOT SUPPORTED"
    invoke-virtual v6, v1, Lax/za/b;->d(Ljava/lang/String;)Lax/za/b;
    move-result-object v6
    invoke-virtual v6, Lax/za/b;->h()V
    invoke-static v5, v2, v0, Landroid/widget/Toast;->makeText(Landroid/content/Context; I I)Landroid/widget/Toast;
    move-result-object v6
    invoke-virtual v6, Landroid/widget/Toast;->show()V
    invoke-virtual v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->finish()V
    return-void 
    invoke-virtual v5, Landroid/app/Activity;->getIntent()Landroid/content/Intent;
    move-result-object v1
    const-string v3, "slide_interval"
    const/4 v4, -1
    invoke-virtual v1, v3, v4, Landroid/content/Intent;->getIntExtra(Ljava/lang/String; I)I
    move-result v1
    iput v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y1 I
    const/high16 v1, 17432576
    const v3, 17432577
    invoke-virtual v5, v1, v3, Landroid/app/Activity;->overridePendingTransition(I I)V
    invoke-direct v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W1()Lax/U0/g$a;
    move-result-object v1
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->U Lax/U0/g$a;
    new-instance v2, Lax/e1/X$b;
    invoke-direct v2, v1, Lax/e1/X$b;-><init>(Lax/U0/g$a;)V
    iput-object v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V Lax/e1/M;
    const v1, 2131558440
    invoke-virtual v5, v1, Lax/n/c;->setContentView(I)V
    const v1, 2131362732
    invoke-virtual v5, v1, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v1
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a Landroid/view/View;
    const v1, 2131362097
    invoke-virtual v5, v1, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v1
    check-cast v1, Landroid/widget/TextView;
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T Landroid/widget/TextView;
    const v1, 2131362964
    invoke-virtual v5, v1, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v1
    check-cast v1, Landroidx/appcompat/widget/Toolbar;
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I Landroidx/appcompat/widget/Toolbar;
    invoke-virtual v5, v1, Lax/n/c;->setSupportActionBar(Landroidx/appcompat/widget/Toolbar;)V
    invoke-virtual v5, Lax/n/c;->getResources()Landroid/content/res/Resources;
    move-result-object v1
    invoke-virtual v1, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;
    move-result-object v1
    iget-object v1, v1, Landroid/content/res/Configuration;->locale Ljava/util/Locale;
    if-eqz v1, +009h
    invoke-virtual v1, Ljava/util/Locale;->toLanguageTag()Ljava/lang/String;
    move-result-object v1
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q Ljava/lang/String;
    goto +bh
    invoke-static Ljava/util/Locale;->getDefault()Ljava/util/Locale;
    move-result-object v1
    invoke-virtual v1, Ljava/util/Locale;->toLanguageTag()Ljava/lang/String;
    move-result-object v1
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q Ljava/lang/String;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/f;
    invoke-direct v1, v5, v5, Lcom/alphainventor/filemanager/viewer/f;-><init>(Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/f$c;)V
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D1 Lcom/alphainventor/filemanager/viewer/f;
    const v1, 2131362687
    invoke-virtual v5, v1, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v1
    check-cast v1, Landroidx/media3/ui/PlayerView;
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v1, Landroidx/media3/ui/PlayerView;->getVideoSurfaceView()Landroid/view/View;
    move-result-object v1
    instance-of v1, v1, Landroid/view/SurfaceView;
    if-eqz v1, +016h
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v1, Landroidx/media3/ui/PlayerView;->getVideoSurfaceView()Landroid/view/View;
    move-result-object v1
    check-cast v1, Landroid/view/SurfaceView;
    invoke-virtual v1, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;
    move-result-object v1
    new-instance v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;
    invoke-direct v2, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    invoke-interface v1, v2, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v1, v5, Landroidx/media3/ui/PlayerView;->setControllerVisibilityListener(Landroidx/media3/ui/d$m;)V
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    new-instance v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;
    const/4 v3, 0
    invoke-direct v2, v5, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;)V
    invoke-virtual v1, v2, Landroidx/media3/ui/PlayerView;->setErrorMessageProvider(Lax/P0/p;)V
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    invoke-virtual v1, Landroid/view/View;->requestFocus()Z
    const v1, 2131362698
    invoke-virtual v5, v1, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v1
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H Landroid/view/View;
    const v1, 2131362201
    invoke-virtual v5, v1, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v1
    check-cast v1, Landroidx/media3/ui/AspectRatioFrameLayout;
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F Landroidx/media3/ui/AspectRatioFrameLayout;
    const v1, 2131362202
    invoke-virtual v5, v1, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v1
    check-cast v1, Landroidx/media3/ui/d;
    iput-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e Landroidx/media3/ui/d;
    invoke-virtual v1, v0, Landroid/view/View;->setFitsSystemWindows(Z)V
    const v0, 2131362155
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/TextView;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A Landroid/widget/TextView;
    const v0, 2131362153
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B Landroid/view/View;
    const v0, 2131363013
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ImageView;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C Landroid/widget/ImageView;
    const v0, 2131363012
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ProgressBar;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->D Landroid/widget/ProgressBar;
    const v0, 2131362024
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/TextView;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E Landroid/widget/TextView;
    const v0, 2131361988
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/view/ViewGroup;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f Landroid/view/ViewGroup;
    const v0, 2131362062
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g Landroid/view/View;
    const v0, 2131362063
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h Landroid/view/View;
    const v0, 2131362064
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i Landroid/view/View;
    const v0, 2131362066
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j Landroid/view/View;
    const v0, 2131362078
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m Landroid/view/View;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362080
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l Landroid/view/View;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362083
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ImageButton;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k Landroid/widget/ImageButton;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362081
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n Landroid/view/View;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362082
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o Landroid/view/View;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362079
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p Landroid/view/View;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362090
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q Landroid/view/View;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362085
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s Landroid/view/View;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362084
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ImageButton;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r Landroid/widget/ImageButton;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362089
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ImageView;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t Landroid/widget/ImageView;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362087
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroidx/appcompat/widget/MySpinner;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y Landroidx/appcompat/widget/MySpinner;
    const v1, 2131952486
    invoke-virtual v0, v1, Landroid/widget/Spinner;->setPromptId(I)V
    new-instance v0, Lcom/alphainventor/filemanager/viewer/d;
    invoke-direct v0, v5, Lcom/alphainventor/filemanager/viewer/d;-><init>(Landroid/content/Context;)V
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y Landroidx/appcompat/widget/MySpinner;
    invoke-virtual v1, v0, Landroidx/appcompat/widget/u;->setAdapter(Landroid/widget/SpinnerAdapter;)V
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y Landroidx/appcompat/widget/MySpinner;
    new-instance v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$l;
    invoke-direct v2, v5, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$l;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lcom/alphainventor/filemanager/viewer/d;)V
    invoke-virtual v1, v2, Landroid/widget/AdapterView;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V
    const v0, 2131362077
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ImageButton;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u Landroid/widget/ImageButton;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362088
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ImageButton;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v Landroid/widget/ImageButton;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362086
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ImageButton;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x Landroid/widget/ImageButton;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O1 Landroid/view/View$OnClickListener;
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const v0, 2131362223
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/ImageButton;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w Landroid/widget/ImageButton;
    const v0, 2131362178
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z Landroid/view/View;
    const v0, 2131361874
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/view/ViewGroup;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J Landroid/view/ViewGroup;
    const v0, 2131361873
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/view/ViewGroup;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K Landroid/view/ViewGroup;
    const v0, 2131361872
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L Landroid/view/View;
    const v0, 2131361875
    invoke-virtual v5, v0, Lax/n/c;->findViewById(I)Landroid/view/View;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M Landroid/view/View;
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L Landroid/view/View;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$m;
    invoke-direct v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$m;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    invoke-virtual v0, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    const v1, 2131362227
    invoke-virtual v0, v1, Landroid/view/View;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroidx/media3/ui/b;
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S Landroidx/media3/ui/b;
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K1 Landroidx/media3/ui/G$a;
    invoke-virtual v0, v1, Landroidx/media3/ui/b;->a(Landroidx/media3/ui/G$a;)V
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a Landroid/view/View;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$n;
    invoke-direct v1, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$n;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    invoke-virtual v0, v1, Landroid/view/View;->setOnSystemUiVisibilityChangeListener(Landroid/view/View$OnSystemUiVisibilityChangeListener;)V
    const/16 v0, 30
    invoke-static v5, v0, Lax/q3/A;->e(Landroid/content/Context; I)I
    move-result v0
    iput v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w0 I
    const/16 v0, 35
    invoke-static v5, v0, Lax/q3/A;->e(Landroid/content/Context; I)I
    move-result v0
    iput v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x0 I
    invoke-static Lax/p3/a;->b()I
    move-result v0
    iput v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I0 I
    invoke-direct v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K2()V
    invoke-direct v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H2()V
    if-eqz v6, +03fh
    const-string v0, "track_selector_parameters"
    invoke-virtual v6, v0, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;
    move-result-object v0
    if-eqz v0, +008h
    invoke-static v0, Lax/g1/n$e;->Q(Landroid/os/Bundle;)Lax/g1/n$e;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O0 Lax/g1/n$e;
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O0 Lax/g1/n$e;
    if-nez v0, +008h
    invoke-virtual v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j2()Lax/g1/n$e;
    move-result-object v0
    iput-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O0 Lax/g1/n$e;
    const-string v0, "auto_play"
    invoke-virtual v6, v0, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z
    move-result v0
    iput-boolean v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m1 Z
    const-string v0, "window"
    invoke-virtual v6, v0, v4, Landroid/os/BaseBundle;->getInt(Ljava/lang/String; I)I
    move-result v0
    iput v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n1 I
    const-string v0, "position"
    const-wide/16 v1, -1
    invoke-virtual v6, v0, v1, v2, Landroid/os/BaseBundle;->getLong(Ljava/lang/String; J)J
    move-result-wide v0
    iput-wide v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1 J
    const-string v0, "speed"
    const/high16 v1, 1065353216
    invoke-virtual v6, v0, v1, Landroid/os/Bundle;->getFloat(Ljava/lang/String; F)F
    move-result v6
    iput v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p0 F
    goto +ah
    invoke-virtual v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j2()Lax/g1/n$e;
    move-result-object v6
    iput-object v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O0 Lax/g1/n$e;
    invoke-direct v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g2()V
    invoke-virtual v5, Landroidx/activity/ComponentActivity;->getOnBackPressedDispatcher()Landroidx/activity/OnBackPressedDispatcher;
    move-result-object v6
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I1 Lax/i/r;
    invoke-virtual v6, v5, v0, Landroidx/activity/OnBackPressedDispatcher;->h(Lax/G0/h; Lax/i/r;)V
    const/16 v6, 40
    invoke-static v5, v6, Lax/q3/A;->e(Landroid/content/Context; I)I
    move-result v6
    iput v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B1 I
    const/16 v6, 52
    invoke-static v5, v6, Lax/q3/A;->e(Landroid/content/Context; I)I
    move-result v6
    iput v6, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C1 I
    invoke-virtual v5, Landroidx/fragment/app/f;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;
    move-result-object v6
    new-instance v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$o;
    invoke-direct v0, v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$o;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    const-string v1, "dialog_dismiss_request"
    invoke-virtual v6, v1, v5, v0, Landroidx/fragment/app/FragmentManager;->l1(Ljava/lang/String; Lax/G0/h; Lax/A0/l;)V
    return-void 
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v6
    invoke-virtual v6, Lax/za/b;->f()Lax/za/b;
    move-result-object v6
    const-string v1, "VIDEO PLAYER BUILD SOURCE"
    invoke-virtual v6, v1, Lax/za/b;->d(Ljava/lang/String;)Lax/za/b;
    move-result-object v6
    invoke-virtual v6, Lax/za/b;->h()V
    invoke-static v5, v2, v0, Landroid/widget/Toast;->makeText(Landroid/content/Context; I I)Landroid/widget/Toast;
    move-result-object v6
    invoke-virtual v6, Landroid/widget/Toast;->show()V
    invoke-virtual v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->finish()V
    return-void 
.end method

.method onCreateOptionsMenu(Landroid/view/Menu;)Z
    .registers 4
    invoke-virtual v2, Lax/n/c;->getMenuInflater()Landroid/view/MenuInflater;
    move-result-object v0
    const v1, 2131689509
    invoke-virtual v0, v1, v3, Landroid/view/MenuInflater;->inflate(I Landroid/view/Menu;)V
    const/4 v3, 1
    return v3
.end method

.method onDestroy()V
    .registers 4
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w3()V
    iget-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s1 Z
    if-eqz v0, +010h
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t1 Lax/W2/F;
    if-eqz v0, +00ch
    invoke-static v3, Lcom/alphainventor/filemanager/service/b;->f(Landroid/content/Context;)Lcom/alphainventor/filemanager/service/b;
    move-result-object v0
    const/4 v1, 0
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t1 Lax/W2/F;
    invoke-virtual v0, v1, v2, Lcom/alphainventor/filemanager/service/b;->l(Z Lax/W2/F;)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N Landroid/view/View;
    if-eqz v0, +005h
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e2()V
    invoke-super v3, Lax/n/c;->onDestroy()V
    return-void 
.end method

.method onNewIntent(Landroid/content/Intent;)V
    .registers 2
    invoke-super v0, v1, Landroidx/activity/ComponentActivity;->onNewIntent(Landroid/content/Intent;)V
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y3()V
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w3()V
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g2()V
    invoke-virtual v0, v1, Landroid/app/Activity;->setIntent(Landroid/content/Intent;)V
    return-void 
.end method

.method onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .registers 4
    invoke-interface v3, Landroid/view/MenuItem;->getItemId()I
    move-result v3
    const v0, 16908332
    const/4 v1, 1
    if-eq v3, v0, +016h
    const v0, 2131362531
    if-eq v3, v0, +00dh
    const v0, 2131362536
    if-eq v3, v0, +004h
    const/4 v3, 0
    return v3
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a4()V
    return v1
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X3()V
    return v1
    invoke-virtual v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->finish()V
    return v1
.end method

.method onPause()V
    .registers 3
    invoke-super v2, Landroidx/fragment/app/f;->onPause()V
    sget v0, Lax/S0/c0;->a I
    const/16 v1, 23
    if-gt v0, v1, +00ch
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-eqz v0, +005h
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->P()V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y3()V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N Landroid/view/View;
    if-eqz v0, +009h
    iget-boolean v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O Z
    if-nez v1, +005h
    invoke-static v0, v2, Lax/M2/b;->c(Ljava/lang/Object; Landroid/content/Context;)V
    return-void 
.end method

.method onPrepareOptionsMenu(Landroid/view/Menu;)Z
    .registers 4
    const v0, 2131362536
    invoke-interface v3, v0, Landroid/view/Menu;->findItem(I)Landroid/view/MenuItem;
    move-result-object v0
    if-eqz v0, +006h
    const/4 v1, 0
    invoke-interface v0, v1, Landroid/view/MenuItem;->setVisible(Z)Landroid/view/MenuItem;
    invoke-super v2, v3, Landroid/app/Activity;->onPrepareOptionsMenu(Landroid/view/Menu;)Z
    move-result v3
    return v3
.end method

.method onRequestPermissionsResult(I [Ljava/lang/String; [I)V
    .registers 4
    invoke-super v0, v1, v2, v3, Landroidx/fragment/app/f;->onRequestPermissionsResult(I [Ljava/lang/String; [I)V
    array-length v1, v3
    if-nez v1, +003h
    return-void 
    const/4 v1, 0
    aget v1, v3, v1
    if-nez v1, +006h
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M2()V
    return-void 
    const v1, 2131951924
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V3(I)V
    invoke-virtual v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->finish()V
    return-void 
.end method

.method onResume()V
    .registers 3
    invoke-super v2, Landroidx/fragment/app/f;->onResume()V
    sget v0, Lax/S0/c0;->a I
    const/16 v1, 23
    if-le v0, v1, +006h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W Landroidx/media3/exoplayer/ExoPlayer;
    if-nez v0, +00ch
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M2()V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-eqz v0, +005h
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->Q()V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N Landroid/view/View;
    if-eqz v0, +009h
    iget-boolean v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O Z
    if-nez v1, +005h
    invoke-static v0, v2, Lax/M2/b;->l(Ljava/lang/Object; Landroid/content/Context;)V
    return-void 
.end method

.method onSaveInstanceState(Landroid/os/Bundle;)V
    .registers 5
    invoke-super v3, v4, Landroidx/activity/ComponentActivity;->onSaveInstanceState(Landroid/os/Bundle;)V
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w4()V
    invoke-direct v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s4()V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O0 Lax/g1/n$e;
    if-eqz v0, +00bh
    const-string v1, "track_selector_parameters"
    invoke-virtual v0, Lax/g1/n$e;->J()Landroid/os/Bundle;
    move-result-object v0
    invoke-virtual v4, v1, v0, Landroid/os/Bundle;->putBundle(Ljava/lang/String; Landroid/os/Bundle;)V
    const-string v0, "auto_play"
    iget-boolean v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m1 Z
    invoke-virtual v4, v0, v1, Landroid/os/Bundle;->putBoolean(Ljava/lang/String; Z)V
    const-string v0, "window"
    iget v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->n1 I
    invoke-virtual v4, v0, v1, Landroid/os/BaseBundle;->putInt(Ljava/lang/String; I)V
    const-string v0, "position"
    iget-wide v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1 J
    invoke-virtual v4, v0, v1, v2, Landroid/os/BaseBundle;->putLong(Ljava/lang/String; J)V
    const-string v0, "speed"
    iget v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p0 F
    invoke-virtual v4, v0, v1, Landroid/os/Bundle;->putFloat(Ljava/lang/String; F)V
    return-void 
.end method

.method onStart()V
    .registers 3
    invoke-super v2, Lax/n/c;->onStart()V
    sget v0, Lax/S0/c0;->a I
    const/16 v1, 23
    if-le v0, v1, +00ch
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M2()V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-eqz v0, +005h
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->Q()V
    invoke-static Lax/R2/Q;->L1()Z
    move-result v0
    if-eqz v0, +012h
    invoke-virtual v2, Landroid/app/Activity;->getWindow()Landroid/view/Window;
    move-result-object v0
    const/high16 v1, -1157627904
    invoke-static v0, v1, Lax/R2/v;->s(Landroid/view/Window; I)V
    invoke-virtual v2, Landroid/app/Activity;->getWindow()Landroid/view/Window;
    move-result-object v0
    invoke-static v0, v1, Lax/R2/v;->r(Landroid/view/Window; I)V
    return-void 
.end method

.method onStop()V
    .registers 3
    invoke-super v2, Lax/n/c;->onStop()V
    sget v0, Lax/S0/c0;->a I
    const/16 v1, 23
    if-le v0, v1, +00ch
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-eqz v0, +005h
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->P()V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y3()V
    return-void 
.end method

.method t4()V
    .registers 3
    invoke-static v2, Lax/p3/m;->g(Landroid/content/Context;)I
    move-result v0
    const/4 v1, 1
    invoke-direct v2, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N3(I Z)V
    return-void 
.end method

.method v3()V
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b Landroidx/media3/ui/PlayerView;
    if-eqz v0, +005h
    invoke-virtual v0, Landroidx/media3/ui/PlayerView;->P()V
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y3()V
    invoke-direct v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M2()V
    return-void 
.end method

.method z3()V
    .registers 3
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w2()I
    move-result v0
    const/4 v1, 1
    invoke-direct v2, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r3(I Z)V
    return-void 
.end method
