# Class: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;
# Superclass: Ljava/lang/Object;

.class Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;
.super Ljava/lang/Object;

# Fields
.field a:Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    .registers 2
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-direct v0, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.method <init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;)V
    .registers 3
    invoke-direct v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;-><init>(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method D(I)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->q(Lax/P0/H$d; I)V
    return-void 
.end method

.method E(Z)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->j(Lax/P0/H$d; Z)V
    return-void 
.end method

.method F(I)V
    .registers 3
    if-nez v2, +010h
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v2
    const/4 v0, 2
    if-ne v2, v0, +007h
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->l1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method H(Lax/P0/U;)V
    .registers 14
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->T0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Lcom/alphainventor/filemanager/viewer/f;
    move-result-object v0
    invoke-virtual v0, Lcom/alphainventor/filemanager/viewer/f;->q()V
    invoke-virtual v13, Lax/P0/U;->a()Lax/p7/z;
    move-result-object v13
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->U0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Lax/p7/z;
    move-result-object v0
    if-eq v13, v0, +178h
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v1, 0
    invoke-static v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->X0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)I
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Z0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)I
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->b1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Lax/g1/n;
    move-result-object v0
    invoke-virtual v0, Lax/g1/G;->o()Lax/g1/G$a;
    move-result-object v0
    if-eqz v0, +14dh
    const/4 v2, 2
    invoke-virtual v0, v2, Lax/g1/G$a;->i(I)I
    move-result v3
    const-string v4, ", container : "
    const-string v5, ",container : "
    const-string v6, "codec : "
    const/4 v7, 1
    if-ne v3, v7, +05dh
    iget-object v3, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const-string v8, "video"
    invoke-static v3, v13, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lax/p7/z; Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    iget-object v8, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Ljava/lang/String;
    move-result-object v8
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v9
    invoke-virtual v9, Lax/za/b;->f()Lax/za/b;
    move-result-object v9
    const-string v10, "video codec not available"
    invoke-virtual v9, v10, Lax/za/b;->b(Ljava/lang/String;)Lax/za/b;
    move-result-object v9
    new-instance v10, Ljava/lang/StringBuilder;
    invoke-direct v10, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v10, v6, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, v5, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, v8, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v10
    invoke-virtual v9, v10, Lax/za/b;->g(Ljava/lang/Object;)Lax/za/b;
    move-result-object v9
    invoke-virtual v9, Lax/za/b;->h()V
    invoke-static Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r0()Ljava/util/logging/Logger;
    move-result-object v9
    new-instance v10, Ljava/lang/StringBuilder;
    invoke-direct v10, Ljava/lang/StringBuilder;-><init>()V
    const-string v11, "video codec not available : "
    invoke-virtual v10, v11, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, v8, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v10, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v8
    invoke-virtual v9, v8, Ljava/util/logging/Logger;->severe(Ljava/lang/String;)V
    iget-object v8, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Ljava/lang/String;)V
    invoke-virtual v0, v7, Lax/g1/G$a;->i(I)I
    move-result v3
    const/4 v8, 3
    if-ne v3, v7, +05eh
    iget-object v3, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const-string v9, "audio"
    invoke-static v3, v13, v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->d1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lax/p7/z; Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    iget-object v9, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v9, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->e1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Ljava/lang/String;
    move-result-object v9
    invoke-static Lax/za/c;->h()Lax/za/b;
    move-result-object v10
    invoke-virtual v10, Lax/za/b;->f()Lax/za/b;
    move-result-object v10
    const-string v11, "audio codec not available"
    invoke-virtual v10, v11, Lax/za/b;->b(Ljava/lang/String;)Lax/za/b;
    move-result-object v10
    new-instance v11, Ljava/lang/StringBuilder;
    invoke-direct v11, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual v11, v6, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v11, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v11, v5, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v11, v9, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v11, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-virtual v10, v5, Lax/za/b;->g(Ljava/lang/Object;)Lax/za/b;
    move-result-object v5
    invoke-virtual v5, Lax/za/b;->h()V
    invoke-static Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r0()Ljava/util/logging/Logger;
    move-result-object v5
    new-instance v6, Ljava/lang/StringBuilder;
    invoke-direct v6, Ljava/lang/StringBuilder;-><init>()V
    const-string v10, "audio codec not available : "
    invoke-virtual v6, v10, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v6, v3, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v6, v4, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v6, v9, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v6, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-virtual v5, v4, Ljava/util/logging/Logger;->severe(Ljava/lang/String;)V
    iget-object v4, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->f1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Ljava/lang/String;)V
    goto +2eh
    if-ne v3, v8, +02dh
    const/4 v3, 0
    invoke-virtual v13, Ljava/util/AbstractCollection;->size()I
    move-result v4
    if-ge v3, v4, +026h
    invoke-interface v13, v3, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Lax/P0/U$a;
    invoke-virtual v4, Lax/P0/U$a;->d()I
    move-result v5
    if-eq v5, v7, +003h
    goto +15h
    const/4 v5, 0
    iget v6, v4, Lax/P0/U$a;->a I
    if-ge v5, v6, +011h
    invoke-virtual v4, v5, Lax/P0/U$a;->i(I)Z
    move-result v6
    if-nez v6, +003h
    goto +6h
    iget-object v6, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->a1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    add-int/lit8 v5, v5, 1
    goto -12h
    add-int/lit8 v3, v3, 1
    goto -29h
    invoke-virtual v0, v8, Lax/g1/G$a;->i(I)I
    move-result v0
    if-ne v0, v8, +048h
    const/4 v0, 0
    invoke-virtual v13, Ljava/util/AbstractCollection;->size()I
    move-result v3
    if-ge v0, v3, +03bh
    invoke-interface v13, v0, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Lax/P0/U$a;
    invoke-virtual v3, Lax/P0/U$a;->d()I
    move-result v4
    if-eq v4, v8, +003h
    goto +2ah
    const/4 v4, 0
    iget v5, v3, Lax/P0/U$a;->a I
    if-ge v4, v5, +026h
    invoke-virtual v3, v4, Lax/P0/U$a;->i(I)Z
    move-result v5
    if-nez v5, +003h
    goto +1bh
    invoke-virtual v3, v4, Lax/P0/U$a;->b(I)Lax/P0/v;
    move-result-object v5
    iget v5, v5, Lax/P0/v;->e I
    and-int/2addr v5, v2
    if-eqz v5, +003h
    goto +11h
    iget-object v5, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v5, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Y0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    invoke-virtual v3, Lax/P0/U$a;->f()Z
    move-result v5
    if-eqz v5, +007h
    iget-object v5, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v5, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->W0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    add-int/lit8 v4, v4, 1
    goto -27h
    add-int/lit8 v0, v0, 1
    goto -3eh
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    goto +ch
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    goto +6h
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->g1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    iget-object v0, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->V0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Lax/p7/z;)Lax/p7/z;
    iget-object v13, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v13, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->h1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v13, v12, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v13, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->i1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method I(Z)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->h(Lax/P0/H$d; Z)V
    return-void 
