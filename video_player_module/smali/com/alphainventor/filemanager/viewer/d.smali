# Class: Lcom/alphainventor/filemanager/viewer/d;
# Superclass: Landroid/widget/ArrayAdapter;

.class Lcom/alphainventor/filemanager/viewer/d;
.super Landroid/widget/ArrayAdapter;

# Fields
.field b:Ljava/util/List;
.field a:Landroid/view/LayoutInflater;

# Methods

.method <init>(Landroid/content/Context;)V
    .registers 4
    const/4 v0, 0
    invoke-static Lcom/alphainventor/filemanager/viewer/d;->b()Ljava/util/List;
    move-result-object v1
    invoke-direct v2, v3, v0, v1, Landroid/widget/ArrayAdapter;-><init>(Landroid/content/Context; I Ljava/util/List;)V
    invoke-virtual v2, Landroid/widget/ArrayAdapter;->getContext()Landroid/content/Context;
    move-result-object v3
    invoke-static v3, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;
    move-result-object v3
    iput-object v3, v2, Lcom/alphainventor/filemanager/viewer/d;->a Landroid/view/LayoutInflater;
    return-void 
.end method

.method b()Ljava/util/List;
    .registers 4
    sget-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    if-nez v0, +077h
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct v0, Ljava/util/ArrayList;-><init>()V
    sput-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/d$a;
    const-string v2, "0.25X"
    const/high16 v3, 1048576000
    invoke-direct v1, v2, v3, Lcom/alphainventor/filemanager/viewer/d$a;-><init>(Ljava/lang/String; F)V
    invoke-interface v0, v1, Ljava/util/List;->add(Ljava/lang/Object;)Z
    sget-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/d$a;
    const-string v2, "0.5X"
    const/high16 v3, 1056964608
    invoke-direct v1, v2, v3, Lcom/alphainventor/filemanager/viewer/d$a;-><init>(Ljava/lang/String; F)V
    invoke-interface v0, v1, Ljava/util/List;->add(Ljava/lang/Object;)Z
    sget-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/d$a;
    const-string v2, "0.75X"
    const/high16 v3, 1061158912
    invoke-direct v1, v2, v3, Lcom/alphainventor/filemanager/viewer/d$a;-><init>(Ljava/lang/String; F)V
    invoke-interface v0, v1, Ljava/util/List;->add(Ljava/lang/Object;)Z
    sget-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/d$a;
    const-string v2, "1X"
    const/high16 v3, 1065353216
    invoke-direct v1, v2, v3, Lcom/alphainventor/filemanager/viewer/d$a;-><init>(Ljava/lang/String; F)V
    invoke-interface v0, v1, Ljava/util/List;->add(Ljava/lang/Object;)Z
    sget-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/d$a;
    const-string v2, "1.25X"
    const/high16 v3, 1067450368
    invoke-direct v1, v2, v3, Lcom/alphainventor/filemanager/viewer/d$a;-><init>(Ljava/lang/String; F)V
    invoke-interface v0, v1, Ljava/util/List;->add(Ljava/lang/Object;)Z
    sget-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/d$a;
    const-string v2, "1.5X"
    const/high16 v3, 1069547520
    invoke-direct v1, v2, v3, Lcom/alphainventor/filemanager/viewer/d$a;-><init>(Ljava/lang/String; F)V
    invoke-interface v0, v1, Ljava/util/List;->add(Ljava/lang/Object;)Z
    sget-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/d$a;
    const-string v2, "1.75X"
    const/high16 v3, 1071644672
    invoke-direct v1, v2, v3, Lcom/alphainventor/filemanager/viewer/d$a;-><init>(Ljava/lang/String; F)V
    invoke-interface v0, v1, Ljava/util/List;->add(Ljava/lang/Object;)Z
    sget-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/d$a;
    const-string v2, "2X"
    const/high16 v3, 1073741824
    invoke-direct v1, v2, v3, Lcom/alphainventor/filemanager/viewer/d$a;-><init>(Ljava/lang/String; F)V
    invoke-interface v0, v1, Ljava/util/List;->add(Ljava/lang/Object;)Z
    sget-object v0, Lcom/alphainventor/filemanager/viewer/d;->b Ljava/util/List;
    return-object v0
.end method

.method c(F)I
    .registers 4
    invoke-static Lcom/alphainventor/filemanager/viewer/d;->b()Ljava/util/List;
    move-result-object v0
    const/4 v1, 0
    invoke-interface v0, Ljava/util/List;->size()I
    move-result v2
    if-ge v1, v2, +012h
    invoke-interface v0, v1, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/alphainventor/filemanager/viewer/d$a;
    iget v2, v2, Lcom/alphainventor/filemanager/viewer/d$a;->b F
    cmpl-float v2, v2, v3
    if-nez v2, +003h
    return v1
    add-int/lit8 v1, v1, 1
    goto -15h
    invoke-static Lax/q3/b;->f()V
    const/high16 v3, 1065353216
    invoke-static v3, Lcom/alphainventor/filemanager/viewer/d;->c(F)I
    move-result v3
    return v3
.end method

.method a(I Landroid/view/View; Landroid/view/ViewGroup; I)Landroid/view/View;
    .registers 6
    if-nez v3, +009h
    iget-object v3, v1, Lcom/alphainventor/filemanager/viewer/d;->a Landroid/view/LayoutInflater;
    const/4 v0, 0
    invoke-virtual v3, v5, v4, v0, Landroid/view/LayoutInflater;->inflate(I Landroid/view/ViewGroup; Z)Landroid/view/View;
    move-result-object v3
    invoke-interface v1, v2, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/alphainventor/filemanager/viewer/d$a;
    move-object v4, v3
    check-cast v4, Landroid/widget/TextView;
    iget-object v2, v2, Lcom/alphainventor/filemanager/viewer/d$a;->a Ljava/lang/String;
    invoke-virtual v4, v2, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    return-object v3
.end method

.method getDropDownView(I Landroid/view/View; Landroid/view/ViewGroup;)Landroid/view/View;
    .registers 5
    const v0, 2131558582
    invoke-virtual v1, v2, v3, v4, v0, Lcom/alphainventor/filemanager/viewer/d;->a(I Landroid/view/View; Landroid/view/ViewGroup; I)Landroid/view/View;
    move-result-object v2
    return-object v2
.end method

.method getView(I Landroid/view/View; Landroid/view/ViewGroup;)Landroid/view/View;
    .registers 5
    const v0, 2131558581
    invoke-virtual v1, v2, v3, v4, v0, Lcom/alphainventor/filemanager/viewer/d;->a(I Landroid/view/View; Landroid/view/ViewGroup; I)Landroid/view/View;
    move-result-object v2
    return-object v2
.end method
