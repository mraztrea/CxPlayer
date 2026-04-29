# Class: Lcom/alphainventor/filemanager/viewer/f$b;
# Superclass: Lcom/alphainventor/filemanager/viewer/f$g;

.class Lcom/alphainventor/filemanager/viewer/f$b;
.super Lcom/alphainventor/filemanager/viewer/f$g;

# Fields
.field h:Lcom/alphainventor/filemanager/viewer/f;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/f; Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/f$c;)V
    .registers 4
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/f$b;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-direct v0, v1, v2, v3, Lcom/alphainventor/filemanager/viewer/f$g;-><init>(Lcom/alphainventor/filemanager/viewer/f; Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/f$c;)V
    return-void 
.end method

.method U(Lcom/alphainventor/filemanager/viewer/f$b; Lax/P0/H; Landroid/view/View;)V
    .registers 5
    invoke-virtual v2, Ljava/lang/Object;->getClass()Ljava/lang/Class;
    if-eqz v3, +033h
    const/16 v4, 29
    invoke-interface v3, v4, Lax/P0/H;->U(I)Z
    move-result v4
    if-nez v4, +003h
    goto +29h
    invoke-interface v3, Lax/P0/H;->c0()Lax/P0/S;
    move-result-object v4
    invoke-static v3, Lax/S0/c0;->h(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Lax/P0/H;
    invoke-virtual v4, Lax/P0/S;->I()Lax/P0/S$c;
    move-result-object v4
    const/4 v0, 1
    invoke-virtual v4, v0, Lax/P0/S$c;->G(I)Lax/P0/S$c;
    move-result-object v4
    const/4 v1, 0
    invoke-virtual v4, v0, v1, Lax/P0/S$c;->U(I Z)Lax/P0/S$c;
    move-result-object v4
    invoke-virtual v4, Lax/P0/S$c;->F()Lax/P0/S;
    move-result-object v4
    invoke-interface v3, v4, Lax/P0/H;->t(Lax/P0/S;)V
    iget-object v2, v2, Lcom/alphainventor/filemanager/viewer/f$b;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/f;->b(Lcom/alphainventor/filemanager/viewer/f;)Landroid/widget/PopupWindow;
    move-result-object v2
    invoke-virtual v2, Landroid/widget/PopupWindow;->dismiss()V
    return-void 
.end method

.method V(Lax/P0/S;)Z
    .registers 6
    const/4 v0, 0
    const/4 v1, 0
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    invoke-interface v2, Ljava/util/List;->size()I
    move-result v2
    if-ge v1, v2, +01dh
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    invoke-interface v2, v1, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/alphainventor/filemanager/viewer/f$f;
    iget-object v2, v2, Lcom/alphainventor/filemanager/viewer/f$f;->a Lax/P0/U$a;
    invoke-virtual v2, Lax/P0/U$a;->a()Lax/P0/O;
    move-result-object v2
    iget-object v3, v5, Lax/P0/S;->D Lax/p7/A;
    invoke-virtual v3, v2, Lax/p7/A;->containsKey(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, +004h
    const/4 v5, 1
    return v5
    add-int/lit8 v1, v1, 1
    goto -22h
    return v0
.end method

.method R(Lcom/alphainventor/filemanager/viewer/f$d;)V
    .registers 5
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/f$d;->u Landroid/widget/TextView;
    const v1, 2131952008
    invoke-virtual v0, v1, Landroid/widget/TextView;->setText(I)V
    iget-object v0, v3, Lcom/alphainventor/filemanager/viewer/f$b;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-virtual v0, Lcom/alphainventor/filemanager/viewer/f;->h()Lax/P0/H;
    move-result-object v0
    if-nez v0, +003h
    return-void 
    invoke-static v0, Lax/S0/a;->e(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lax/P0/H;
    invoke-interface v1, Lax/P0/H;->c0()Lax/P0/S;
    move-result-object v1
    invoke-direct v3, v1, Lcom/alphainventor/filemanager/viewer/f$b;->V(Lax/P0/S;)Z
    move-result v1
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/f$d;->v Landroid/view/View;
    if-eqz v1, +004h
    const/4 v1, 4
    goto +2h
    const/4 v1, 0
    invoke-virtual v2, v1, Landroid/view/View;->setVisibility(I)V
    iget-object v4, v4, Landroidx/recyclerview/widget/RecyclerView$F;->a Landroid/view/View;
    new-instance v1, Lax/s3/g;
    invoke-direct v1, v3, v0, Lax/s3/g;-><init>(Lcom/alphainventor/filemanager/viewer/f$b; Lax/P0/H;)V
    invoke-virtual v4, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    return-void 
.end method

.method T(Ljava/lang/String;)V
    .registers 2
    return-void 
.end method

.method W(Ljava/util/List;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    return-void 
.end method
