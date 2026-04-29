// Decompiled from: Lcom/alphainventor/filemanager/viewer/a$a;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class a$a extends android.os.Handler {
    final synthetic com.alphainventor.filemanager.viewer.a a;

    a$a(com.alphainventor.filemanager.viewer.a p1)
    {
        this.a = p1;
        return;
    }

    a$a(com.alphainventor.filemanager.viewer.a p1, android.os.Handler p2)
    {
        this.a = p1;
        super(p2.getLooper());
        return;
    }

    public void handleMessage(android.os.Message p4)
    {
        if (p4.what != 2) {
            StringBuilder v1_2 = new StringBuilder();
            v1_2.append("Unknown message ");
            v1_2.append(p4);
            throw new RuntimeException(v1_2.toString());
        } else {
            com.alphainventor.filemanager.viewer.a.a(this.a);
            return;
        }
    }
}
