# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$q;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$q;
.super Ljava/lang/Object;

# Fields
.field a:Landroid/widget/ImageView;
.field b:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Landroid/widget/ImageView;)V
    .registers 3
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$q;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    iput-object v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$q;->a Landroid/widget/ImageView;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method onAnimationEnd(Landroid/view/animation/Animation;)V
    .registers 4
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$q;->a Landroid/widget/ImageView;
    const/16 v0, 8
    invoke-virtual v3, v0, Landroid/widget/ImageView;->setVisibility(I)V
    new-instance v3, Landroid/view/animation/AlphaAnimation;
    const/high16 v0, 1065353216
    const/4 v1, 0
    invoke-direct v3, v0, v1, Landroid/view/animation/AlphaAnimation;-><init>(F F)V
    const-wide/16 v0, 750
    invoke-virtual v3, v0, v1, Landroid/view/animation/Animation;->setDuration(J)V
    new-instance v0, Landroid/view/animation/DecelerateInterpolator;
    invoke-direct v0, Landroid/view/animation/DecelerateInterpolator;-><init>()V
    invoke-virtual v3, v0, Landroid/view/animation/Animation;->setInterpolator(Landroid/view/animation/Interpolator;)V
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$q;->a Landroid/widget/ImageView;
    invoke-virtual v0, v3, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    return-void 
.end method

.method onAnimationRepeat(Landroid/view/animation/Animation;)V
    .registers 2
    return-void 
.end method

.method onAnimationStart(Landroid/view/animation/Animation;)V
    .registers 2
    return-void 
.end method
