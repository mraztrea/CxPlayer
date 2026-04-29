# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$l;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$l;
.super Ljava/lang/Object;

# Fields
.field a:Lcom/alphainventor/filemanager/viewer/d;
.field b:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lcom/alphainventor/filemanager/viewer/d;)V
    .registers 3
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$l;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    iput-object v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$l;->a Lcom/alphainventor/filemanager/viewer/d;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method onItemSelected(Landroid/widget/AdapterView; Landroid/view/View; I J)V
    .registers 6
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$l;->a Lcom/alphainventor/filemanager/viewer/d;
    invoke-interface v1, v3, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lcom/alphainventor/filemanager/viewer/d$a;
    if-eqz v1, +00ah
    iget-object v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$l;->b Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    iget v1, v1, Lcom/alphainventor/filemanager/viewer/d$a;->b F
    const/4 v3, 1
    invoke-static v2, v1, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->q0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; F Z)V
    return-void 
.end method

.method onNothingSelected(Landroid/widget/AdapterView;)V
    .registers 2
    return-void 
.end method
