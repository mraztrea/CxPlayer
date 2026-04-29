# Class: Lcom/alphainventor/filemanager/viewer/b$b;
# Superclass: Lax/q3/q;

.class Lcom/alphainventor/filemanager/viewer/b$b;
.super Lax/q3/q;

# Fields
.field h:I
.field i:Lcom/alphainventor/filemanager/viewer/b;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/b; I)V
    .registers 3
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/b$b;->i Lcom/alphainventor/filemanager/viewer/b;
    sget-object v1, Lax/q3/q$e;->e0 Lax/q3/q$e;
    invoke-direct v0, v1, Lax/q3/q;-><init>(Lax/q3/q$e;)V
    iput v2, v0, Lcom/alphainventor/filemanager/viewer/b$b;->h I
    return-void 
.end method

.method w(I)V
    .registers 4
    invoke-virtual v2, Lax/q3/q;->isCancelled()Z
    move-result v0
    if-eqz v0, +003h
    goto +40h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/b$b;->i Lcom/alphainventor/filemanager/viewer/b;
    invoke-static v0, v3, Lcom/alphainventor/filemanager/viewer/b;->G0(Lcom/alphainventor/filemanager/viewer/b; I)Z
    move-result v0
    if-eqz v0, +039h
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/b$b;->i Lcom/alphainventor/filemanager/viewer/b;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/b;->H0(Lcom/alphainventor/filemanager/viewer/b;)Ljava/util/List;
    move-result-object v0
    invoke-interface v0, v3, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Lcom/alphainventor/filemanager/file/n;
    invoke-static v3, Lax/W2/w;->N(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v0
    if-nez v0, +00ah
    invoke-virtual v3, Lcom/alphainventor/filemanager/file/n;->R()Lax/K2/f;
    move-result-object v0
    sget-object v1, Lax/K2/f;->b1 Lax/K2/f;
    if-ne v0, v1, +01fh
    invoke-static v3, Lax/W2/w;->W(Lcom/alphainventor/filemanager/file/n;)Ljava/lang/String;
    move-result-object v0
    iget-object v1, v2, Lcom/alphainventor/filemanager/viewer/b$b;->i Lcom/alphainventor/filemanager/viewer/b;
    invoke-virtual v1, Lcom/android/ex/photo/f;->O()Lcom/android/ex/photo/f$g;
    move-result-object v1
    invoke-interface v1, Lcom/android/ex/photo/f$g;->b()Landroid/content/Context;
    move-result-object v1
    invoke-static v1, v0, Lax/n3/d;->l(Landroid/content/Context; Ljava/lang/String;)Ljava/io/File;
    move-result-object v0
    if-nez v0, +00bh
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/b$b;->i Lcom/alphainventor/filemanager/viewer/b;
    invoke-static v0, Lcom/alphainventor/filemanager/viewer/b;->I0(Lcom/alphainventor/filemanager/viewer/b;)Lax/n3/d;
    move-result-object v0
    invoke-virtual v0, v3, Lax/n3/d;->t(Lcom/alphainventor/filemanager/file/n;)V
    return-void 
.end method

.method g([Ljava/lang/Object;)Ljava/lang/Object;
    .registers 2
    check-cast v1, [Ljava/lang/Void;
    invoke-virtual v0, v1, Lcom/alphainventor/filemanager/viewer/b$b;->x([Ljava/lang/Void;)Ljava/lang/Void;
    move-result-object v1
    return-object v1
.end method

.method x([Ljava/lang/Void;)Ljava/lang/Void;
    .registers 3
    iget-object v2, v1, Lcom/alphainventor/filemanager/viewer/b$b;->i Lcom/alphainventor/filemanager/viewer/b;
    invoke-static v2, Lcom/alphainventor/filemanager/viewer/b;->F0(Lcom/alphainventor/filemanager/viewer/b;)Z
    move-result v2
    const/4 v0, 0
    if-eqz v2, +003h
    return-object v0
    iget v2, v1, Lcom/alphainventor/filemanager/viewer/b$b;->h I
    add-int/lit8 v2, v2, -1
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b$b;->w(I)V
    iget v2, v1, Lcom/alphainventor/filemanager/viewer/b$b;->h I
    add-int/lit8 v2, v2, 1
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b$b;->w(I)V
    iget v2, v1, Lcom/alphainventor/filemanager/viewer/b$b;->h I
    add-int/lit8 v2, v2, -2
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b$b;->w(I)V
    iget v2, v1, Lcom/alphainventor/filemanager/viewer/b$b;->h I
    add-int/lit8 v2, v2, 2
    invoke-direct v1, v2, Lcom/alphainventor/filemanager/viewer/b$b;->w(I)V
    return-object v0
.end method
