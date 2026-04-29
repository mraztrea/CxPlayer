// Decompiled from: Lcom/alphainventor/filemanager/viewer/b$c;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public class b$c extends ax.K0.b {
    java.util.List w;

    public b$c(android.content.Context p1, java.util.List p2)
    {
        super(p1);
        java.util.ArrayList v1_2 = new java.util.ArrayList();
        super.w = v1_2;
        if (p2 != null) {
            v1_2.addAll(p2);
        }
        return;
    }

    public bridge synthetic Object I()
    {
        return this.M();
    }

    public android.database.Cursor M()
    {
        android.database.MatrixCursor v0_1 = new android.database.MatrixCursor(ax.y3.a.a);
        java.util.Iterator v1_2 = this.w.iterator();
        while (v1_2.hasNext()) {
            this.Q(v0_1, ((com.alphainventor.filemanager.file.n) v1_2.next()));
        }
        return v0_1;
    }

    void Q(android.database.MatrixCursor p7, com.alphainventor.filemanager.file.n p8)
    {
        int v0_1;
        if (!ax.W2.w.N(p8)) {
            v0_1 = ax.W2.w.W(p8);
        } else {
            v0_1 = ax.W2.w.U(p8);
        }
        if ((ax.W2.w.F(p8)) && (p8.p() < 50000)) {
            v0_1 = 0;
        }
        p7.newRow().add(p8.S()).add(p8.B()).add(p8.S()).add(v0_1).add(p8.t());
        return;
    }
}
