# Class: Lcom/alphainventor/filemanager/viewer/f;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/f;
.super Ljava/lang/Object;

# Fields
.field a:Landroid/widget/PopupWindow;
.field b:Landroidx/recyclerview/widget/RecyclerView;
.field c:Landroid/content/Context;
.field d:Lcom/alphainventor/filemanager/viewer/f$c;
.field e:Lcom/alphainventor/filemanager/viewer/f$e;
.field f:Lcom/alphainventor/filemanager/viewer/f$b;
.field g:Lax/V1/f;
.field h:I
.field i:Z
.field j:Lcom/alphainventor/filemanager/viewer/f$h;

# Methods

.method <init>(Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/f$c;)V
    .registers 5
    invoke-direct v2, Ljava/lang/Object;-><init>()V
    iput-object v3, v2, Lcom/alphainventor/filemanager/viewer/f;->c Landroid/content/Context;
    iput-object v4, v2, Lcom/alphainventor/filemanager/viewer/f;->d Lcom/alphainventor/filemanager/viewer/f$c;
    invoke-virtual v3, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
    move-result-object v0
    const v1, 2131165382
    invoke-virtual v0, v1, Landroid/content/res/Resources;->getDimensionPixelSize(I)I
    move-result v0
    iput v0, v2, Lcom/alphainventor/filemanager/viewer/f;->h I
    new-instance v0, Lcom/alphainventor/filemanager/viewer/f$e;
    invoke-direct v0, v2, v3, v4, Lcom/alphainventor/filemanager/viewer/f$e;-><init>(Lcom/alphainventor/filemanager/viewer/f; Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/f$c;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/f;->e Lcom/alphainventor/filemanager/viewer/f$e;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/f$b;
    invoke-direct v0, v2, v3, v4, Lcom/alphainventor/filemanager/viewer/f$b;-><init>(Lcom/alphainventor/filemanager/viewer/f; Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/f$c;)V
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/f;->f Lcom/alphainventor/filemanager/viewer/f$b;
    new-instance v4, Lax/V1/f;
    invoke-virtual v3, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
    move-result-object v3
    invoke-direct v4, v3, Lax/V1/f;-><init>(Landroid/content/res/Resources;)V
    iput-object v4, v2, Lcom/alphainventor/filemanager/viewer/f;->g Lax/V1/f;
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/f;->g()Landroid/content/Context;
    move-result-object v3
    invoke-static v3, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;
    move-result-object v3
    const v4, 2131558531
    const/4 v0, 0
    invoke-virtual v3, v4, v0, Landroid/view/LayoutInflater;->inflate(I Landroid/view/ViewGroup;)Landroid/view/View;
    move-result-object v3
    check-cast v3, Landroidx/recyclerview/widget/RecyclerView;
    iput-object v3, v2, Lcom/alphainventor/filemanager/viewer/f;->b Landroidx/recyclerview/widget/RecyclerView;
    new-instance v4, Landroidx/recyclerview/widget/LinearLayoutManager;
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/f;->g()Landroid/content/Context;
    move-result-object v0
    invoke-direct v4, v0, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;)V
    invoke-virtual v3, v4, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$p;)V
    new-instance v4, Landroid/widget/PopupWindow;
    const/4 v0, -2
    const/4 v1, 1
    invoke-direct v4, v3, v0, v0, v1, Landroid/widget/PopupWindow;-><init>(Landroid/view/View; I I Z)V
    iput-object v4, v2, Lcom/alphainventor/filemanager/viewer/f;->a Landroid/widget/PopupWindow;
    sget v3, Lax/S0/c0;->a I
    const/16 v0, 23
    if-ge v3, v0, +00bh
    new-instance v3, Landroid/graphics/drawable/ColorDrawable;
    const/4 v0, 0
    invoke-direct v3, v0, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V
    invoke-virtual v4, v3, Landroid/widget/PopupWindow;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    new-instance v3, Lcom/alphainventor/filemanager/viewer/f$a;
    invoke-direct v3, v2, Lcom/alphainventor/filemanager/viewer/f$a;-><init>(Lcom/alphainventor/filemanager/viewer/f;)V
    invoke-virtual v4, v3, Landroid/widget/PopupWindow;->setOnDismissListener(Landroid/widget/PopupWindow$OnDismissListener;)V
    return-void 
.end method

.method a(Lcom/alphainventor/filemanager/viewer/f; Lax/P0/H; Lcom/alphainventor/filemanager/viewer/f$f;)V
    .registers 3
    invoke-direct v0, v1, v2, Lcom/alphainventor/filemanager/viewer/f;->m(Lax/P0/H; Lcom/alphainventor/filemanager/viewer/f$f;)V
    return-void 
.end method

.method b(Lcom/alphainventor/filemanager/viewer/f;)Landroid/widget/PopupWindow;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/f;->a Landroid/widget/PopupWindow;
    return-object v0
