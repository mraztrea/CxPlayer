// Decompiled from: Lcom/alphainventor/filemanager/viewer/f;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public class f {
    private final android.widget.PopupWindow a;
    private final androidx.recyclerview.widget.RecyclerView b;
    private final android.content.Context c;
    private final com.alphainventor.filemanager.viewer.f$c d;
    private final com.alphainventor.filemanager.viewer.f$e e;
    private final com.alphainventor.filemanager.viewer.f$b f;
    private final ax.V1.f g;
    private final int h;
    private boolean i;
    private com.alphainventor.filemanager.viewer.f$h j;

    f(android.content.Context p3, com.alphainventor.filemanager.viewer.f$c p4)
    {
        this.c = p3;
        this.d = p4;
        this.h = p3.getResources().getDimensionPixelSize(2131165382);
        this.e = new com.alphainventor.filemanager.viewer.f$e(this, p3, p4);
        this.f = new com.alphainventor.filemanager.viewer.f$b(this, p3, p4);
        this.g = new ax.V1.f(p3.getResources());
        com.alphainventor.filemanager.viewer.f$a v3_5 = ((androidx.recyclerview.widget.RecyclerView) android.view.LayoutInflater.from(this.g()).inflate(2131558531, 0));
        this.b = v3_5;
        v3_5.setLayoutManager(new androidx.recyclerview.widget.LinearLayoutManager(this.g()));
        android.widget.PopupWindow v4_7 = new android.widget.PopupWindow(v3_5, -2, -2, 1);
        this.a = v4_7;
        if (ax.S0.c0.a < 23) {
            v4_7.setBackgroundDrawable(new android.graphics.drawable.ColorDrawable(0));
        }
        v4_7.setOnDismissListener(new com.alphainventor.filemanager.viewer.f$a(this));
        return;
    }

    static synthetic void a(com.alphainventor.filemanager.viewer.f p0, ax.P0.H p1, com.alphainventor.filemanager.viewer.f$f p2)
    {
        p0.m(p1, p2);
        return;
    }

    static synthetic android.widget.PopupWindow b(com.alphainventor.filemanager.viewer.f p0)
    {
        return p0.a;
    }

    static synthetic com.alphainventor.filemanager.viewer.f$h c(com.alphainventor.filemanager.viewer.f p0)
    {
        return p0.j;
    }

    private void e(androidx.recyclerview.widget.RecyclerView$h p3, android.view.View p4)
    {
        this.b.setAdapter(p3);
        this.p();
        this.i = 0;
        this.a.dismiss();
        this.i = 1;
        this.a.showAsDropDown(p4, 0, (((- this.a.getHeight()) - this.h) - p4.getHeight()));
        return;
    }

    private ax.p7.z f(ax.P0.U p9, int p10)
    {
        ax.p7.z$a v0_1 = new ax.p7.z$a();
        ax.p7.z v1 = p9.a();
        int v3 = 0;
        while (v3 < v1.size()) {
            ax.P0.U$a v4_1 = ((ax.P0.U$a) v1.get(v3));
            if (v4_1.d() == p10) {
                int v5_1 = 0;
                while (v5_1 < v4_1.a) {
                    if (v4_1.i(v5_1)) {
                        String v6_2 = v4_1.b(v5_1);
                        if ((v6_2.e & 2) == 0) {
                            v0_1.h(new com.alphainventor.filemanager.viewer.f$f(p9, v3, v5_1, this.g.a(v6_2)));
                        }
                    }
                    v5_1++;
                }
            }
            v3++;
        }
        return v0_1.k();
    }

    private android.content.Context g()
    {
        return this.c;
    }

    private void j()
    {
        ax.p7.z v0_0 = this.h();
        if (v0_0 == null) {
            ax.q3.b.g("player is null when init trackselectionadapter");
        }
        this.e.O();
        this.f.O();
        if ((v0_0 != null) && ((v0_0.U(30)) && (v0_0.U(29)))) {
            ax.p7.z v0_1 = v0_0.P();
            this.f.W(this.f(v0_1, 1));
            this.e.V(this.f(v0_1, 3));
        }
        return;
    }

    private void m(ax.P0.H p5, com.alphainventor.filemanager.viewer.f$f p6)
    {
        if (p5.U(29)) {
            p5.t(p5.c0().I().N(new ax.P0.P(p6.a.a(), ax.p7.z.A(Integer.valueOf(p6.b)))).U(p6.a.d(), 0).F());
            return;
        } else {
            return;
        }
    }

    private void p()
    {
        int v0_0 = this.i();
        this.b.measure(0, 0);
        this.a.setWidth(Math.min(this.b.getMeasuredWidth(), (v0_0.getWidth() - (this.h * 2))));
        this.a.setHeight(Math.min((v0_0.getHeight() - (this.h * 2)), this.b.getMeasuredHeight()));
        return;
    }

    public void d()
    {
        this.i = 0;
        this.a.dismiss();
        this.i = 1;
        return;
    }

    protected ax.P0.H h()
    {
        return this.d.c();
    }

    protected androidx.media3.ui.d i()
    {
        return this.d.j();
    }

    public void k()
    {
        String v0_0 = this.h();
        if (v0_0 != null) {
            com.alphainventor.filemanager.viewer.f$f v1_3 = this.f(v0_0.P(), 3);
            if (v1_3.size() != 0) {
                if (v1_3.size() != 1) {
                    int v2_2 = new StringBuilder();
                    v2_2.append("subtitle count : ");
                    v2_2.append(v1_3.size());
                    ax.q3.b.g(v2_2.toString());
                }
                this.m(v0_0, ((com.alphainventor.filemanager.viewer.f$f) v1_3.get(0)));
                return;
            } else {
                ax.q3.b.g("no subtitle track");
                return;
            }
        } else {
            return;
        }
    }

    public void l()
    {
        ax.P0.H v0 = this.h();
        if ((v0 != null) && (v0.U(29))) {
            v0.t(v0.c0().I().G(3).M(-3).U(3, 1).F());
        }
        return;
    }

    public void n(android.view.View p2)
    {
        this.e(this.f, p2);
        return;
    }

    public void o(android.view.View p2, com.alphainventor.filemanager.viewer.f$h p3)
    {
        this.e(this.e, p2);
        this.j = p3;
        return;
    }

    public void q()
    {
        this.j();
        return;
    }
}
