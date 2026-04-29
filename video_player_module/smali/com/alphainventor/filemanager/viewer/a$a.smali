# Class: Lcom/alphainventor/filemanager/viewer/a$a;
# Superclass: Landroid/os/Handler;

.class Lcom/alphainventor/filemanager/viewer/a$a;
.super Landroid/os/Handler;

# Fields
.field a:Lcom/alphainventor/filemanager/viewer/a;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/a;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/a$a;->a Lcom/alphainventor/filemanager/viewer/a;
    invoke-direct v0, Landroid/os/Handler;-><init>()V
    return-void 
.end method

.method <init>(Lcom/alphainventor/filemanager/viewer/a; Landroid/os/Handler;)V
    .registers 3
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/a$a;->a Lcom/alphainventor/filemanager/viewer/a;
    invoke-virtual v2, Landroid/os/Handler;->getLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct v0, v1, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    return-void 
.end method

.method handleMessage(Landroid/os/Message;)V
    .registers 5
    iget v0, v4, Landroid/os/Message;->what I
    const/4 v1, 2
    if-ne v0, v1, +008h
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/a$a;->a Lcom/alphainventor/filemanager/viewer/a;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/a;->a(Lcom/alphainventor/filemanager/viewer/a;)V
    return-void 
    new-instance v0, Ljava/lang/RuntimeException;
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct v1, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "Unknown message "
    invoke-virtual v1, v2, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    invoke-virtual v1, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-direct v0, v4, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V
    throw v0
.end method
