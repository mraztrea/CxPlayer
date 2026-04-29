// Decompiled from: Lcom/alphainventor/filemanager/viewer/f$g;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public abstract class f$g extends androidx.recyclerview.widget.RecyclerView$h {
    protected java.util.List d;
    protected android.content.Context e;
    protected com.alphainventor.filemanager.viewer.f$c f;
    final synthetic com.alphainventor.filemanager.viewer.f g;

    protected f$g(com.alphainventor.filemanager.viewer.f p1, android.content.Context p2, com.alphainventor.filemanager.viewer.f$c p3)
    {
        this.g = p1;
        this.d = new java.util.ArrayList();
        this.e = p2;
        this.f = p3;
        return;
    }

    public static synthetic void N(com.alphainventor.filemanager.viewer.f$g p0, ax.P0.H p1, com.alphainventor.filemanager.viewer.f$f p2, android.view.View p3)
    {
        com.alphainventor.filemanager.viewer.f.a(p0.g, p1, p2);
        p0.T(p2.c);
        com.alphainventor.filemanager.viewer.f.b(p0.g).dismiss();
        return;
    }

    public bridge synthetic void B(androidx.recyclerview.widget.RecyclerView$F p1, int p2)
    {
        this.Q(((com.alphainventor.filemanager.viewer.f$d) p1), p2);
        return;
    }

    public bridge synthetic androidx.recyclerview.widget.RecyclerView$F D(android.view.ViewGroup p1, int p2)
    {
        return this.S(p1, p2);
    }

    protected void O()
    {
        this.d = java.util.Collections.EMPTY_LIST;
        return;
    }

    protected android.content.Context P()
    {
        return this.e;
    }

    public void Q(com.alphainventor.filemanager.viewer.f$d p6, int p7)
    {
        ax.P0.H v0_1 = this.g.h();
        if (v0_1 != null) {
            if (p7 != null) {
                int v2 = 1;
                com.alphainventor.filemanager.viewer.f$f v7_1 = ((com.alphainventor.filemanager.viewer.f$f) this.d.get((p7 - 1)));
                int v3_2 = 0;
                if ((v0_1.c0().D.get(v7_1.a.a()) == null) || (!v7_1.a())) {
                    v2 = 0;
                }
                p6.u.setText(v7_1.c);
                if (v2 == 0) {
                    v3_2 = 4;
                }
                p6.v.setVisibility(v3_2);
                p6.a.setOnClickListener(new ax.s3.i(this, v0_1, v7_1));
                return;
            } else {
                this.R(p6);
                return;
            }
        } else {
            return;
        }
    }

    protected abstract void R();

    public com.alphainventor.filemanager.viewer.f$d S(android.view.ViewGroup p3, int p4)
    {
        return new com.alphainventor.filemanager.viewer.f$d(android.view.LayoutInflater.from(this.P()).inflate(2131558533, p3, 0));
    }

    protected abstract void T();

    public int l()
    {
        if (!this.d.isEmpty()) {
            return (this.d.size() + 1);
        } else {
            return 0;
        }
    }
}
