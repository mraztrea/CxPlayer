// Decompiled from: Lcom/alphainventor/filemanager/viewer/f$e;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public final class f$e extends com.alphainventor.filemanager.viewer.f$g {
    final synthetic com.alphainventor.filemanager.viewer.f h;

    public f$e(com.alphainventor.filemanager.viewer.f p1, android.content.Context p2, com.alphainventor.filemanager.viewer.f$c p3)
    {
        this.h = p1;
        super(p1, p2, p3);
        return;
    }

    public static synthetic void U(com.alphainventor.filemanager.viewer.f$e p1, android.view.View p2)
    {
        p1.h.l();
        if (com.alphainventor.filemanager.viewer.f.c(p1.h) != null) {
            com.alphainventor.filemanager.viewer.f.c(p1.h).a(0);
        }
        com.alphainventor.filemanager.viewer.f.b(p1.h).dismiss();
        return;
    }

    public bridge synthetic void B(androidx.recyclerview.widget.RecyclerView$F p1, int p2)
    {
        this.Q(((com.alphainventor.filemanager.viewer.f$d) p1), p2);
        return;
    }

    public void Q(com.alphainventor.filemanager.viewer.f$d p2, int p3)
    {
        super.Q(p2, p3);
        if (p3 > 0) {
            int v3_1;
            if (!((com.alphainventor.filemanager.viewer.f$f) this.d.get((p3 - 1))).a()) {
                v3_1 = 4;
            } else {
                v3_1 = 0;
            }
            p2.v.setVisibility(v3_1);
        }
        return;
    }

    public void R(com.alphainventor.filemanager.viewer.f$d p4)
    {
        p4.u.setText(2131952009);
        ax.s3.h v0_1 = 0;
        int v1_1 = 0;
        while (v1_1 < this.d.size()) {
            if (!((com.alphainventor.filemanager.viewer.f$f) this.d.get(v1_1)).a()) {
                v1_1++;
            } else {
                int v1_2 = 0;
            }
            if (v1_2 == 0) {
                v0_1 = 4;
            }
            p4.v.setVisibility(v0_1);
            p4.a.setOnClickListener(new ax.s3.h(this));
            return;
        }
        v1_2 = 1;
    }

    public void T(String p2)
    {
        if (com.alphainventor.filemanager.viewer.f.c(this.h) != null) {
            com.alphainventor.filemanager.viewer.f.c(this.h).a(1);
        }
        return;
    }

    public void V(java.util.List p1)
    {
        this.d = p1;
        return;
    }
}
