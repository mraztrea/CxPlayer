# Class: Lcom/alphainventor/filemanager/viewer/e;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/e;
.super Ljava/lang/Object;

# Fields
.field b:Lcom/alphainventor/filemanager/viewer/e;
.field a:Ljava/util/ArrayList;

# Methods

.method <init>()V
    .registers 1
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method b()Lcom/alphainventor/filemanager/viewer/e;
    .registers 1
    sget-object v0, Lcom/alphainventor/filemanager/viewer/e;->b Lcom/alphainventor/filemanager/viewer/e;
    if-nez v0, +009h
    new-instance v0, Lcom/alphainventor/filemanager/viewer/e;
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/e;-><init>()V
    sput-object v0, Lcom/alphainventor/filemanager/viewer/e;->b Lcom/alphainventor/filemanager/viewer/e;
    sget-object v0, Lcom/alphainventor/filemanager/viewer/e;->b Lcom/alphainventor/filemanager/viewer/e;
    return-object v0
.end method

.method a()V
    .registers 2
    const/4 v0, 0
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/e;->a Ljava/util/ArrayList;
    return-void 
.end method

.method c()Ljava/util/ArrayList;
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/e;->a Ljava/util/ArrayList;
    const/4 v1, 0
    iput-object v1, v2, Lcom/alphainventor/filemanager/viewer/e;->a Ljava/util/ArrayList;
    return-object v0
.end method

.method d(Ljava/util/ArrayList;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/e;->a Ljava/util/ArrayList;
    return-void 
.end method
