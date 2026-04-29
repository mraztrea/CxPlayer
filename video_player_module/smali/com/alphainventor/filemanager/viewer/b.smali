# Class: Lcom/alphainventor/filemanager/viewer/b;
# Superclass: Lcom/android/ex/photo/f;

.class Lcom/alphainventor/filemanager/viewer/b;
.super Lcom/android/ex/photo/f;

# Fields
.field P:Ljava/util/List;
.field Q:Z
.field R:Lcom/alphainventor/filemanager/file/o;
.field S:Lax/n3/d;
.field T:Landroid/database/Cursor;
.field U:Lcom/alphainventor/filemanager/viewer/b$b;

# Methods

.method <init>(Lcom/android/ex/photo/f$g; Ljava/util/List; Lcom/alphainventor/filemanager/file/o;)V
    .registers 4
    invoke-direct v0, v1, Lcom/android/ex/photo/f;-><init>(Lcom/android/ex/photo/f$g;)V
    iput-object v2, v0, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    iput-object v3, v0, Lcom/alphainventor/filemanager/viewer/b;->R Lcom/alphainventor/filemanager/file/o;
    new-instance v2, Lax/n3/d;
    invoke-interface v1, Lcom/android/ex/photo/f$g;->b()Landroid/content/Context;
    move-result-object v1
    iget-object v3, v0, Lcom/alphainventor/filemanager/viewer/b;->R Lcom/alphainventor/filemanager/file/o;
    invoke-direct v2, v1, v3, Lax/n3/d;-><init>(Landroid/content/Context; Lcom/alphainventor/filemanager/file/o;)V
    iput-object v2, v0, Lcom/alphainventor/filemanager/viewer/b;->S Lax/n3/d;
    return-void 
.end method

.method F0(Lcom/alphainventor/filemanager/viewer/b;)Z
    .registers 1
    invoke-virtual v0, Lcom/android/ex/photo/f;->Y()Z
    move-result v0
    return v0
.end method

.method G0(Lcom/alphainventor/filemanager/viewer/b; I)Z
    .registers 2
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/b;->R0(I)Z
    move-result v0
    return v0
.end method

.method H0(Lcom/alphainventor/filemanager/viewer/b;)Ljava/util/List;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    return-object v0
.end method

.method I0(Lcom/alphainventor/filemanager/viewer/b;)Lax/n3/d;
    .registers 1
    iget-object v0, v0, Lcom/alphainventor/filemanager/viewer/b;->S Lax/n3/d;
    return-object v0
.end method