.end method

.method c(Lcom/alphainventor/filemanager/viewer/f;)Lcom/alphainventor/filemanager/viewer/f$h;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/f;->j Lcom/alphainventor/filemanager/viewer/f$h;
    return-object v0
.end method

.method e(Landroidx/recyclerview/widget/RecyclerView$h; Landroid/view/View;)V
    .registers 5
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/f;->b Landroidx/recyclerview/widget/RecyclerView;
    invoke-virtual v0, v3, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$h;)V
    invoke-direct v2, Lcom/alphainventor/filemanager/viewer/f;->p()V
    const/4 v3, 0
    iput-boolean v3, v2, Lcom/alphainventor/filemanager/viewer/f;->i Z
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/f;->a Landroid/widget/PopupWindow;
    invoke-virtual v0, Landroid/widget/PopupWindow;->dismiss()V
    const/4 v0, 1
    iput-boolean v0, v2, Lcom/alphainventor/filemanager/viewer/f;->i Z
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/f;->a Landroid/widget/PopupWindow;
    invoke-virtual v0, Landroid/widget/PopupWindow;->getHeight()I
    move-result v0
    neg-int v0, v0
    iget v1, v2, Lcom/alphainventor/filemanager/viewer/f;->h I
    sub-int/2addr v0, v1
    invoke-virtual v4, Landroid/view/View;->getHeight()I
    move-result v1
    sub-int/2addr v0, v1
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/f;->a Landroid/widget/PopupWindow;
    invoke-virtual v1, v4, v3, v0, Landroid/widget/PopupWindow;->showAsDropDown(Landroid/view/View; I I)V
    return-void 
.end method

.method f(Lax/P0/U; I)Lax/p7/z;
    .registers 11
    new-instance v0, Lax/p7/z$a;
    invoke-direct v0, Lax/p7/z$a;-><init>()V
    invoke-virtual v9, Lax/P0/U;->a()Lax/p7/z;
    move-result-object v1
    const/4 v2, 0
    const/4 v3, 0
    invoke-interface v1, Ljava/util/List;->size()I
    move-result v4
    if-ge v3, v4, +03ah
    invoke-interface v1, v3, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Lax/P0/U$a;
    invoke-virtual v4, Lax/P0/U$a;->d()I
    move-result v5
    if-eq v5, v10, +003h
    goto +29h
    const/4 v5, 0
    iget v6, v4, Lax/P0/U$a;->a I
    if-ge v5, v6, +025h
    invoke-virtual v4, v5, Lax/P0/U$a;->i(I)Z
    move-result v6
    if-nez v6, +003h
    goto +1ah
    invoke-virtual v4, v5, Lax/P0/U$a;->b(I)Lax/P0/v;
    move-result-object v6
    iget v7, v6, Lax/P0/v;->e I
    and-int/lit8 v7, v7, 2
    if-eqz v7, +003h
    goto +fh
    iget-object v7, v8, Lcom/alphainventor/filemanager/viewer/f;->g Lax/V1/f;
    invoke-virtual v7, v6, Lax/V1/f;->a(Lax/P0/v;)Ljava/lang/String;
    move-result-object v6
    new-instance v7, Lcom/alphainventor/filemanager/viewer/f$f;
    invoke-direct v7, v9, v3, v5, v6, Lcom/alphainventor/filemanager/viewer/f$f;-><init>(Lax/P0/U; I I Ljava/lang/String;)V
    invoke-virtual v0, v7, Lax/p7/z$a;->h(Ljava/lang/Object;)Lax/p7/z$a;
    add-int/lit8 v5, v5, 1
    goto -26h
    add-int/lit8 v3, v3, 1
    goto -3dh
    invoke-virtual v0, Lax/p7/z$a;->k()Lax/p7/z;
    move-result-object v9
    return-object v9
.end method

.method g()Landroid/content/Context;
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f;->c Landroid/content/Context;
    return-object v0
.end method

