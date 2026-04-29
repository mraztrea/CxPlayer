// Decompiled from: Lcom/alphainventor/filemanager/viewer/f$b;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public final class f$b extends com.alphainventor.filemanager.viewer.f$g {
    final synthetic com.alphainventor.filemanager.viewer.f h;

    public f$b(com.alphainventor.filemanager.viewer.f p1, android.content.Context p2, com.alphainventor.filemanager.viewer.f$c p3)
    {
        this.h = p1;
        super(p1, p2, p3);
        return;
    }

    public static synthetic void U(com.alphainventor.filemanager.viewer.f$b p2, ax.P0.H p3, android.view.View p4)
    {
        p2.getClass();
        if ((p3 != null) && (p3.U(29))) {
            ((ax.P0.H) ax.S0.c0.h(p3)).t(p3.c0().I().G(1).U(1, 0).F());
            com.alphainventor.filemanager.viewer.f.b(p2.h).dismiss();
        }
        return;
    }

    private boolean V(ax.P0.S p5)
    {
        int v1 = 0;
        while (v1 < this.d.size()) {
            if (!p5.D.containsKey(((com.alphainventor.filemanager.viewer.f$f) this.d.get(v1)).a.a())) {
                v1++;
            } else {
                return 1;
            }
        }
        return 0;
    }

    public void R(com.alphainventor.filemanager.viewer.f$d p4)
    {
        p4.u.setText(2131952008);
        ax.P0.H v0_2 = this.h.h();
        if (v0_2 != null) {
            ax.s3.g v1_3;
            if (!this.V(((ax.P0.H) ax.S0.a.e(v0_2)).c0())) {
                v1_3 = 0;
            } else {
                v1_3 = 4;
            }
            p4.v.setVisibility(v1_3);
            p4.a.setOnClickListener(new ax.s3.g(this, v0_2));
            return;
        } else {
            return;
        }
    }

    public void T(String p1)
    {
        return;
    }

    public void W(java.util.List p1)
    {
        this.d = p1;
        return;
    }
}
