# Class: Lcom/alphainventor/filemanager/viewer/b$d;
# Superclass: Ljava/lang/Enum;

.class Lcom/alphainventor/filemanager/viewer/b$d;
.super Ljava/lang/Enum;

# Fields
.field c0:Lcom/alphainventor/filemanager/viewer/b$d;
.field d0:Lcom/alphainventor/filemanager/viewer/b$d;
.field e0:[Lcom/alphainventor/filemanager/viewer/b$d;
.field q:Lcom/alphainventor/filemanager/viewer/b$d;

# Methods

.method <clinit>()V
    .registers 3
    new-instance v0, Lcom/alphainventor/filemanager/viewer/b$d;
    const-string v1, "BUILT_IN"
    const/4 v2, 0
    invoke-direct v0, v1, v2, Lcom/alphainventor/filemanager/viewer/b$d;-><init>(Ljava/lang/String; I)V
    sput-object v0, Lcom/alphainventor/filemanager/viewer/b$d;->q Lcom/alphainventor/filemanager/viewer/b$d;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/b$d;
    const-string v1, "GENERAL"
    const/4 v2, 1
    invoke-direct v0, v1, v2, Lcom/alphainventor/filemanager/viewer/b$d;-><init>(Ljava/lang/String; I)V
    sput-object v0, Lcom/alphainventor/filemanager/viewer/b$d;->c0 Lcom/alphainventor/filemanager/viewer/b$d;
    new-instance v0, Lcom/alphainventor/filemanager/viewer/b$d;
    const-string v1, "IN_IMAGE_VIEWER"
    const/4 v2, 2
    invoke-direct v0, v1, v2, Lcom/alphainventor/filemanager/viewer/b$d;-><init>(Ljava/lang/String; I)V
    sput-object v0, Lcom/alphainventor/filemanager/viewer/b$d;->d0 Lcom/alphainventor/filemanager/viewer/b$d;
    invoke-static Lcom/alphainventor/filemanager/viewer/b$d;->d()[Lcom/alphainventor/filemanager/viewer/b$d;
    move-result-object v0
    sput-object v0, Lcom/alphainventor/filemanager/viewer/b$d;->e0 [Lcom/alphainventor/filemanager/viewer/b$d;
    return-void 
.end method

.method <init>(Ljava/lang/String; I)V
    .registers 3
    invoke-direct v0, v1, v2, Ljava/lang/Enum;-><init>(Ljava/lang/String; I)V
    return-void 
.end method

.method d()[Lcom/alphainventor/filemanager/viewer/b$d;
    .registers 3
    const/4 v0, 3
    new-array v0, v0, [Lcom/alphainventor/filemanager/viewer/b$d;
    sget-object v1, Lcom/alphainventor/filemanager/viewer/b$d;->q Lcom/alphainventor/filemanager/viewer/b$d;
    const/4 v2, 0
    aput-object v1, v0, v2
    sget-object v1, Lcom/alphainventor/filemanager/viewer/b$d;->c0 Lcom/alphainventor/filemanager/viewer/b$d;
    const/4 v2, 1
    aput-object v1, v0, v2
    sget-object v1, Lcom/alphainventor/filemanager/viewer/b$d;->d0 Lcom/alphainventor/filemanager/viewer/b$d;
    const/4 v2, 2
    aput-object v1, v0, v2
    return-object v0
.end method

.method valueOf(Ljava/lang/String;)Lcom/alphainventor/filemanager/viewer/b$d;
    .registers 2
    const-class v0, Lcom/alphainventor/filemanager/viewer/b$d;
    invoke-static v0, v1, Ljava/lang/Enum;->valueOf(Ljava/lang/Class; Ljava/lang/String;)Ljava/lang/Enum;
    move-result-object v1
    check-cast v1, Lcom/alphainventor/filemanager/viewer/b$d;
    return-object v1
.end method

.method values()[Lcom/alphainventor/filemanager/viewer/b$d;
    .registers 1
    sget-object v0, Lcom/alphainventor/filemanager/viewer/b$d;->e0 [Lcom/alphainventor/filemanager/viewer/b$d;
    invoke-virtual v0, [Lcom/alphainventor/filemanager/viewer/b$d;->clone()Ljava/lang/Object;
    move-result-object v0
    check-cast v0, [Lcom/alphainventor/filemanager/viewer/b$d;
    return-object v0
.end method
