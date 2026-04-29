# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$u;
# Superclass: Lax/g1/n;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$u;
.super Lax/g1/n;

# Fields
.field m:Ljava/lang/String;

# Methods

.method <init>(Landroid/content/Context; Lax/g1/D$b; Ljava/lang/String;)V
    .registers 4
    invoke-static v1, Lax/g1/n$e;->R(Landroid/content/Context;)Lax/g1/n$e;
    move-result-object v1
    invoke-direct v0, v1, v2, Lax/g1/n;-><init>(Lax/P0/S; Lax/g1/D$b;)V
    iput-object v3, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$u;->m Ljava/lang/String;
    return-void 
.end method

.method g0(Lax/P0/v; Ljava/lang/String;)Z
    .registers 3
    const/4 v0, 0
    invoke-static v1, v2, v0, Lax/g1/n;->I(Lax/P0/v; Ljava/lang/String; Z)I
    move-result v1
    if-lez v1, +004h
    const/4 v1, 1
    return v1
    return v0
.end method

.method c0(Lax/g1/G$a; [[[I Lax/g1/n$e; Ljava/lang/String;)Landroid/util/Pair;
    .registers 8
    invoke-super v3, v4, v5, v6, v7, Lax/g1/n;->c0(Lax/g1/G$a; [[[I Lax/g1/n$e; Ljava/lang/String;)Landroid/util/Pair;
    move-result-object v4
    invoke-static Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q()Z
    move-result v5
    const/4 v6, 0
    if-nez v5, +02eh
    if-eqz v4, +033h
    iget-object v5, v4, Landroid/util/Pair;->first Ljava/lang/Object;
    check-cast v5, Lax/g1/D$a;
    iget-object v5, v5, Lax/g1/D$a;->a Lax/P0/O;
    iget-object v7, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$u;->m Ljava/lang/String;
    invoke-static v7, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z
    move-result v7
    const/4 v0, 0
    if-nez v7, +01ah
    if-eqz v5, +018h
    const/4 v7, 0
    iget v1, v5, Lax/P0/O;->a I
    if-ge v0, v1, +012h
    invoke-virtual v5, v0, Lax/P0/O;->b(I)Lax/P0/v;
    move-result-object v1
    iget-object v2, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$u;->m Ljava/lang/String;
    invoke-static v1, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$u;->g0(Lax/P0/v; Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, +003h
    const/4 v7, 1
    add-int/lit8 v0, v0, 1
    goto -13h
    move v0, v7
    if-nez v0, +00ah
    return-object v6
    invoke-static Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S()Z
    move-result v5
    if-eqz v5, +003h
    return-object v6
    return-object v4
.end method
