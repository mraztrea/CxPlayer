# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$d;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$d;
.super Ljava/lang/Object;

# Fields
.field q:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$d;->q Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method run()V
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$d;->q Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/widget/TextView;
    move-result-object v0
    const-string v1, ""
    invoke-virtual v0, v1, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    return-void 
.end method