.end method

.method J(Lax/P0/F;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->s(Lax/P0/H$d; Lax/P0/F;)V
    return-void 
.end method

.method L(Lax/P0/F;)V
    .registers 3
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->P0(Lax/P0/F;)Z
    move-result v2
    if-eqz v2, +00dh
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->Q0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->R0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v0, 0
    invoke-static v2, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->S0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method M(I)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->p(Lax/P0/H$d; I)V
    return-void 
.end method

.method N(Lax/P0/M; I)V
    .registers 3
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method P(Z)V
    .registers 2
    iget-object v1, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method R(Lax/P0/S;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->C(Lax/P0/H$d; Lax/P0/S;)V
    return-void 
.end method

.method S(Lax/P0/H$b;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->b(Lax/P0/H$d; Lax/P0/H$b;)V
    return-void 
.end method

.method U(I Z)V
    .registers 3
    invoke-static v0, v1, v2, Lax/P0/I;->f(Lax/P0/H$d; I Z)V
    return-void 
.end method

.method V(Z I)V
    .registers 9
    invoke-static Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r0()Ljava/util/logging/Logger;
    move-result-object v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct v1, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "player state changed : "
    invoke-virtual v1, v2, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, v7, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    const-string v7, ","
    invoke-virtual v1, v7, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, v8, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual v1, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-virtual v0, v7, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V
    const/4 v7, 4
    const/4 v0, 1
    if-ne v8, v7, +024h
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v7
    if-eqz v7, +010h
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v7
    if-nez v7, +008h
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->p0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->u0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    goto/16 +0eeh
    const/4 v7, 3
    const/4 v1, 0
    if-ne v8, v7, +0ddh
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->s0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v7
    if-eqz v7, +024h
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v7
    if-nez v7, +01ch
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v7
    if-lez v7, +014h
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->w0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/os/Handler;
    move-result-object v7
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    iget-object v2, v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J1 Ljava/lang/Runnable;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->v0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v8
    int-to-long v3, v8
    invoke-virtual v7, v2, v3, v4, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable; J)Z
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->x0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/net/Uri;
    move-result-object v7
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->y0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v8
    if-nez v8, +068h
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/net/Uri;
    move-result-object v8
    if-eqz v8, +00eh
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->A0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroid/net/Uri;
    move-result-object v8
    invoke-virtual v8, v7, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z
    move-result v8
    if-nez v8, +054h
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->z0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)Z
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->B0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Landroid/net/Uri;)Landroid/net/Uri;
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->o1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/exoplayer/ExoPlayer;
    move-result-object v8
    invoke-interface v8, Lax/P0/H;->Y()J
    move-result-wide v2
    const-wide/16 v4, 0
    cmp-long v8, v2, v4
    if-gez v8, +004h
    const-wide/16 v2, -1
    if-eqz v7, +011h
    invoke-virtual v7, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v8
    if-eqz v8, +00bh
    invoke-virtual v7, Landroid/net/Uri;->getPath()Ljava/lang/String;
    move-result-object v7
    invoke-static v7, Lax/W2/Y;->k(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v7
    goto +3h
    const-string v7, "uri_error"
    invoke-static Lax/K2/a;->i()Lax/K2/a;
    move-result-object v8
    const-string v0, "video_player_ready"
    invoke-virtual v8, v0, Lax/K2/a;->o(Ljava/lang/String;)Lax/K2/a$d;
    move-result-object v8
    const-string v0, "duration_ms"
    invoke-virtual v8, v0, v2, v3, Lax/K2/a$d;->a(Ljava/lang/String; J)Lax/K2/a$d;
    move-result-object v8
    const-string v0, "duration_range"
    invoke-static v2, v3, Lax/K2/a$g;->a(J)Ljava/lang/String;
    move-result-object v2
    invoke-virtual v8, v0, v2, Lax/K2/a$d;->b(Ljava/lang/String; Ljava/lang/String;)Lax/K2/a$d;
    move-result-object v8
    const-string v0, "ext"
    invoke-virtual v8, v0, v7, Lax/K2/a$d;->b(Ljava/lang/String; Ljava/lang/String;)Lax/K2/a$d;
    move-result-object v7
    invoke-virtual v7, Lax/K2/a$d;->c()V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->E0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Z
    move-result v7
    if-eqz v7, +013h
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const v8, 2131100857
    invoke-static v7, v8, Lax/Q/b;->c(Landroid/content/Context; I)I
    move-result v7
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const-wide/16 v0, 150
    invoke-static v8, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; J)J
    goto +11h
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const v8, 2131100856
    invoke-static v7, v8, Lax/Q/b;->c(Landroid/content/Context; I)I
    move-result v7
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const-wide/16 v0, 300
    invoke-static v8, v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->F0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; J)J
    iget-object v8, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v8, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->G0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)Landroidx/media3/ui/b;
    move-result-object v8
    invoke-virtual v8, v7, Landroidx/media3/ui/b;->setBufferedColor(I)V
    goto +eh
    const/4 v7, 2
    if-ne v8, v7, +00ch
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->C0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->t0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->O0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->H0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->I0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->J0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v7, v6, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v7, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->L0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method Y(Lax/P0/y; I)V
    .registers 3
    invoke-static v0, v1, v2, Lax/P0/I;->k(Lax/P0/H$d; Lax/P0/y; I)V
    return-void 
