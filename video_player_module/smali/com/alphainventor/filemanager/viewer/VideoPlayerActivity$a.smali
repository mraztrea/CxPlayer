# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$a;
# Superclass: Lax/c3/c;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$a;
.super Lax/c3/c;

# Fields
.field c:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$a;->c Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Lax/c3/c;-><init>()V
    return-void 
.end method

.method a(Landroid/view/View;)V
    .registers 3
    new-instance v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$a;->c Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    const/4 v0, 0
    new-array v0, v0, [Ljava/lang/Void;
    invoke-virtual v2, v0, Lax/q3/q;->i([Ljava/lang/Object;)Lax/q3/q;
    return-void 
.end method
