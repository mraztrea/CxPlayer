# Class: Lcom/alphainventor/filemanager/viewer/b$a;
# Superclass: Lax/c3/c;

.class Lcom/alphainventor/filemanager/viewer/b$a;
.super Lax/c3/c;

# Fields
.field c:Landroid/net/Uri;
.field d:Lcom/alphainventor/filemanager/viewer/b;

# Methods

.method <init>(Lcom/alphainventor/filemanager/viewer/b; Landroid/net/Uri;)V
    .registers 3
    iput-object v1, v0, Lcom/alphainventor/filemanager/viewer/b$a;->d Lcom/alphainventor/filemanager/viewer/b;
    iput-object v2, v0, Lcom/alphainventor/filemanager/viewer/b$a;->c Landroid/net/Uri;
    invoke-direct v0, Lax/c3/c;-><init>()V
    return-void 
.end method

.method a(Landroid/view/View;)V
    .registers 4
    iget-object v3, v2, Lcom/alphainventor/filemanager/viewer/b$a;->d Lcom/alphainventor/filemanager/viewer/b;
    iget-object v0, v2, Lcom/alphainventor/filemanager/viewer/b$a;->c Landroid/net/Uri;
    const/4 v1, 0
    invoke-virtual v3, v0, v1, Lcom/alphainventor/filemanager/viewer/b;->r(Landroid/net/Uri; Z)V
    return-void 
.end method
