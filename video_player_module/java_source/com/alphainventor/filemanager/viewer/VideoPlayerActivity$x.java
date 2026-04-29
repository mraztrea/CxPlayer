// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$x;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$x implements ax.P0.H$d {
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity a;

    private VideoPlayerActivity$x(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1)
    {
        this.a = p1;
        return;
    }

    synthetic VideoPlayerActivity$x(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1, com.alphainventor.filemanager.viewer.VideoPlayerActivity$k p2)
    {
        this(p1);
        return;
    }

    public synthetic void D(int p1)
    {
        ax.P0.I.q(this, p1);
        return;
    }

    public synthetic void E(boolean p1)
    {
        ax.P0.I.j(this, p1);
        return;
    }

    public void F(int p2)
    {
        if ((p2 == null) && (com.alphainventor.filemanager.viewer.VideoPlayerActivity.j1(this.a) == 2)) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.l1(this.a);
        }
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.K0(this.a);
        return;
    }

    public void H(ax.P0.U p13)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.T0(this.a).q();
        com.alphainventor.filemanager.viewer.VideoPlayerActivity v13_4 = p13.a();
        if (v13_4 != com.alphainventor.filemanager.viewer.VideoPlayerActivity.U0(this.a)) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.z0(this.a, 0);
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.W0(this.a, 0);
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.X0(this.a, 0);
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.Z0(this.a, 0);
            int v0_13 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.b1(this.a).o();
            if (v0_13 == 0) {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.g1(this.a, 0);
            } else {
                if (v0_13.i(2) == 1) {
                    int v3_6 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.d1(this.a, v13_4, "video");
                    int v8_2 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.e1(this.a);
                    String v9_5 = ax.za.c.h().f().b("video codec not available");
                    String v10_6 = new StringBuilder();
                    v10_6.append("codec : ");
                    v10_6.append(v3_6);
                    v10_6.append(",container : ");
                    v10_6.append(v8_2);
                    v9_5.g(v10_6.toString()).h();
                    String v9_7 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.r0();
                    String v10_9 = new StringBuilder();
                    v10_9.append("video codec not available : ");
                    v10_9.append(v3_6);
                    v10_9.append(", container : ");
                    v10_9.append(v8_2);
                    v9_7.severe(v10_9.toString());
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.f1(this.a, v3_6);
                }
                int v3_7 = v0_13.i(1);
                if (v3_7 != 1) {
                    if (v3_7 == 3) {
                        int v3_8 = 0;
                        while (v3_8 < v13_4.size()) {
                            int v4_7 = ((ax.P0.U$a) v13_4.get(v3_8));
                            if (v4_7.d() == 1) {
                                com.alphainventor.filemanager.viewer.VideoPlayerActivity v5_13 = 0;
                                while (v5_13 < v4_7.a) {
                                    if (v4_7.i(v5_13)) {
                                        com.alphainventor.filemanager.viewer.VideoPlayerActivity.a1(this.a);
                                    }
                                    v5_13++;
                                }
                            }
                            v3_8++;
                        }
                    }
                } else {
                    int v3_0 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.d1(this.a, v13_4, "audio");
                    String v9_2 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.e1(this.a);
                    String v10_2 = ax.za.c.h().f().b("audio codec not available");
                    StringBuilder v11_2 = new StringBuilder();
                    v11_2.append("codec : ");
                    v11_2.append(v3_0);
                    v11_2.append(",container : ");
                    v11_2.append(v9_2);
                    v10_2.g(v11_2.toString()).h();
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity v5_2 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.r0();
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity v6_1 = new StringBuilder();
                    v6_1.append("audio codec not available : ");
                    v6_1.append(v3_0);
                    v6_1.append(", container : ");
                    v6_1.append(v9_2);
                    v5_2.severe(v6_1.toString());
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.f1(this.a, v3_0);
                }
                if (v0_13.i(3) != 3) {
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.g1(this.a, 0);
                } else {
                    int v0_5 = 0;
                    while (v0_5 < v13_4.size()) {
                        int v3_3 = ((ax.P0.U$a) v13_4.get(v0_5));
                        if (v3_3.d() == 3) {
                            int v4_3 = 0;
                            while (v4_3 < v3_3.a) {
                                if ((v3_3.i(v4_3)) && ((v3_3.b(v4_3).e & 2) == 0)) {
                                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.Y0(this.a);
                                    if (v3_3.f()) {
                                        com.alphainventor.filemanager.viewer.VideoPlayerActivity.W0(this.a, 1);
                                    }
                                }
                                v4_3++;
                            }
                        }
                        v0_5++;
                    }
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.g1(this.a, 1);
                }
            }
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.V0(this.a, v13_4);
        }
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.J0(this.a);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.h1(this.a);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.i1(this.a);
        return;
    }

    public synthetic void I(boolean p1)
    {
        ax.P0.I.h(this, p1);
        return;
    }

    public synthetic void J(ax.P0.F p1)
    {
        ax.P0.I.s(this, p1);
        return;
    }

    public void L(ax.P0.F p2)
    {
        if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.P0(p2)) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.S0(this.a, 0);
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.J0(this.a);
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.u0(this.a);
            return;
        } else {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.Q0(this.a);
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.R0(this.a);
            return;
        }
    }

    public synthetic void M(int p1)
    {
        ax.P0.I.p(this, p1);
        return;
    }

    public void N(ax.P0.M p1, int p2)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.K0(this.a);
        return;
    }

    public void P(boolean p1)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.K0(this.a);
        return;
    }

    public synthetic void R(ax.P0.S p1)
    {
        ax.P0.I.C(this, p1);
        return;
    }

    public synthetic void S(ax.P0.H$b p1)
    {
        ax.P0.I.b(this, p1);
        return;
    }

    public synthetic void U(int p1, boolean p2)
    {
        ax.P0.I.f(this, p1, p2);
        return;
    }

    public void V(boolean p7, int p8)
    {
        String v0_0 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.r0();
        int v1_2 = new StringBuilder();
        v1_2.append("player state changed : ");
        v1_2.append(p7);
        v1_2.append(",");
        v1_2.append(p8);
        v0_0.fine(v1_2.toString());
        if (p8 != 4) {
            if (p8 != 3) {
                if (p8 == 2) {
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.C0(this.a);
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.t0(this.a, 0);
                }
            } else {
                if ((com.alphainventor.filemanager.viewer.VideoPlayerActivity.s0(this.a)) && ((!com.alphainventor.filemanager.viewer.VideoPlayerActivity.o0(this.a)) && (com.alphainventor.filemanager.viewer.VideoPlayerActivity.v0(this.a) > 0))) {
                    ax.K2.a$d v8_7 = this.a;
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.w0(this.a).postDelayed(v8_7.J1, ((long) com.alphainventor.filemanager.viewer.VideoPlayerActivity.v0(v8_7)));
                }
                ax.K2.a$d v7_37 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.x0(this.a);
                if ((!com.alphainventor.filemanager.viewer.VideoPlayerActivity.y0(this.a)) && ((com.alphainventor.filemanager.viewer.VideoPlayerActivity.A0(this.a) == null) || (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.A0(this.a).equals(v7_37)))) {
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.z0(this.a, 1);
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.B0(this.a, v7_37);
                    String v2_2 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.a).Y();
                    if (v2_2 < 0) {
                        v2_2 = -1;
                    }
                    if ((v7_37 == null) || (v7_37.getPath() == null)) {
                        ax.K2.a$d v7_39 = "uri_error";
                    } else {
                        v7_39 = ax.W2.Y.k(v7_37.getPath());
                    }
                    ax.K2.a.i().o("video_player_ready").a("duration_ms", v2_2).b("duration_range", ax.K2.a$g.a(v2_2)).b("ext", v7_39).c();
                }
                ax.K2.a$d v7_8;
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.C0(this.a);
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.t0(this.a, 0);
                if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.E0(this.a)) {
                    v7_8 = ax.Q.b.c(this.a, 2131100856);
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.F0(this.a, 300);
                } else {
                    v7_8 = ax.Q.b.c(this.a, 2131100857);
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.F0(this.a, 150);
                }
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.G0(this.a).setBufferedColor(v7_8);
            }
        } else {
            if ((!com.alphainventor.filemanager.viewer.VideoPlayerActivity.s0(this.a)) || (com.alphainventor.filemanager.viewer.VideoPlayerActivity.o0(this.a))) {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.t0(this.a, 1);
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.u0(this.a);
            } else {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.p0(this.a);
                return;
            }
        }
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.O0(this.a);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.H0(this.a);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.I0(this.a);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.J0(this.a);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.K0(this.a);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.L0(this.a);
        return;
    }

    public synthetic void Y(ax.P0.y p1, int p2)
    {
        ax.P0.I.k(this, p1, p2);
        return;
    }

    public synthetic void a(ax.P0.Z p1)
    {
        ax.P0.I.E(this, p1);
        return;
    }

    public synthetic void a0()
    {
        ax.P0.I.w(this);
        return;
    }

    public synthetic void b(int p1)
    {
        ax.P0.I.a(this, p1);
        return;
    }

    public synthetic void c0(ax.P0.H p1, ax.P0.H$c p2)
    {
        ax.P0.I.g(this, p1, p2);
        return;
    }

    public synthetic void f(boolean p1)
    {
        ax.P0.I.z(this, p1);
        return;
    }

    public synthetic void g0(boolean p1, int p2)
    {
        ax.P0.I.n(this, p1, p2);
        return;
    }

    public synthetic void h0(ax.P0.A p1)
    {
        ax.P0.I.l(this, p1);
        return;
    }

    public synthetic void i0(ax.P0.n p1)
    {
        ax.P0.I.e(this, p1);
        return;
    }

    public synthetic void j(ax.P0.G p1)
    {
        ax.P0.I.o(this, p1);
        return;
    }

    public synthetic void l0(int p1, int p2)
    {
        ax.P0.I.A(this, p1, p2);
        return;
    }

    public synthetic void m0(ax.P0.H$e p1, ax.P0.H$e p2, int p3)
    {
        ax.P0.I.v(this, p1, p2, p3);
        return;
    }

    public void q0(boolean p4)
    {
        int v0_0 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.r0();
        String v1_1 = new StringBuilder();
        v1_1.append("VideoPlayer : isPlaying=");
        v1_1.append(p4);
        v0_0.fine(v1_1.toString());
        if (p4 == null) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.M0(this.a, 0);
            return;
        } else {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.M0(this.a, 1);
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.N0(this.a);
            return;
        }
    }

    public synthetic void s(ax.P0.C p1)
    {
        ax.P0.I.m(this, p1);
        return;
    }

    public synthetic void t(ax.R0.c p1)
    {
        ax.P0.I.c(this, p1);
        return;
    }

    public void u(int p2)
    {
        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.j1(this.a) != p2) {
            ax.p3.m.j(this.a, p2);
        }
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.k1(this.a, p2);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.m1(this.a);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.K0(this.a);
        return;
    }

    public synthetic void v(java.util.List p1)
    {
        ax.P0.I.d(this, p1);
        return;
    }
}
