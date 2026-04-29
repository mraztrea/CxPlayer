# Class: Lcom/alphainventor/filemanager/viewer/f$g;
# Superclass: Landroidx/recyclerview/widget/RecyclerView$h;

.class Lcom/alphainventor/filemanager/viewer/f$g;
.super Landroidx/recyclerview/widget/RecyclerView$h;

# Fields
.field d:Ljava/util/List;
.field e:Landroid/content/Context;
.field f:Lcom/alphainventor/filemanager/viewer/f$c;
.field g:Lcom/alphainventor/filemanager/viewer/f;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/f; Landroid/content/Context; Lcom/alphainventor/filemanager/viewer/f$c;)V
    .registers 4
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/f$g;->g Lcom/alphainventor/filemanager/viewer/f;
    invoke-direct v0, Landroidx/recyclerview/widget/RecyclerView$h;-><init>()V
    new-instance v1, Ljava/util/ArrayList;
    invoke-direct v1, Ljava/util/ArrayList;-><init>()V
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    iput-object v2, v0, Lcom/alphainventor/filemanager/viewer/f$g;->e Landroid/content/Context;
    iput-object v3, v0, Lcom/alphainventor/filemanager/viewer/f$g;->f Lcom/alphainventor/filemanager/viewer/f$c;
    return-void 
.end method

.method N(Lcom/alphainventor/filemanager/viewer/f$g; Lax/P0/H; Lcom/alphainventor/filemanager/viewer/f$f; Landroid/view/View;)V
    .registers 4
    iget-object v3, v0, Lcom/alphainventor/filemanager/viewer/f$g;->g Lcom/alphainventor/filemanager/viewer/f;
    invoke-static v3, v1, v2, Lcom/alphainventor/filemanager/viewer/f;->a(Lcom/alphainventor/filemanager/viewer/f; Lax/P0/H; Lcom/alphainventor/filemanager/viewer/f$f;)V
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/f$f;->c Ljava/lang/String;
    invoke-virtual v0, v1, Lcom/alphainventor/filemanager/viewer/f$g;->T(Ljava/lang/String;)V
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/f$g;->g Lcom/alphainventor/filemanager/viewer/f;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/f;->b(Lcom/alphainventor/filemanager/viewer/f;)Landroid/widget/PopupWindow;
    move-result-object v0
    invoke-virtual v0, Landroid/widget/PopupWindow;->dismiss()V
    return-void 
.end method

.method B(Landroidx/recyclerview/widget/RecyclerView$F; I)V
    .registers 3
    check-cast v1, Lcom/alphainventor/filemanager/viewer/f$d;
    invoke-virtual v0, v1, v2, Lcom/alphainventor/filemanager/viewer/f$g;->Q(Lcom/alphainventor/filemanager/viewer/f$d; I)V
    return-void 
.end method

.method D(Landroid/view/ViewGroup; I)Landroidx/recyclerview/widget/RecyclerView$F;
    .registers 3
    invoke-virtual v0, v1, v2, Lcom/alphainventor/filemanager/viewer/f$g;->S(Landroid/view/ViewGroup; I)Lcom/alphainventor/filemanager/viewer/f$d;
    move-result-object v1
    return-object v1
.end method

.method O()V
    .registers 2
    sget-object v0, Ljava/util/Collections;->EMPTY_LIST Ljava/util/List;
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    return-void 
.end method

.method P()Landroid/content/Context;
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f$g;->e Landroid/content/Context;
    return-object v0
.end method

.method Q(Lcom/alphainventor/filemanager/viewer/f$d; I)V
    .registers 8
    iget-object v0, v5, Lcom/alphainventor/filemanager/viewer/f$g;->g Lcom/alphainventor/filemanager/viewer/f;
    invoke-virtual v0, Lcom/alphainventor/filemanager/viewer/f;->h()Lax/P0/H;
    move-result-object v0
    if-nez v0, +003h
    return-void 
    if-nez v7, +006h
    invoke-virtual v5, v6, Lcom/alphainventor/filemanager/viewer/f$g;->R(Lcom/alphainventor/filemanager/viewer/f$d;)V
    return-void 
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    const/4 v2, 1
    sub-int/2addr v7, v2
    invoke-interface v1, v7, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v7
    check-cast v7, Lcom/alphainventor/filemanager/viewer/f$f;
    iget-object v1, v7, Lcom/alphainventor/filemanager/viewer/f$f;->a Lax/P0/U$a;
    invoke-virtual v1, Lax/P0/U$a;->a()Lax/P0/O;
    move-result-object v1
    invoke-interface v0, Lax/P0/H;->c0()Lax/P0/S;
    move-result-object v3
    iget-object v3, v3, Lax/P0/S;->D Lax/p7/A;
    invoke-virtual v3, v1, Lax/p7/A;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v1
    const/4 v3, 0
    if-eqz v1, +009h
    invoke-virtual v7, Lcom/alphainventor/filemanager/viewer/f$f;->a()Z
    move-result v1
    if-eqz v1, +003h
    goto +2h
    const/4 v2, 0
    iget-object v1, v6, Lcom/alphainventor/filemanager/viewer/f$d;->u Landroid/widget/TextView;
    iget-object v4, v7, Lcom/alphainventor/filemanager/viewer/f$f;->c Ljava/lang/String;
    invoke-virtual v1, v4, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    iget-object v1, v6, Lcom/alphainventor/filemanager/viewer/f$d;->v Landroid/view/View;
    if-eqz v2, +003h
    goto +2h
    const/4 v3, 4
    invoke-virtual v1, v3, Landroid/view/View;->setVisibility(I)V
    iget-object v6, v6, Landroidx/recyclerview/widget/RecyclerView$F;->a Landroid/view/View;
    new-instance v1, Lax/s3/i;
    invoke-direct v1, v5, v0, v7, Lax/s3/i;-><init>(Lcom/alphainventor/filemanager/viewer/f$g; Lax/P0/H; Lcom/alphainventor/filemanager/viewer/f$f;)V
    invoke-virtual v6, v1, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    return-void 
.end method

.method R(Lcom/alphainventor/filemanager/viewer/f$d;)V
.end method

.method S(Landroid/view/ViewGroup; I)Lcom/alphainventor/filemanager/viewer/f$d;
    .registers 5
    invoke-virtual v2, Lcom/alphainventor/filemanager/viewer/f$g;->P()Landroid/content/Context;
    move-result-object v4
    invoke-static v4, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;
    move-result-object v4
    const v0, 2131558533
    const/4 v1, 0
    invoke-virtual v4, v0, v3, v1, Landroid/view/LayoutInflater;->inflate(I Landroid/view/ViewGroup; Z)Landroid/view/View;
    move-result-object v3
    new-instance v4, Lcom/alphainventor/filemanager/viewer/f$d;
    invoke-direct v4, v3, Lcom/alphainventor/filemanager/viewer/f$d;-><init>(Landroid/view/View;)V
    return-object v4
.end method

.method T(Ljava/lang/String;)V
.end method

.method l()I
    .registers 2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    invoke-interface v0, Ljava/util/List;->isEmpty()Z
    move-result v0
    if-eqz v0, +004h
    const/4 v0, 0
    return v0
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/f$g;->d Ljava/util/List;
    invoke-interface v0, Ljava/util/List;->size()I
    move-result v0
    add-int/lit8 v0, v0, 1
    return v0
.end method
