// Decompiled from: Lcom/alphainventor/filemanager/viewer/b;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public class b extends com.android.ex.photo.f {
    private java.util.List P;
    private boolean Q;
    private com.alphainventor.filemanager.file.o R;
    private ax.n3.d S;
    private android.database.Cursor T;
    private com.alphainventor.filemanager.viewer.b$b U;

    public b(com.android.ex.photo.f$g p1, java.util.List p2, com.alphainventor.filemanager.file.o p3)
    {
        super(p1);
        super.P = p2;
        super.R = p3;
        super.S = new ax.n3.d(p1.b(), super.R);
        return;
    }

    static synthetic boolean F0(com.alphainventor.filemanager.viewer.b p0)
    {
        return p0.Y();
    }

    static synthetic boolean G0(com.alphainventor.filemanager.viewer.b p0, int p1)
    {
        return p0.R0(p1);
    }

    static synthetic java.util.List H0(com.alphainventor.filemanager.viewer.b p0)
    {
        return p0.P;
    }

    static synthetic ax.n3.d I0(com.alphainventor.filemanager.viewer.b p0)
    {
        return p0.S;
    }

    private java.util.ArrayList J0(android.content.Context p6, android.net.Uri p7, java.util.List p8)
    {
        boolean v6_1 = ax.U2.Q.H3(p6, p7);
        java.util.ArrayList v7_2 = new java.util.ArrayList();
        int v1 = 0;
        while (v1 < p8.size()) {
            com.alphainventor.filemanager.viewer.e$a v3_0;
            android.net.Uri v2_1 = ((com.alphainventor.filemanager.file.n) p8.get(v1));
            if (!v6_1) {
                v3_0 = ax.W2.v.E(v2_1);
            } else {
                v3_0 = ax.W2.v.F(v2_1);
            }
            if (v3_0 != null) {
                v7_2.add(new com.alphainventor.filemanager.viewer.e$a(ax.W2.p.L(v2_1, 0), 0));
            }
            v1++;
        }
        return v7_2;
    }

    private com.alphainventor.filemanager.file.n K0(String p5)
    {
        if (p5 != null) {
            if (this.P != null) {
                int v1_0 = 0;
                while (v1_0 < this.P.size()) {
                    com.alphainventor.filemanager.file.n v2_2 = ((com.alphainventor.filemanager.file.n) this.P.get(v1_0));
                    if (!p5.equals(v2_2.S())) {
                        v1_0++;
                    } else {
                        return v2_2;
                    }
                }
                return 0;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }

    private int L0(android.net.Uri p6)
    {
        if (p6 != null) {
            if (this.P != null) {
                int v2 = 0;
                while (v2 < this.P.size()) {
                    boolean v3_2 = ((com.alphainventor.filemanager.file.n) this.P.get(v2));
                    if ((!ax.W2.w.F(v3_2)) || (!p6.equals(ax.W2.p.L(v3_2, 0)))) {
                        v2++;
                    } else {
                        return v2;
                    }
                }
                return -1;
            } else {
                return -1;
            }
        } else {
            return -1;
        }
    }

    private void M0(ax.w3.a p1)
    {
        if (this.O() != null) {
            this.O().g();
        }
        return;
    }

    public static android.content.Intent O0(android.content.Context p7, com.alphainventor.filemanager.file.n p8, boolean p9)
    {
        android.net.Uri v8_2;
        ax.q3.b.c(ax.W2.w.F(p8));
        String v4 = ax.W2.q.e(p8, "application/octet-stream");
        if (!ax.W2.w.F(p8)) {
            v8_2 = ax.W2.p.w(p8.b0());
        } else {
            v8_2 = ax.U2.Q.D3(p8);
        }
        return ax.U2.Q.y3(p7, ax.T2.c$a.d0, v8_2, v4, 1, p9);
    }

    private android.view.View P0(ax.w3.a p2)
    {
        if (p2.S0() != null) {
            return p2.S0().findViewById(2131362065);
        } else {
            return 0;
        }
    }

    private void Q0(ax.w3.a p2)
    {
        android.view.View v2_1 = this.P0(p2);
        if (v2_1 != null) {
            v2_1.setVisibility(8);
        }
        return;
    }

    private boolean R0(int p2)
    {
        if ((p2 >= this.P.size()) || (p2 < 0)) {
            return 0;
        } else {
            return 1;
        }
    }

    private void S0(ax.w3.a p4)
    {
        android.view.View v0 = this.P0(p4);
        if (v0 != null) {
            android.net.Uri v1_1 = android.net.Uri.parse(p4.V2());
            if (!this.l(v1_1)) {
                v0.setVisibility(8);
                return;
            } else {
                p4.S2(0);
                v0.setVisibility(0);
                v0.setOnClickListener(new com.alphainventor.filemanager.viewer.b$a(this, v1_1));
                v0.requestFocus();
                return;
            }
        } else {
            ax.q3.b.f();
            return;
        }
    }

    public void D0()
    {
        String v5_1;
        String v0_4 = this.n.getCurrentItem();
        Integer v2_1 = (v0_4 + 1);
        android.content.res.Resources v3_2 = this.j;
        if (v3_2 < null) {
            v5_1 = 0;
        } else {
            v5_1 = 1;
        }
        if ((!this.k) && ((v5_1 != null) && (v2_1 > null))) {
            if (v3_2 <= 1) {
                String v0_3 = ((com.alphainventor.filemanager.file.n) this.P.get(0));
                if (v0_3 == null) {
                    this.x = "";
                } else {
                    this.x = v0_3.B();
                }
            } else {
                android.content.res.Resources v3_1 = this.O().getResources();
                Integer v2_0 = Integer.valueOf(v2_1);
                Integer v6_2 = Integer.valueOf(this.j);
                Object[] v7_1 = new Object[2];
                v7_1[0] = v2_0;
                v7_1[1] = v6_2;
                this.x = v3_1.getString(2131952481, v7_1);
                if (!this.R0(v0_4)) {
                    this.y = "";
                } else {
                    String v0_7 = ((com.alphainventor.filemanager.file.n) this.P.get(v0_4));
                    if (v0_7 == null) {
                        this.y = "";
                    } else {
                        this.y = v0_7.B();
                    }
                }
            }
        } else {
            this.x = 0;
        }
        this.x0(this.O().m());
        return;
    }

    public void I(int p2)
    {
        super.I(p2);
        com.alphainventor.filemanager.viewer.b$b v0_0 = this.U;
        if ((v0_0 != null) && ((!v0_0.isCancelled()) && (ax.q3.q.n(this.U)))) {
            this.U.e();
        }
        com.alphainventor.filemanager.viewer.b$b v0_3 = new com.alphainventor.filemanager.viewer.b$b(this, p2);
        this.U = v0_3;
        Void[] v2_2 = new Void[0];
        v0_3.i(v2_2);
        return;
    }

    public android.net.Uri N0()
    {
        android.net.Uri v0_5 = this.n.getCurrentItem();
        android.database.Cursor v1_1 = this.p.x();
        if ((v1_1 == null) || (v1_1.isClosed())) {
            return 0;
        } else {
            v1_1.moveToPosition(v0_5);
            return android.net.Uri.parse(this.p.E(v1_1));
        }
    }

    public void T0()
    {
        this.Q = 1;
        this.k = 1;
        this.O().getSupportLoaderManager().g(100, 0, this);
        return;
    }

    public void U0()
    {
        com.android.ex.photo.e$b v0 = this.P();
        if (v0 != null) {
            v0.l();
        }
        return;
    }

    public void d0(int p2, int p3, android.content.Intent p4)
    {
        if ((p2 == 36001) && ((p3 == -1) && (p4 != null))) {
            int v2_3 = this.L0(p4.getData());
            if (v2_3 >= 0) {
                this.V().setCurrentItem(v2_3);
            }
        }
        return;
    }

    public void g(com.android.ex.photo.c p3, android.view.View p4)
    {
        if (this.O() != null) {
            ax.s3.d v0_1;
            ax.s3.d v0_2 = p4.getTag();
            if (!(v0_2 instanceof ax.s3.d)) {
                v0_1 = new ax.s3.d(p4);
                p4.setTag(v0_1);
            } else {
                v0_1 = ((ax.s3.d) v0_2);
            }
            com.alphainventor.filemanager.file.n v4_2;
            if (p3 != null) {
                v4_2 = 0;
            } else {
                com.alphainventor.filemanager.file.n v4_1 = this.N0();
                if (v4_1 == null) {
                } else {
                    v4_2 = this.K0(v4_1.toString());
                }
            }
            v0_1.d(this.O().b(), p3, v4_2);
            return;
        } else {
            return;
        }
    }

    public void i(ax.w3.a p1)
    {
        super.i(p1);
        this.S0(p1);
        this.M0(p1);
        return;
    }

    public void k0(ax.K0.c p2, android.database.Cursor p3)
    {
        if ((p3 == null) || (p3 != this.T)) {
            this.T = p3;
            try {
                super.k0(p2, p3);
            } catch (com.alphainventor.filemanager.viewer.ImageViewerActivity v2_7) {
                ax.za.c.h().d("IVOLF:").l(v2_7).h();
            }
            if (this.Q) {
                this.Q = 0;
                if (this.O() != null) {
                    ((com.alphainventor.filemanager.viewer.ImageViewerActivity) this.O()).y0();
                    this.D0();
                }
            }
        }
        return;
    }

    public boolean l(android.net.Uri p2)
    {
        if (ax.W2.u.e0 != ax.W2.v.g(ax.W2.Y.k(p2.getPath()))) {
            return 0;
        } else {
            return 1;
        }
    }

    public void o0()
    {
        super.o0();
        if ((this.O() != null) && (!this.O().t())) {
            this.y0(0, 0);
        }
        return;
    }

    public void r(android.net.Uri p13, boolean p14)
    {
        if (this.O() != null) {
            String v0_4 = this.K0(p13.toString());
            if (v0_4 != null) {
                ax.K2.a$b v1_5 = this.P;
                if (!ax.W2.w.F(v0_4)) {
                    try {
                        android.app.Activity v2_1 = v0_4.Q();
                    } catch (ax.V2.i) {
                    }
                    if ((v2_1 != null) && (ax.W2.w.D(v2_1, v0_4))) {
                        try {
                            v1_5 = java.util.Collections.singletonList(v2_1);
                        } catch (ax.V2.i) {
                        }
                        v0_4 = v2_1;
                    }
                }
                android.app.Activity v2_4 = ((android.app.Activity) this.O().b());
                if (!ax.W2.w.F(v0_4)) {
                    ax.za.b v14_9 = new StringBuilder();
                    v14_9.append("PLAY VIDEO:");
                    v14_9.append(p13.toString());
                    v14_9.append(",fileinfo:");
                    v14_9.append(v0_4.T());
                    ax.za.c.h().f().b("NOT REACHABLE : IMAGE VIEWER").j().g(v14_9.toString()).h();
                    android.widget.Toast.makeText(v2_4, 2131951922, 1).show();
                } else {
                    ax.za.b v14_20;
                    ax.W2.i v8_1 = ((ax.W2.i) v0_4);
                    if (p14 == null) {
                        ax.za.b v14_14 = ax.T2.c$a.c0;
                        if ((!ax.U2.Q.J3(v2_4, v14_14, v8_1, 0)) || (ax.U2.Q.M3(v2_4, v14_14, v8_1, 0))) {
                            if ((!ax.p3.k.E(v2_4)) || (!ax.W2.v.E(v8_1))) {
                                ax.za.b v14_18 = com.alphainventor.filemanager.viewer.b.O0(v2_4, v8_1, 1);
                                if ((v14_18 == null) || (!ax.W2.p.U(v14_18))) {
                                    v14_20 = com.alphainventor.filemanager.viewer.b$d.d0;
                                } else {
                                    v14_20 = com.alphainventor.filemanager.viewer.b$d.q;
                                }
                            } else {
                                v14_20 = com.alphainventor.filemanager.viewer.b$d.q;
                            }
                        } else {
                            v14_20 = com.alphainventor.filemanager.viewer.b$d.c0;
                        }
                    } else {
                        v14_20 = com.alphainventor.filemanager.viewer.b$d.q;
                    }
                    if (v14_20 != com.alphainventor.filemanager.viewer.b$d.q) {
                        if (v14_20 != com.alphainventor.filemanager.viewer.b$d.c0) {
                            ax.za.b v13_15 = this.O().k();
                            if ((v13_15 instanceof ax.X2.E)) {
                                ((ax.X2.E) v13_15).L2(ax.T2.c$a.d0, v8_1, v8_1.t(), 0, 0);
                            }
                        } else {
                            ax.za.b v13_2 = this.O().k();
                            if ((v13_2 instanceof ax.X2.E)) {
                                ((ax.X2.E) v13_2).L2(ax.T2.c$a.c0, v8_1, v8_1.t(), 0, 0);
                            }
                        }
                    } else {
                        ax.za.b v14_2 = ax.W2.p.L(v8_1, 0);
                        String v0_1 = this.J0(v2_4, v14_2, v1_5);
                        try {
                            ax.K2.a.i().m("command", "file_open").c("loc", "ImageViewerActivity").c("ext", v8_1.A()).c("result", "success").e();
                            v2_4.startActivityForResult(ax.W2.r.i(v2_4, v14_2, v0_1, 1, 0), 36001);
                        } catch (String v0_2) {
                            ax.za.b v13_4 = v0_2;
                            android.widget.Toast.makeText(v2_4, 2131951922, 1).show();
                            ax.za.c.h().f().b("PVI:").l(v13_4).h();
                        } catch (String v0_2) {
                        } catch (String v0_2) {
                        }
                    }
                }
            }
        }
        return;
    }

    public void u(ax.w3.a p2, boolean p3)
    {
        super.u(p2, p3);
        this.S0(p2);
        this.M0(p2);
        if (p3 == 0) {
            this.S0(p2);
            int v3_6 = android.net.Uri.parse(p2.V2());
            if (this.l(v3_6)) {
                int v3_2 = this.K0(v3_6.toString());
                if ((v3_2 == 0) || (!v3_2.o())) {
                    this.Q0(p2);
                } else {
                    p2.U2().setVisibility(8);
                    return;
                }
            }
        }
        return;
    }

    public bridge synthetic void w(ax.K0.c p1, Object p2)
    {
        this.k0(p1, ((android.database.Cursor) p2));
        return;
    }

    public ax.K0.c x(int p2, android.os.Bundle p3)
    {
        if (p2 != 100) {
            return super.x(p2, p3);
        } else {
            return new com.alphainventor.filemanager.viewer.b$c(this.O().b(), this.P);
        }
    }

    public ax.K0.c z(int p9, android.os.Bundle p10, String p11)
    {
        if (p9 != 1) {
            if (p9 == 2) {
                return new ax.s3.e(this.O().b(), this.R, 0, p11, 1, 0);
            } else {
                if (p9 != 3) {
                    return super.z(p9, p10, p11);
                }
            }
        }
        int v7;
        if (p10 == null) {
            v7 = 1;
        } else {
            v7 = p10.getBoolean("use_factory_if_possible", 1);
        }
        return new ax.s3.e(this.O().b(), this.R, this.K0(p11), p11, 0, v7);
    }
}