.method J0(Landroid/content/Context; Landroid/net/Uri; Ljava/util/List;)Ljava/util/ArrayList;
    .registers 9
    invoke-static v6, v7, Lax/U2/Q;->H3(Landroid/content/Context; Landroid/net/Uri;)Z
    move-result v6
    new-instance v7, Ljava/util/ArrayList;
    invoke-direct v7, Ljava/util/ArrayList;-><init>()V
    const/4 v0, 0
    const/4 v1, 0
    invoke-interface v8, Ljava/util/List;->size()I
    move-result v2
    if-ge v1, v2, +025h
    invoke-interface v8, v1, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/alphainventor/filemanager/file/n;
    if-eqz v6, +007h
    invoke-static v2, Lax/W2/v;->F(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v3
    goto +5h
    invoke-static v2, Lax/W2/v;->E(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v3
    if-eqz v3, +00fh
    new-instance v3, Lcom/alphainventor/filemanager/viewer/e$a;
    invoke-static v2, v0, Lax/W2/p;->L(Lcom/alphainventor/filemanager/file/n; Z)Landroid/net/Uri;
    move-result-object v2
    const/4 v4, 0
    invoke-direct v3, v2, v4, Lcom/alphainventor/filemanager/viewer/e$a;-><init>(Landroid/net/Uri; Landroid/net/Uri;)V
    invoke-virtual v7, v3, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    add-int/lit8 v1, v1, 1
    goto -28h
    return-object v7
.end method

.method K0(Ljava/lang/String;)Lcom/alphainventor/filemanager/file/n;
    .registers 6
    const/4 v0, 0
    if-nez v5, +003h
    return-object v0
    iget-object v1, v4, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    if-nez v1, +003h
    return-object v0
    const/4 v1, 0
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    invoke-interface v2, Ljava/util/List;->size()I
    move-result v2
    if-ge v1, v2, +018h
    iget-object v2, v4, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    invoke-interface v2, v1, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/alphainventor/filemanager/file/n;
    invoke-virtual v2, Lcom/alphainventor/filemanager/file/n;->S()Ljava/lang/String;
    move-result-object v3
    invoke-virtual v5, v3, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, +003h
    return-object v2
    add-int/lit8 v1, v1, 1
    goto -1dh
    return-object v0
.end method

.method L0(Landroid/net/Uri;)I
    .registers 7
    const/4 v0, -1
    if-nez v6, +003h
    return v0
    iget-object v1, v5, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    if-nez v1, +003h
    return v0
    const/4 v1, 0
    const/4 v2, 0
    iget-object v3, v5, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    invoke-interface v3, Ljava/util/List;->size()I
    move-result v3
    if-ge v2, v3, +01eh
    iget-object v3, v5, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    invoke-interface v3, v2, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Lcom/alphainventor/filemanager/file/n;
    invoke-static v3, Lax/W2/w;->F(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v4
    if-eqz v4, +00dh
    invoke-static v3, v1, Lax/W2/p;->L(Lcom/alphainventor/filemanager/file/n; Z)Landroid/net/Uri;
    move-result-object v3
    invoke-virtual v6, v3, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, +003h
    return v2
    add-int/lit8 v2, v2, 1
    goto -23h
    return v0
.end method

.method M0(Lax/w3/a;)V
    .registers 2
    invoke-virtual v0, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v1
    if-eqz v1, +009h
    invoke-virtual v0, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v1
    invoke-interface v1, Lcom/android/ex/photo/f$g;->g()V
    return-void 
.end method

.method O0(Landroid/content/Context; Lcom/alphainventor/filemanager/file/n; Z)Landroid/content/Intent;
    .registers 10
    invoke-static v8, Lax/W2/w;->F(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v0
    invoke-static v0, Lax/q3/b;->c(Z)V
    const-string v0, "application/octet-stream"
    invoke-static v8, v0, Lax/W2/q;->e(Lcom/alphainventor/filemanager/file/n; Ljava/lang/String;)Ljava/lang/String;
    move-result-object v4
    invoke-static v8, Lax/W2/w;->F(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v0
    if-eqz v0, +008h
    invoke-static v8, Lax/U2/Q;->D3(Lcom/alphainventor/filemanager/file/n;)Landroid/net/Uri;
    move-result-object v8
    move-object v3, v8
    goto +ah
    invoke-virtual v8, Lcom/alphainventor/filemanager/file/n;->b0()Ljava/io/File;
    move-result-object v8
    invoke-static v8, Lax/W2/p;->w(Ljava/io/File;)Landroid/net/Uri;
    move-result-object v8
    goto -ah
    sget-object v2, Lax/T2/c$a;->d0 Lax/T2/c$a;
    const/4 v5, 1
    move-object v1, v7
    move v6, v9
    invoke-static/range v1 ... v6, Lax/U2/Q;->y3(Landroid/content/Context; Lax/T2/c$a; Landroid/net/Uri; Ljava/lang/String; Z Z)Landroid/content/Intent;
    move-result-object v7
    return-object v7
.end method

.method P0(Lax/w3/a;)Landroid/view/View;
    .registers 3
    invoke-virtual v2, Landroidx/fragment/app/Fragment;->S0()Landroid/view/View;
    move-result-object v0
    if-nez v0, +004h
    const/4 v2, 0
    return-object v2
    invoke-virtual v2, Landroidx/fragment/app/Fragment;->S0()Landroid/view/View;
    move-result-object v2
    const v0, 2131362065
    invoke-virtual v2, v0, Landroid/view/View;->findViewById(I)Landroid/view/View;
    move-result-object v2
    return-object v2
.end method

.method Q0(Lax/w3/a;)V
    .registers 3
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b;->P0(Lax/w3/a;)Landroid/view/View;
    move-result-object v2
    if-eqz v2, +007h
    const/16 v0, 8
    invoke-virtual v2, v0, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method R0(I)Z
    .registers 3
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    invoke-interface v0, Ljava/util/List;->size()I
    move-result v0
    if-ge v2, v0, +006h
    if-ltz v2, +004h
    const/4 v2, 1
    return v2
    const/4 v2, 0
    return v2
.end method

.method S0(Lax/w3/a;)V
    .registers 5
    invoke-direct v3, v4, Lcom/alphainventor/filemanager/viewer/b;->P0(Lax/w3/a;)Landroid/view/View;
    move-result-object v0
    if-nez v0, +006h
    invoke-static Lax/q3/b;->f()V
    return-void 
    invoke-virtual v4, Lax/w3/a;->V2()Ljava/lang/String;
    move-result-object v1
    invoke-static v1, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v1
    invoke-virtual v3, v1, Lcom/alphainventor/filemanager/viewer/b;->l(Landroid/net/Uri;)Z
    move-result v2
    if-eqz v2, +015h
    const/4 v2, 0
    invoke-virtual v4, v2, Lax/w3/a;->S2(Z)V
    invoke-virtual v0, v2, Landroid/view/View;->setVisibility(I)V
    new-instance v4, Lcom/alphainventor/filemanager/viewer/b$a;
    invoke-direct v4, v3, v1, Lcom/alphainventor/filemanager/viewer/b$a;-><init>(Lcom/alphainventor/filemanager/viewer/b; Landroid/net/Uri;)V
    invoke-virtual v0, v4, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual v0, Landroid/view/View;->requestFocus()Z
    return-void 
    const/16 v4, 8
    invoke-virtual v0, v4, Landroid/view/View;->setVisibility(I)V
    return-void 
.end method

.method D0()V
    .registers 9
    iget-object v0, v8, Lcom/android/ex/photo/f;->n Lcom/android/ex/photo/PhotoViewPager;
    invoke-virtual v0, Landroidx/viewpager/widget/ViewPager;->getCurrentItem()I
    move-result v0
    const/4 v1, 1
    add-int/lit8 v2, v0, 1
    iget v3, v8, Lcom/android/ex/photo/f;->j I
    const/4 v4, 0
    if-ltz v3, +004h
    const/4 v5, 1
    goto +2h
    const/4 v5, 0
    iget-boolean v6, v8, Lcom/android/ex/photo/f;->k Z
    if-nez v6, +05eh
    if-eqz v5, +05ch
    if-gtz v2, +003h
    goto +58h
    const-string v5, ""
    if-le v3, v1, +041h
    invoke-virtual v8, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v3
    invoke-interface v3, Lcom/android/ex/photo/f$g;->getResources()Landroid/content/res/Resources;
    move-result-object v3
    invoke-static v2, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v2
    iget v6, v8, Lcom/android/ex/photo/f;->j I
    invoke-static v6, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v6
    const/4 v7, 2
    new-array v7, v7, [Ljava/lang/Object;
    aput-object v2, v7, v4
    aput-object v6, v7, v1
    const v1, 2131952481
    invoke-virtual v3, v1, v7, Landroid/content/res/Resources;->getString(I [Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v1
    iput-object v1, v8, Lcom/android/ex/photo/f;->x Ljava/lang/String;
    invoke-direct v8, v0, Lcom/alphainventor/filemanager/viewer/b;->R0(I)Z
    move-result v1
    if-eqz v1, +016h
    iget-object v1, v8, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    invoke-interface v1, v0, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Lcom/alphainventor/filemanager/file/n;
    if-eqz v0, +009h
    invoke-virtual v0, Lcom/alphainventor/filemanager/file/n;->B()Ljava/lang/String;
    move-result-object v0
    iput-object v0, v8, Lcom/android/ex/photo/f;->y Ljava/lang/String;
    goto +1eh
    iput-object v5, v8, Lcom/android/ex/photo/f;->y Ljava/lang/String;
    goto +1bh
    iput-object v5, v8, Lcom/android/ex/photo/f;->y Ljava/lang/String;
    goto +18h
    iget-object v0, v8, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    invoke-interface v0, v4, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Lcom/alphainventor/filemanager/file/n;
    if-eqz v0, +009h
    invoke-virtual v0, Lcom/alphainventor/filemanager/file/n;->B()Ljava/lang/String;
    move-result-object v0
    iput-object v0, v8, Lcom/android/ex/photo/f;->x Ljava/lang/String;
    goto +7h
    iput-object v5, v8, Lcom/android/ex/photo/f;->x Ljava/lang/String;
    goto +4h
    const/4 v0, 0
    iput-object v0, v8, Lcom/android/ex/photo/f;->x Ljava/lang/String;
    invoke-virtual v8, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v0
    invoke-interface v0, Lcom/android/ex/photo/f$g;->m()Lcom/android/ex/photo/a;
    move-result-object v0
    invoke-virtual v8, v0, Lcom/android/ex/photo/f;->x0(Lcom/android/ex/photo/a;)V
    return-void 
.end method

.method I(I)V
    .registers 3
    invoke-super v1, v2, Lcom/android/ex/photo/f;->I(I)V
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/b;->U Lcom/alphainventor/filemanager/viewer/b$b;
    if-eqz v0, +015h
    invoke-virtual v0, Lax/q3/q;->isCancelled()Z
    move-result v0
    if-nez v0, +00fh
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/b;->U Lcom/alphainventor/filemanager/viewer/b$b;
    invoke-static v0, Lax/q3/q;->n(Lax/q3/q;)Z
    move-result v0
    if-eqz v0, +007h
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/b;->U Lcom/alphainventor/filemanager/viewer/b$b;
    invoke-virtual v0, Lax/q3/q;->e()Z
    new-instance v0, Lcom/alphainventor/filemanager/viewer/b$b;
    invoke-direct v0, v1, v2, Lcom/alphainventor/filemanager/viewer/b$b;-><init>(Lcom/alphainventor/filemanager/viewer/b; I)V
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/b;->U Lcom/alphainventor/filemanager/viewer/b$b;
    const/4 v2, 0
    new-array v2, v2, [Ljava/lang/Void;
    invoke-virtual v0, v2, Lax/q3/q;->i([Ljava/lang/Object;)Lax/q3/q;
    return-void 
.end method

.method N0()Landroid/net/Uri;
    .registers 4
    iget-object v0, v3, Lcom/android/ex/photo/f;->n Lcom/android/ex/photo/PhotoViewPager;
    invoke-virtual v0, Landroidx/viewpager/widget/ViewPager;->getCurrentItem()I
    move-result v0
    iget-object v1, v3, Lcom/android/ex/photo/f;->p Lax/v3/c;
    invoke-virtual v1, Lax/v3/a;->x()Landroid/database/Cursor;
    move-result-object v1
    if-eqz v1, +016h
    invoke-interface v1, Landroid/database/Cursor;->isClosed()Z
    move-result v2
    if-nez v2, +010h
    invoke-interface v1, v0, Landroid/database/Cursor;->moveToPosition(I)Z
    iget-object v0, v3, Lcom/android/ex/photo/f;->p Lax/v3/c;
    invoke-virtual v0, v1, Lax/v3/c;->E(Landroid/database/Cursor;)Ljava/lang/String;
    move-result-object v0
    invoke-static v0, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v0
    return-object v0
    const/4 v0, 0
    return-object v0
.end method

.method T0()V
    .registers 4
    const/4 v0, 1
    iput-boolean v0, v3, Lcom/alphainventor/filemanager/viewer/b;->Q Z
    iput-boolean v0, v3, Lcom/android/ex/photo/f;->k Z
    invoke-virtual v3, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v0
    invoke-interface v0, Lcom/android/ex/photo/f$g;->getSupportLoaderManager()Lax/J0/a;
    move-result-object v0
    const/16 v1, 100
    const/4 v2, 0
    invoke-virtual v0, v1, v2, v3, Lax/J0/a;->g(I Landroid/os/Bundle; Lax/J0/a$a;)Lax/K0/c;
    return-void 
.end method

.method U0()V
    .registers 2
    invoke-virtual v1, Lcom/android/ex/photo/f;->P()Lcom/android/ex/photo/e$b;
    move-result-object v0
    if-eqz v0, +005h
    invoke-interface v0, Lcom/android/ex/photo/e$b;->l()V
    return-void 
.end method

.method d0(I I Landroid/content/Intent;)V
    .registers 5
    const v0, 36001
    if-ne v2, v0, +018h
    const/4 v2, -1
    if-ne v3, v2, +015h
    if-eqz v4, +013h
    invoke-virtual v4, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v2
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b;->L0(Landroid/net/Uri;)I
    move-result v2
    if-ltz v2, +009h
    invoke-virtual v1, Lcom/android/ex/photo/f;->V()Lcom/android/ex/photo/PhotoViewPager;
    move-result-object v3
    invoke-virtual v3, v2, Landroidx/viewpager/widget/ViewPager;->setCurrentItem(I)V
    return-void 
.end method

.method g(Lcom/android/ex/photo/c; Landroid/view/View;)V
    .registers 5
    invoke-virtual v2, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v0
    if-nez v0, +003h
    return-void 
    invoke-virtual v4, Landroid/view/View;->getTag()Ljava/lang/Object;
    move-result-object v0
    instance-of v1, v0, Lax/s3/d;
    if-eqz v1, +005h
    check-cast v0, Lax/s3/d;
    goto +9h
    new-instance v0, Lax/s3/d;
    invoke-direct v0, v4, Lax/s3/d;-><init>(Landroid/view/View;)V
    invoke-virtual v4, v0, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    if-nez v3, +011h
    invoke-virtual v2, Lcom/alphainventor/filemanager/viewer/b;->N0()Landroid/net/Uri;
    move-result-object v4
    if-eqz v4, +00bh
    invoke-virtual v4, Landroid/net/Uri;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-direct v2, v4, Lcom/alphainventor/filemanager/viewer/b;->K0(Ljava/lang/String;)Lcom/alphainventor/filemanager/file/n;
    move-result-object v4
    goto +2h
    const/4 v4, 0
    invoke-virtual v2, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v1
    invoke-interface v1, Lcom/android/ex/photo/f$g;->b()Landroid/content/Context;
    move-result-object v1
    invoke-virtual v0, v1, v3, v4, Lax/s3/d;->d(Landroid/content/Context; Lcom/android/ex/photo/c; Lcom/alphainventor/filemanager/file/n;)V
    return-void 
.end method

.method i(Lax/w3/a;)V
    .registers 2
    invoke-super v0, v1, Lcom/android/ex/photo/f;->i(Lax/w3/a;)V
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/b;->S0(Lax/w3/a;)V
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/b;->M0(Lax/w3/a;)V
    return-void 
.end method

.method k0(Lax/K0/c; Landroid/database/Cursor;)V
    .registers 4
    if-eqz v3, +007h
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/b;->T Landroid/database/Cursor;
    if-ne v3, v0, +003h
    goto +32h
    iput-object v3, v1, Lcom/alphainventor/filemanager/viewer/b;->T Landroid/database/Cursor;
    invoke-super v1, v2, v3, Lcom/android/ex/photo/f;->k0(Lax/K0/c; Landroid/database/Cursor;)V
    goto +13h
    move-exception v2
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v3
    const-string v0, "IVOLF:"
    invoke-virtual v3, v0, Lax/za/b;->d(Ljava/lang/String;)Lax/za/b;
    move-result-object v3
    invoke-virtual v3, v2, Lax/za/b;->l(Ljava/lang/Throwable;)Lax/za/b;
    move-result-object v2
    invoke-virtual v2, Lax/za/b;->h()V
    iget-boolean v2, v1, Lcom/alphainventor/filemanager/viewer/b;->Q Z
    if-eqz v2, +017h
    const/4 v2, 0
    iput-boolean v2, v1, Lcom/alphainventor/filemanager/viewer/b;->Q Z
    invoke-virtual v1, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v2
    if-eqz v2, +00eh
    invoke-virtual v1, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v2
    check-cast v2, Lcom/alphainventor/filemanager/viewer/ImageViewerActivity;
    invoke-virtual v2, Lcom/alphainventor/filemanager/viewer/ImageViewerActivity;->y0()V
    invoke-virtual v1, Lcom/alphainventor/filemanager/viewer/b;->D0()V
    return-void 
.end method

.method l(Landroid/net/Uri;)Z
    .registers 3
    invoke-virtual v2, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v2
    invoke-static v2, Lax/W2/Y;->k(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    sget-object v0, Lax/W2/u;->e0 Lax/W2/u;
    invoke-static v2, Lax/W2/v;->g(Ljava/lang/String;)Lax/W2/u;
    move-result-object v2
    if-ne v0, v2, +004h
    const/4 v2, 1
    return v2
    const/4 v2, 0
    return v2
.end method

.method o0()V
    .registers 2
    invoke-super v1, Lcom/android/ex/photo/f;->o0()V
    invoke-virtual v1, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v0
    if-eqz v0, +010h
    invoke-virtual v1, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v0
    invoke-interface v0, Lcom/android/ex/photo/f$g;->t()Z
    move-result v0
    if-nez v0, +006h
    const/4 v0, 0
    invoke-virtual v1, v0, v0, Lcom/android/ex/photo/f;->y0(Z Z)V
    return-void 
.end method

.method r(Landroid/net/Uri; Z)V
    .registers 15
    invoke-virtual v12, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v0
    if-nez v0, +004h
    goto/16 +15ah
    invoke-virtual v13, Landroid/net/Uri;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-direct v12, v0, Lcom/alphainventor/filemanager/viewer/b;->K0(Ljava/lang/String;)Lcom/alphainventor/filemanager/file/n;
    move-result-object v0
    if-nez v0, +004h
    goto/16 +14eh
    iget-object v1, v12, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    invoke-static v0, Lax/W2/w;->F(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v2
    if-nez v2, +017h
    invoke-virtual v0, Lcom/alphainventor/filemanager/file/n;->Q()Lcom/alphainventor/filemanager/file/y;
    move-result-object v2
    if-eqz v2, +011h
    invoke-static v2, v0, Lax/W2/w;->D(Lcom/alphainventor/filemanager/file/n; Lcom/alphainventor/filemanager/file/n;)Z
    move-result v3
    if-eqz v3, +00bh
    invoke-static v2, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;
    move-result-object v1
    move-object v0, v2
    goto +4h
    nop 
    goto -3h
    nop 
    invoke-virtual v12, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v2
    invoke-interface v2, Lcom/android/ex/photo/f$g;->b()Landroid/content/Context;
    move-result-object v2
    check-cast v2, Landroid/app/Activity;
    invoke-static v0, Lax/W2/w;->F(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v3
    const v4, 2131951922
    const/4 v5, 1
    if-eqz v3, +0dch
    move-object v8, v0
    check-cast v8, Lax/W2/i;
    const/4 v13, 0
    if-eqz v14, +005h
    sget-object v14, Lcom/alphainventor/filemanager/viewer/b$d;->q Lcom/alphainventor/filemanager/viewer/b$d;
    goto +32h
    sget-object v14, Lax/T2/c$a;->c0 Lax/T2/c$a;
    invoke-static v2, v14, v8, v13, Lax/U2/Q;->J3(Landroid/content/Context; Lax/T2/c$a; Lcom/alphainventor/filemanager/file/n; Z)Z
    move-result v0
    if-eqz v0, +00bh
    invoke-static v2, v14, v8, v13, Lax/U2/Q;->M3(Landroid/content/Context; Lax/T2/c$a; Lcom/alphainventor/filemanager/file/n; Z)Z
    move-result v14
    if-nez v14, +005h
    sget-object v14, Lcom/alphainventor/filemanager/viewer/b$d;->c0 Lcom/alphainventor/filemanager/viewer/b$d;
    goto +21h
    invoke-static v2, Lax/p3/k;->E(Landroid/content/Context;)Z
    move-result v14
    if-eqz v14, +00bh
    invoke-static v8, Lax/W2/v;->E(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v14
    if-eqz v14, +005h
    sget-object v14, Lcom/alphainventor/filemanager/viewer/b$d;->q Lcom/alphainventor/filemanager/viewer/b$d;
    goto +12h
    invoke-static v2, v8, v5, Lcom/alphainventor/filemanager/viewer/b;->O0(Landroid/content/Context; Lcom/alphainventor/filemanager/file/n; Z)Landroid/content/Intent;
    move-result-object v14
    if-eqz v14, +00bh
    invoke-static v14, Lax/W2/p;->U(Landroid/content/Intent;)Z
    move-result v14
    if-eqz v14, +005h
    sget-object v14, Lcom/alphainventor/filemanager/viewer/b$d;->q Lcom/alphainventor/filemanager/viewer/b$d;
    goto +3h
    sget-object v14, Lcom/alphainventor/filemanager/viewer/b$d;->d0 Lcom/alphainventor/filemanager/viewer/b$d;
    sget-object v0, Lcom/alphainventor/filemanager/viewer/b$d;->q Lcom/alphainventor/filemanager/viewer/b$d;
    if-ne v14, v0, +064h
    invoke-static v8, v13, Lax/W2/p;->L(Lcom/alphainventor/filemanager/file/n; Z)Landroid/net/Uri;
    move-result-object v14
    invoke-direct v12, v2, v14, v1, Lcom/alphainventor/filemanager/viewer/b;->J0(Landroid/content/Context; Landroid/net/Uri; Ljava/util/List;)Ljava/util/ArrayList;
    move-result-object v0
    invoke-static Lax/K2/a;->i()Lax/K2/a;
    move-result-object v1
    const-string v3, "command"
    const-string v6, "file_open"
    invoke-virtual v1, v3, v6, Lax/K2/a;->m(Ljava/lang/String; Ljava/lang/String;)Lax/K2/a$b;
    move-result-object v1
    const-string v3, "loc"
    const-string v6, "ImageViewerActivity"
    invoke-virtual v1, v3, v6, Lax/K2/a$b;->c(Ljava/lang/String; Ljava/lang/String;)Lax/K2/a$b;
    move-result-object v1
    const-string v3, "ext"
    invoke-virtual v8, Lcom/alphainventor/filemanager/file/n;->A()Ljava/lang/String;
    move-result-object v6
    invoke-virtual v1, v3, v6, Lax/K2/a$b;->c(Ljava/lang/String; Ljava/lang/String;)Lax/K2/a$b;
    move-result-object v1
    const-string v3, "result"
    const-string v6, "success"
    invoke-virtual v1, v3, v6, Lax/K2/a$b;->c(Ljava/lang/String; Ljava/lang/String;)Lax/K2/a$b;
    move-result-object v1
    invoke-virtual v1, Lax/K2/a$b;->e()V
    invoke-static v2, v14, v0, v5, v13, Lax/W2/r;->i(Landroid/content/Context; Landroid/net/Uri; Ljava/util/ArrayList; Z Z)Landroid/content/Intent;
    move-result-object v13
    const v14, 36001
    invoke-virtual v2, v13, v14, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent; I)V
    goto/16 +0a2h
    move-exception v0
    move-object v13, v0
    goto +5h
    move-exception v0
    goto -3h
    move-exception v0
    goto -5h
    invoke-static v2, v4, v5, Landroid/widget/Toast;->makeText(Landroid/content/Context; I I)Landroid/widget/Toast;
    move-result-object v14
    invoke-virtual v14, Landroid/widget/Toast;->show()V
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v14
    invoke-virtual v14, Lax/za/b;->f()Lax/za/b;
    move-result-object v14
    const-string v0, "PVI:"
    invoke-virtual v14, v0, Lax/za/b;->b(Ljava/lang/String;)Lax/za/b;
    move-result-object v14
    invoke-virtual v14, v13, Lax/za/b;->l(Ljava/lang/Throwable;)Lax/za/b;
    move-result-object v13
    invoke-virtual v13, Lax/za/b;->h()V
    goto/16 +07dh
    sget-object v13, Lcom/alphainventor/filemanager/viewer/b$d;->c0 Lcom/alphainventor/filemanager/viewer/b$d;
    if-ne v14, v13, +01dh
    invoke-virtual v12, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v13
    invoke-interface v13, Lcom/android/ex/photo/f$g;->k()Landroidx/fragment/app/Fragment;
    move-result-object v13
    instance-of v14, v13, Lax/X2/E;
    if-eqz v14, +06dh
    move-object v6, v13
    check-cast v6, Lax/X2/E;
    sget-object v7, Lax/T2/c$a;->c0 Lax/T2/c$a;
    invoke-interface v8, Lax/W2/b;->t()Ljava/lang/String;
    move-result-object v9
    const/4 v10, 0
    const/4 v11, 0
    invoke-virtual/range v6 ... v11, Lax/X2/E;->L2(Lax/T2/c$a; Lax/W2/i; Ljava/lang/String; Z Z)V
    goto +5dh
    invoke-virtual v12, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v13
    invoke-interface v13, Lcom/android/ex/photo/f$g;->k()Landroidx/fragment/app/Fragment;
    move-result-object v13
    instance-of v14, v13, Lax/X2/E;
    if-eqz v14, +052h
    move-object v6, v13
    check-cast v6, Lax/X2/E;
    sget-object v7, Lax/T2/c$a;->d0 Lax/T2/c$a;
    invoke-interface v8, Lax/W2/b;->t()Ljava/lang/String;
    move-result-object v9
    const/4 v10, 0
    const/4 v11, 0
    invoke-virtual/range v6 ... v11, Lax/X2/E;->L2(Lax/T2/c$a; Lax/W2/i; Ljava/lang/String; Z Z)V
    goto +42h
    new-instance v14, Ljava/lang/StringBuilder;
    invoke-direct v14, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "PLAY VIDEO:"
    invoke-virtual v14, v1, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v13, Landroid/net/Uri;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-virtual v14, v13, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v13, ",fileinfo:"
    invoke-virtual v14, v13, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v0, Lcom/alphainventor/filemanager/file/n;->T()Lax/W2/F;
    move-result-object v13
    invoke-virtual v14, v13, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    invoke-virtual v14, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v14
    invoke-virtual v14, Lax/za/b;->f()Lax/za/b;
    move-result-object v14
    const-string v0, "NOT REACHABLE : IMAGE VIEWER"
    invoke-virtual v14, v0, Lax/za/b;->b(Ljava/lang/String;)Lax/za/b;
    move-result-object v14
    invoke-virtual v14, Lax/za/b;->j()Lax/za/b;
    move-result-object v14
    invoke-virtual v14, v13, Lax/za/b;->g(Ljava/lang/Object;)Lax/za/b;
    move-result-object v13
    invoke-virtual v13, Lax/za/b;->h()V
    invoke-static v2, v4, v5, Landroid/widget/Toast;->makeText(Landroid/content/Context; I I)Landroid/widget/Toast;
    move-result-object v13
    invoke-virtual v13, Landroid/widget/Toast;->show()V
    return-void 
.end method

.method u(Lax/w3/a; Z)V
    .registers 4
    invoke-super v1, v2, v3, Lcom/android/ex/photo/f;->u(Lax/w3/a; Z)V
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b;->S0(Lax/w3/a;)V
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b;->M0(Lax/w3/a;)V
    if-nez v3, +030h
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b;->S0(Lax/w3/a;)V
    invoke-virtual v2, Lax/w3/a;->V2()Ljava/lang/String;
    move-result-object v3
    invoke-static v3, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v3
    invoke-virtual v1, v3, Lcom/alphainventor/filemanager/viewer/b;->l(Landroid/net/Uri;)Z
    move-result v0
    if-eqz v0, +01fh
    invoke-virtual v3, Landroid/net/Uri;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-direct v1, v3, Lcom/alphainventor/filemanager/viewer/b;->K0(Ljava/lang/String;)Lcom/alphainventor/filemanager/file/n;
    move-result-object v3
    if-eqz v3, +012h
    invoke-interface v3, Lax/W2/b;->o()Z
    move-result v3
    if-eqz v3, +00ch
    invoke-virtual v2, Lax/w3/a;->U2()Landroid/widget/TextView;
    move-result-object v2
    const/16 v3, 8
    invoke-virtual v2, v3, Landroid/view/View;->setVisibility(I)V
    return-void 
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b;->Q0(Lax/w3/a;)V
    return-void 
.end method

.method w(Lax/K0/c; Ljava/lang/Object;)V
    .registers 3
    check-cast v2, Landroid/database/Cursor;
    invoke-virtual v0, v1, v2, Lcom/alphainventor/filemanager/viewer/b;->k0(Lax/K0/c; Landroid/database/Cursor;)V
    return-void 
.end method

.method x(I Landroid/os/Bundle;)Lax/K0/c;
    .registers 4
    const/16 v0, 100
    if-ne v2, v0, +012h
    new-instance v2, Lcom/alphainventor/filemanager/viewer/b$c;
    invoke-virtual v1, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v3
    invoke-interface v3, Lcom/android/ex/photo/f$g;->b()Landroid/content/Context;
    move-result-object v3
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/b;->P Ljava/util/List;
    invoke-direct v2, v3, v0, Lcom/alphainventor/filemanager/viewer/b$c;-><init>(Landroid/content/Context; Ljava/util/List;)V
    return-object v2
    invoke-super v1, v2, v3, Lcom/android/ex/photo/f;->x(I Landroid/os/Bundle;)Lax/K0/c;
    move-result-object v2
    return-object v2
.end method

.method z(I Landroid/os/Bundle; Ljava/lang/String;)Lax/K0/c;
    .registers 12
    const/4 v0, 1
    if-eq v9, v0, +00dh
    const/4 v1, 2
    if-eq v9, v1, +00ch
    const/4 v1, 3
    if-eq v9, v1, +007h
    invoke-super v8, v9, v10, v11, Lcom/android/ex/photo/f;->z(I Landroid/os/Bundle; Ljava/lang/String;)Lax/K0/c;
    move-result-object v9
    return-object v9
    move-object v4, v11
    goto +15h
    new-instance v0, Lax/s3/e;
    invoke-virtual v8, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v9
    invoke-interface v9, Lcom/android/ex/photo/f$g;->b()Landroid/content/Context;
    move-result-object v1
    iget-object v2, v8, Lcom/alphainventor/filemanager/viewer/b;->R Lcom/alphainventor/filemanager/file/o;
    const/4 v5, 1
    const/4 v6, 0
    const/4 v3, 0
    move-object v4, v11
    invoke-direct/range v0 ... v6, Lax/s3/e;-><init>(Landroid/content/Context; Lcom/alphainventor/filemanager/file/o; Lcom/alphainventor/filemanager/file/n; Ljava/lang/String; Z Z)V
    return-object v0
    if-eqz v10, +00ah
    const-string v9, "use_factory_if_possible"
    invoke-virtual v10, v9, v0, Landroid/os/Bundle;->getBoolean(Ljava/lang/String; Z)Z
    move-result v0
    move v7, v0
    goto +2h
    const/4 v7, 1
    new-instance v1, Lax/s3/e;
    invoke-virtual v8, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v9
    invoke-interface v9, Lcom/android/ex/photo/f$g;->b()Landroid/content/Context;
    move-result-object v2
    iget-object v3, v8, Lcom/alphainventor/filemanager/viewer/b;->R Lcom/alphainventor/filemanager/file/o;
    move-object v5, v4
    invoke-direct v8, v5, Lcom/alphainventor/filemanager/viewer/b;->K0(Ljava/lang/String;)Lcom/alphainventor/filemanager/file/n;
    move-result-object v4
    const/4 v6, 0
    invoke-direct/range v1 ... v7, Lax/s3/e;-><init>(Landroid/content/Context; Lcom/alphainventor/filemanager/file/o; Lcom/alphainventor/filemanager/file/n; Ljava/lang/String; Z Z)V
    return-object v1
.end method
