// Decompiled from: Lcom/alphainventor/filemanager/viewer/b$b;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class b$b extends ax.q3.q {
    int h;
    final synthetic com.alphainventor.filemanager.viewer.b i;

    b$b(com.alphainventor.filemanager.viewer.b p1, int p2)
    {
        this.i = p1;
        super(ax.q3.q$e.e0);
        super.h = p2;
        return;
    }

    private void w(int p3)
    {
        if ((!this.isCancelled()) && (com.alphainventor.filemanager.viewer.b.G0(this.i, p3))) {
            com.alphainventor.filemanager.file.n v3_2 = ((com.alphainventor.filemanager.file.n) com.alphainventor.filemanager.viewer.b.H0(this.i).get(p3));
            if (((ax.W2.w.N(v3_2)) || (v3_2.R() == ax.K2.f.b1)) && (ax.n3.d.l(this.i.O().b(), ax.W2.w.W(v3_2)) == null)) {
                com.alphainventor.filemanager.viewer.b.I0(this.i).t(v3_2);
            }
        }
        return;
    }

    protected bridge synthetic Object g(Object[] p1)
    {
        return this.x(((Void[]) p1));
    }

    protected varargs Void x(Void[] p2)
    {
        if (!com.alphainventor.filemanager.viewer.b.F0(this.i)) {
            this.w((this.h - 1));
            this.w((this.h + 1));
            this.w((this.h - 2));
            this.w((this.h + 2));
            return 0;
        } else {
            return 0;
        }
    }
}