.end method

.method a(Lax/P0/Z;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->E(Lax/P0/H$d; Lax/P0/Z;)V
    return-void 
.end method

.method a0()V
    .registers 1
    invoke-static v0, Lax/P0/I;->w(Lax/P0/H$d;)V
    return-void 
.end method

.method b(I)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->a(Lax/P0/H$d; I)V
    return-void 
.end method

.method c0(Lax/P0/H; Lax/P0/H$c;)V
    .registers 3
    invoke-static v0, v1, v2, Lax/P0/I;->g(Lax/P0/H$d; Lax/P0/H; Lax/P0/H$c;)V
    return-void 
.end method

.method f(Z)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->z(Lax/P0/H$d; Z)V
    return-void 
.end method

.method g0(Z I)V
    .registers 3
    invoke-static v0, v1, v2, Lax/P0/I;->n(Lax/P0/H$d; Z I)V
    return-void 
.end method

.method h0(Lax/P0/A;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->l(Lax/P0/H$d; Lax/P0/A;)V
    return-void 
.end method

.method i0(Lax/P0/n;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->e(Lax/P0/H$d; Lax/P0/n;)V
    return-void 
.end method

.method j(Lax/P0/G;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->o(Lax/P0/H$d; Lax/P0/G;)V
    return-void 
.end method

.method l0(I I)V
    .registers 3
    invoke-static v0, v1, v2, Lax/P0/I;->A(Lax/P0/H$d; I I)V
    return-void 
.end method

.method m0(Lax/P0/H$e; Lax/P0/H$e; I)V
    .registers 4
    invoke-static v0, v1, v2, v3, Lax/P0/I;->v(Lax/P0/H$d; Lax/P0/H$e; Lax/P0/H$e; I)V
    return-void 
.end method

.method q0(Z)V
    .registers 5
    invoke-static Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->r0()Ljava/util/logging/Logger;
    move-result-object v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct v1, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "VideoPlayer : isPlaying="
    invoke-virtual v1, v2, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual v1, v4, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    invoke-virtual v1, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-virtual v0, v1, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V
    if-eqz v4, +00eh
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v0, 1
    invoke-static v4, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v4, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->N0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
    iget-object v4, v3, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    const/4 v0, 0
    invoke-static v4, v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->M0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; Z)V
    return-void 
.end method

.method s(Lax/P0/C;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->m(Lax/P0/H$d; Lax/P0/C;)V
    return-void 
.end method

.method t(Lax/R0/c;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->c(Lax/P0/H$d; Lax/R0/c;)V
    return-void 
.end method

.method u(I)V
    .registers 3
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->j1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)I
    move-result v0
    if-eq v0, v2, +007h
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, v2, Lax/p3/m;->j(Landroid/content/Context; I)V
    iget-object v0, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v0, v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->k1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity; I)I
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->m1(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;->a Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;->K0(Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;)V
    return-void 
.end method

.method v(Ljava/util/List;)V
    .registers 2
    invoke-static v0, v1, Lax/P0/I;->d(Lax/P0/H$d; Ljava/util/List;)V
    return-void 
.end method
