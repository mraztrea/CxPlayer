# Class: Lcom/alphainventor/filemanager/viewer/f$d;
# Superclass: Landroidx/recyclerview/widget/RecyclerView$F;

.class Lcom/alphainventor/filemanager/viewer/f$d;
.super Landroidx/recyclerview/widget/RecyclerView$F;

# Fields
.field u:Landroid/widget/TextView;
.field v:Landroid/view/View;

# Methods

.method <init>(Landroid/view/View;)V
    .registers 4
    invoke-direct v2, v3, Landroidx/recyclerview/widget/RecyclerView$F;-><init>(Landroid/view/View;)V
    sget v0, Lax/S0/c0;->a I
    const/16 v1, 26
    if-ge v0, v1, +006h
    const/4 v0, 1
    invoke-virtual v3, v0, Landroid/view/View;->setFocusable(Z)V
    const v0, 2131362239
    invoke-virtual v3, v0, Landroid/view/View;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/widget/TextView;
    iput-object v0, v2, Lcom/alphainventor/filemanager/viewer/f$d;->u Landroid/widget/TextView;
    const v0, 2131362200
    invoke-virtual v3, v0, Landroid/view/View;->findViewById(I)Landroid/view/View;
    move-result-object v3
    iput-object v3, v2, Lcom/alphainventor/filemanager/viewer/f$d;->v Landroid/view/View;
    return-void 
.end method
