# Class: Lcom/alphainventor/filemanager/viewer/f$e;
# Superclass: Lcom/alphainventor/filemanager/viewer/f$g;

.class Lcom/alphainventor/filemanager/viewer/f$e;
.super Lcom/alphainventor/filemanager/viewer/f$g;

# Fields
.field h:Lcom/alphainventor/filemanager/viewer/f;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/f; Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/f$c;)V
    .registers 4
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/f$e;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-direct v0, v1, v2, v3, Lcom/alphainventor/filemanager/viewer/f$g;-><init>(Lcom/alphainventor/filemanager/viewer/f; Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/f$c;)V
    return-void 
.end method

.method U(Lcom/alphainventor/filemanager/viewer/f$e; Landroid/view/View;)V
    .registers 3
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/f$e;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-virtual v2, Lcom/alphainventor/filemanager/viewer/f;->l()V
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/f$e;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/f;->c(Lcom/alphainventor/filemanager/viewer/f;)Lcom/alphainventor/filemanager/viewer/f$h;
    move-result-object v2
    if-eqz v2, +00ch
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/f$e;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/f;->c(Lcom/alphainventor/filemanager/viewer/f;)Lcom/alphainventor/filemanager/viewer/f$h;
    move-result-object v2
    const/4 v0, 0
    invoke-interface v2, v0, Lcom/alphainventor/filemanager/viewer/f$h;->a(Z)V
    iget-object v1, v1, Lcom/alphainventor/filemanager/viewer/f$e;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/f;->b(Lcom/alphainventor/filemanager/viewer/f;)Landroid/widget/PopupWindow;
    move-result-object v1
    invoke-virtual v1, Landroid/widget/PopupWindow;->dismiss()V
    return-void 
.end method

.method B(Landroidx/recyclerview/widget/RecyclerView$F; I)V
    .registers 3
    check-cast v1, Lcom/alphainventor/filemanager/viewer/f$d;
    invoke-virtual v0, v1, v2, Lcom/alphainventor/filemanager/viewer/f$e;->Q(Lcom/alphainventor/filemanager/viewer/f$d; I)V
    return-void 
.end method

.method Q(Lcom/alphainventor/filemanager/viewer/f$d; I)V
    .registers 4
    invoke-super v1, v2, v3, Lcom/alphainventor/filemanager/viewer/f$g;->Q(Lcom/alphainventor/filemanager/viewer/f$d; I)V
    if-lez v3, +01ah
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    add-int/lit8 v3, v3, -1
    invoke-interface v0, v3, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Lcom/alphainventor/filemanager/viewer/f$f;
    iget-object v2, v2, Lcom/alphainventor/filemanager/viewer/f$d;->v Landroid/view/View;
    invoke-virtual v3, Lcom/alphainventor/filemanager/viewer/f$f;->a()Z
    move-result v3
    if-eqz v3, +004h
    const/4 v3, 0
    goto +2h
    const/4 v3, 4
    invoke-virtual v2, v3, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method R(Lcom/alphainventor/filemanager/viewer/f$d;)V
    .registers 5
    iget-object v0, v4, Lcom/alphainventor/filemanager/viewer/f$d;->u Landroid/widget/TextView;
    const v1, 2131952009
    invoke-virtual v0, v1, Landroid/widget/TextView;->setText(I)V
    const/4 v0, 0
    const/4 v1, 0
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    invoke-interface v2, Ljava/util/List;->size()I
    move-result v2
    if-ge v1, v2, +015h
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    invoke-interface v2, v1, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/alphainventor/filemanager/viewer/f$f;
    invoke-virtual v2, Lcom/alphainventor/filemanager/viewer/f$f;->a()Z
    move-result v2
    if-eqz v2, +004h
    const/4 v1, 0
    goto +5h
    add-int/lit8 v1, v1, 1
    goto -1ah
    const/4 v1, 1
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/f$d;->v Landroid/view/View;
    if-eqz v1, +003h
    goto +2h
    const/4 v0, 4
    invoke-virtual v2, v0, Landroid/view/View;->setVisibility(I)V
    iget-object v4, v4, Landroidx/recyclerview/widget/RecyclerView$F;->a Landroid/view/View;
    new-instance v0, Lax/s3/h;
    invoke-direct v0, v3, Lax/s3/h;-><init>(Lcom/alphainventor/filemanager/viewer/f$e;)V
    invoke-virtual v4, v0, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    return-void 
.end method

.method T(Ljava/lang/String;)V
    .registers 3
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/f$e;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/f;->c(Lcom/alphainventor/filemanager/viewer/f;)Lcom/alphainventor/filemanager/viewer/f$h;
    move-result-object v2
    if-eqz v2, +00ch
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/f$e;->h Lcom/alphainventor/filemanager/viewer/f;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/f;->c(Lcom/alphainventor/filemanager/viewer/f;)Lcom/alphainventor/filemanager/viewer/f$h;
    move-result-object v2
    const/4 v0, 1
    invoke-interface v2, v0, Lcom/alphainventor/filemanager/viewer/f$h;->a(Z)V
    return-void 
.end method

.method V(Ljava/util/List;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    return-void 
.end method
