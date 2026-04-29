# Class: Lcom/alphainventor/filemanager/viewer/f$f;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/f$f;
.super Ljava/lang/Object;

# Fields
.field a:Lax/P0/U$a;
.field b:I
.field c:Ljava/lang/String;

# Methods

.method <init>(Lax/P0/U; I I Ljava/lang/String;)V
    .registers 5
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    invoke-virtual v1, Lax/P0/U;->a()Lax/p7/z;
    move-result-object v1
    invoke-interface v1, v2, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lax/P0/U$a;
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/f$f;->a Lax/P0/U$a;
    iput v3, v0, Lcom/alphainventor/filemanager/viewer/f$f;->b I
    iput-object v4, v0, Lcom/alphainventor/filemanager/viewer/f$f;->c Ljava/lang/String;
    return-void 
.end method

.method a()Z
    .registers 3
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/f$f;->a Lax/P0/U$a;
    iget v1, v2, Lcom/alphainventor/filemanager/viewer/f$f;->b I
    invoke-virtual v0, v1, Lax/P0/U$a;->h(I)Z
    move-result v0
    return v0
.end method