.method j()V
    .registers 4
    invoke-virtual v3, Lcom/alphainventor/filemanager/viewer/f;->h()Lax/P0/H;
    move-result-object v0
    if-nez v0, +007h
    const-string v1, "player is null when init trackselectionadapter"
    invoke-static v1, Lax/q3/b;->g(Ljava/lang/String;)V
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/f;->e Lcom/alphainventor/filemanager/viewer/f$e;
    invoke-virtual v1, Lcom/alphainventor/filemanager/viewer/f$g;->O()V
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/f;->f Lcom/alphainventor/filemanager/viewer/f$b;
    invoke-virtual v1, Lcom/alphainventor/filemanager/viewer/f$g;->O()V
    if-eqz v0, +02bh
    const/16 v1, 30
    invoke-interface v0, v1, Lax/P0/H;->U(I)Z
    move-result v1
    if-eqz v1, +023h
    const/16 v1, 29
    invoke-interface v0, v1, Lax/P0/H;->U(I)Z
    move-result v1
    if-nez v1, +003h
    goto +19h
    invoke-interface v0, Lax/P0/H;->P()Lax/P0/U;
    move-result-object v0
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/f;->f Lcom/alphainventor/filemanager/viewer/f$b;
    const/4 v2, 1
    invoke-direct v3, v0, v2, Lcom/alphainventor/filemanager/viewer/f;->f(Lax/P0/U; I)Lax/p7/z;
    move-result-object v2
    invoke-virtual v1, v2, Lcom/alphainventor/filemanager/viewer/f$b;->W(Ljava/util/List;)V
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/f;->e Lcom/alphainventor/filemanager/viewer/f$e;
    const/4 v2, 3
    invoke-direct v3, v0, v2, Lcom/alphainventor/filemanager/viewer/f;->f(Lax/P0/U; I)Lax/p7/z;
    move-result-object v0
    invoke-virtual v1, v0, Lcom/alphainventor/filemanager/viewer/f$e;->V(Ljava/util/List;)V
    return-void 
.end method

.method m(Lax/P0/H; Lcom/alphainventor/filemanager/viewer/f$f;)V
    .registers 7
    const/16 v0, 29
    invoke-interface v5, v0, Lax/P0/H;->U(I)Z
    move-result v0
    if-nez v0, +003h
    return-void 
    invoke-interface v5, Lax/P0/H;->c0()Lax/P0/S;
    move-result-object v0
    invoke-virtual v0, Lax/P0/S;->I()Lax/P0/S$c;
    move-result-object v0
    new-instance v1, Lax/P0/P;
    iget-object v2, v6, Lcom/alphainventor/filemanager/viewer/f$f;->a Lax/P0/U$a;
    invoke-virtual v2, Lax/P0/U$a;->a()Lax/P0/O;
    move-result-object v2
    iget v3, v6, Lcom/alphainventor/filemanager/viewer/f$f;->b I
    invoke-static v3, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v3
    invoke-static v3, Lax/p7/z;->A(Ljava/lang/Object;)Lax/p7/z;
    move-result-object v3
    invoke-direct v1, v2, v3, Lax/P0/P;-><init>(Lax/P0/O; Ljava/util/List;)V
    invoke-virtual v0, v1, Lax/P0/S$c;->N(Lax/P0/P;)Lax/P0/S$c;
    move-result-object v0
    iget-object v6, v6, Lcom/alphainventor/filemanager/viewer/f$f;->a Lax/P0/U$a;
    invoke-virtual v6, Lax/P0/U$a;->d()I
    move-result v6
    const/4 v1, 0
    invoke-virtual v0, v6, v1, Lax/P0/S$c;->U(I Z)Lax/P0/S$c;
    move-result-object v6
    invoke-virtual v6, Lax/P0/S$c;->F()Lax/P0/S;
    move-result-object v6
    invoke-interface v5, v6, Lax/P0/H;->t(Lax/P0/S;)V
    return-void 
.end method

.method p()V
    .registers 4
    invoke-virtual v3, Lcom/alphainventor/filemanager/viewer/f;->i()Landroidx/media3/ui/d;
    move-result-object v0
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/f;->b Landroidx/recyclerview/widget/RecyclerView;
    const/4 v2, 0
    invoke-virtual v1, v2, v2, Landroid/view/View;->measure(I I)V
    invoke-virtual v0, Landroid/view/View;->getWidth()I
    move-result v1
    iget v2, v3, Lcom/alphainventor/filemanager/viewer/f;->h I
    mul-int/lit8 v2, v2, 2
    sub-int/2addr v1, v2
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/f;->b Landroidx/recyclerview/widget/RecyclerView;
    invoke-virtual v2, Landroid/view/View;->getMeasuredWidth()I
    move-result v2
    invoke-static v2, v1, Ljava/lang/Math;->min(I I)I
    move-result v1
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/f;->a Landroid/widget/PopupWindow;
    invoke-virtual v2, v1, Landroid/widget/PopupWindow;->setWidth(I)V
    invoke-virtual v0, Landroid/view/View;->getHeight()I
    move-result v0
    iget v1, v3, Lcom/alphainventor/filemanager/viewer/f;->h I
    mul-int/lit8 v1, v1, 2
    sub-int/2addr v0, v1
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/f;->b Landroidx/recyclerview/widget/RecyclerView;
    invoke-virtual v1, Landroid/view/View;->getMeasuredHeight()I
    move-result v1
    invoke-static v0, v1, Ljava/lang/Math;->min(I I)I
    move-result v0
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/f;->a Landroid/widget/PopupWindow;
    invoke-virtual v1, v0, Landroid/widget/PopupWindow;->setHeight(I)V
    return-void 
