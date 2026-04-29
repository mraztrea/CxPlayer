# Class: Lcom/alphainventor/filemanager/viewer/b$c;
# Superclass: Lax/K0/b;

.class Lcom/alphainventor/filemanager/viewer/b$c;
.super Lax/K0/b;

# Fields
.field w:Ljava/util/List;

# Methods

.method <init>(Landroid/content/Context; Ljava/util/List;)V
    .registers 3
    invoke-direct v0, v1, Lax/K0/b;-><init>(Landroid/content/Context;)V
    new-instance v1, Ljava/util/ArrayList;
    invoke-direct v1, Ljava/util/ArrayList;-><init>()V
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/b$c;->w Ljava/util/List;
    if-eqz v2, +005h
    invoke-interface v1, v2, Ljava/util/List;->addAll(Ljava/util/Collection;)Z
    return-void 
.end method

.method I()Ljava/lang/Object;
    .registers 2
    invoke-virtual v1, Lcom/alphainventor/filemanager/viewer/b$c;->M()Landroid/database/Cursor;
    move-result-object v0
    return-object v0
.end method

.method M()Landroid/database/Cursor;
    .registers 4
    new-instance v0, Landroid/database/MatrixCursor;
    sget-object v1, Lax/y3/a;->a [Ljava/lang/String;
    invoke-direct v0, v1, Landroid/database/MatrixCursor;-><init>([Ljava/lang/String;)V
    iget-object v1, v3, Lcom/alphainventor/filemanager/viewer/b$c;->w Ljava/util/List;
    invoke-interface v1, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    invoke-interface v1, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, +00ch
    invoke-interface v1, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/alphainventor/filemanager/file/n;
    invoke-virtual v3, v0, v2, Lcom/alphainventor/filemanager/viewer/b$c;->Q(Landroid/database/MatrixCursor; Lcom/alphainventor/filemanager/file/n;)V
    goto -fh
    return-object v0
.end method

.method Q(Landroid/database/MatrixCursor; Lcom/alphainventor/filemanager/file/n;)V
    .registers 9
    invoke-static v8, Lax/W2/w;->N(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v0
    if-eqz v0, +007h
    invoke-static v8, Lax/W2/w;->U(Lcom/alphainventor/filemanager/file/n;)Ljava/lang/String;
    move-result-object v0
    goto +5h
    invoke-static v8, Lax/W2/w;->W(Lcom/alphainventor/filemanager/file/n;)Ljava/lang/String;
    move-result-object v0
    invoke-static v8, Lax/W2/w;->F(Lcom/alphainventor/filemanager/file/n;)Z
    move-result v1
    if-eqz v1, +00eh
    invoke-interface v8, Lax/W2/b;->p()J
    move-result-wide v1
    const-wide/32 v3, 50000
    cmp-long v5, v1, v3
    if-gez v5, +003h
    const/4 v0, 0
    invoke-virtual v7, Landroid/database/MatrixCursor;->newRow()Landroid/database/MatrixCursor$RowBuilder;
    move-result-object v7
    invoke-virtual v8, Lcom/alphainventor/filemanager/file/n;->S()Ljava/lang/String;
    move-result-object v1
    invoke-virtual v7, v1, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;
    move-result-object v7
    invoke-virtual v8, Lcom/alphainventor/filemanager/file/n;->B()Ljava/lang/String;
    move-result-object v1
    invoke-virtual v7, v1, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;
    move-result-object v7
    invoke-virtual v8, Lcom/alphainventor/filemanager/file/n;->S()Ljava/lang/String;
    move-result-object v1
    invoke-virtual v7, v1, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;
    move-result-object v7
    invoke-virtual v7, v0, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;
    move-result-object v7
    invoke-interface v8, Lax/W2/b;->t()Ljava/lang/String;
    move-result-object v8
    invoke-virtual v7, v8, Landroid/database/MatrixCursor$RowBuilder;->add(Ljava/lang/Object;)Landroid/database/MatrixCursor$RowBuilder;
    return-void 
.end method
