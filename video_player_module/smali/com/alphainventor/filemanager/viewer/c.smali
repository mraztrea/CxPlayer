# Class: Lcom/alphainventor/filemanager/viewer/c;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/c;
.super Ljava/lang/Object;

# Fields
.field b:Lcom/alphainventor/filemanager/viewer/c;
.field a:Ljava/util/HashMap;

# Methods

.method <init>()V
    .registers 2
    invoke-direct v1, Ljava/lang/Object;-><init>()V
    new-instance v0, Ljava/util/HashMap;
    invoke-direct v0, Ljava/util/HashMap;-><init>()V
    iput-object v0, v1, Lcom/alphainventor/filemanager/viewer/c;->a Ljava/util/HashMap;
    return-void 
.end method

.method b()Lcom/alphainventor/filemanager/viewer/c;
    .registers 1
    sget-object v0, Lcom/alphainventor/filemanager/viewer/c;->b Lcom/alphainventor/filemanager/viewer/c;
    if-nez v0, +009h
    new-instance v0, Lcom/alphainventor/filemanager/viewer/c;
    invoke-direct v0, Lcom/alphainventor/filemanager/viewer/c;-><init>()V
    sput-object v0, Lcom/alphainventor/filemanager/viewer/c;->b Lcom/alphainventor/filemanager/viewer/c;
    sget-object v0, Lcom/alphainventor/filemanager/viewer/c;->b Lcom/alphainventor/filemanager/viewer/c;
    return-object v0
.end method

.method a(Ljava/lang/String;)Lcom/alphainventor/filemanager/viewer/c$a;
    .registers 3
    if-nez v2, +004h
    const/4 v2, 0
    return-object v2
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/c;->a Ljava/util/HashMap;
    invoke-virtual v0, v2, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/alphainventor/filemanager/viewer/c$a;
    return-object v2
.end method

.method c(Ljava/lang/String; Ljava/util/List; I)V
    .registers 6
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/c;->a Ljava/util/HashMap;
    new-instance v1, Lcom/alphainventor/filemanager/viewer/c$a;
    invoke-direct v1, v4, v5, Lcom/alphainventor/filemanager/viewer/c$a;-><init>(Ljava/util/List; I)V
    invoke-virtual v0, v3, v1, Ljava/util/HashMap;->put(Ljava/lang/Object; Ljava/lang/Object;)Ljava/lang/Object;
    return-void 
.end method