.end method

.method d()V
    .registers 2
    const/4 v0, 0
    iput-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/f;->i Z
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f;->a Landroid/widget/PopupWindow;
    invoke-virtual v0, Landroid/widget/PopupWindow;->dismiss()V
    const/4 v0, 1
    iput-boolean v0, v1, Lcom/alphainventor/filemanager/viewer/f;->i Z
    return-void 
.end method

.method h()Lax/P0/H;
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f;->d Lcom/alphainventor/filemanager/viewer/f$c;
    invoke-interface v0, Lcom/alphainventor/filemanager/viewer/f$c;->c()Lax/P0/H;
    move-result-object v0
    return-object v0
.end method

.method i()Landroidx/media3/ui/d;
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f;->d Lcom/alphainventor/filemanager/viewer/f$c;
    invoke-interface v0, Lcom/alphainventor/filemanager/viewer/f$c;->j()Landroidx/media3/ui/d;
    move-result-object v0
    return-object v0
.end method

.method k()V
    .registers 5
    invoke-virtual v4, Lcom/alphainventor/filemanager/viewer/f;->h()Lax/P0/H;
    move-result-object v0
    if-nez v0, +003h
    return-void 
    invoke-interface v0, Lax/P0/H;->P()Lax/P0/U;
    move-result-object v1
    const/4 v2, 3
    invoke-direct v4, v1, v2, Lcom/alphainventor/filemanager/viewer/f;->f(Lax/P0/U; I)Lax/p7/z;
    move-result-object v1
    invoke-virtual v1, Ljava/util/AbstractCollection;->size()I
    move-result v2
    if-nez v2, +008h
    const-string v0, "no subtitle track"
    invoke-static v0, Lax/q3/b;->g(Ljava/lang/String;)V
    return-void 
    invoke-virtual v1, Ljava/util/AbstractCollection;->size()I
    move-result v2
    const/4 v3, 1
    if-eq v2, v3, +01ah
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct v2, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "subtitle count : "
    invoke-virtual v2, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, Ljava/util/AbstractCollection;->size()I
    move-result v3
    invoke-virtual v2, v3, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual v2, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-static v2, Lax/q3/b;->g(Ljava/lang/String;)V
    const/4 v2, 0
    invoke-interface v1, v2, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lcom/alphainventor/filemanager/viewer/f$f;
    invoke-direct v4, v0, v1, Lcom/alphainventor/filemanager/viewer/f;->m(Lax/P0/H; Lcom/alphainventor/filemanager/viewer/f$f;)V
    return-void 
.end method

.method l()V
    .registers 5
    invoke-virtual v4, Lcom/alphainventor/filemanager/viewer/f;->h()Lax/P0/H;
    move-result-object v0
    if-eqz v0, +028h
    const/16 v1, 29
    invoke-interface v0, v1, Lax/P0/H;->U(I)Z
    move-result v1
    if-eqz v1, +020h
    invoke-interface v0, Lax/P0/H;->c0()Lax/P0/S;
    move-result-object v1
    invoke-virtual v1, Lax/P0/S;->I()Lax/P0/S$c;
    move-result-object v1
    const/4 v2, 3
    invoke-virtual v1, v2, Lax/P0/S$c;->G(I)Lax/P0/S$c;
    move-result-object v1
    const/4 v3, -3
    invoke-virtual v1, v3, Lax/P0/S$c;->M(I)Lax/P0/S$c;
    move-result-object v1
    const/4 v3, 1
    invoke-virtual v1, v2, v3, Lax/P0/S$c;->U(I Z)Lax/P0/S$c;
    move-result-object v1
    invoke-virtual v1, Lax/P0/S$c;->F()Lax/P0/S;
    move-result-object v1
    invoke-interface v0, v1, Lax/P0/H;->t(Lax/P0/S;)V
    return-void 
.end method

.method n(Landroid/view/View;)V
    .registers 3
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f;->f Lcom/alphainventor/filemanager/viewer/f$b;
    invoke-direct v1, v0, v2, Lcom/alphainventor/filemanager/viewer/f;->e(Landroidx/recyclerview/widget/RecyclerView$h; Landroid/view/View;)V
    return-void 
.end method

.method o(Landroid/view/View; Lcom/alphainventor/filemanager/viewer/f$h;)V
    .registers 4
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f;->e Lcom/alphainventor/filemanager/viewer/f$e;
    invoke-direct v1, v0, v2, Lcom/alphainventor/filemanager/viewer/f;->e(Landroidx/recyclerview/widget/RecyclerView$h; Landroid/view/View;)V
    iput-object v3, v1, Lcom/alphainventor/filemanager/viewer/f;->j Lcom/alphainventor/filemanager/viewer/f$h;
    return-void 
.end method

.method q()V
    .registers 1
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/f;->j()V
    return-void 
.end method
