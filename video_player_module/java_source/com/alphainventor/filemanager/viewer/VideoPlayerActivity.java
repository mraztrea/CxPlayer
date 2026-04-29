// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public class VideoPlayerActivity extends ax.n.c implements androidx.media3.ui.d$m, com.alphainventor.filemanager.viewer.f$c {
    private static final java.util.logging.Logger R1;
    private static boolean S1;
    private static boolean T1;
    private android.widget.TextView A;
    private boolean A0;
    private android.os.Handler A1;
    private android.view.View B;
    private android.media.AudioManager B0;
    private int B1;
    private android.widget.ImageView C;
    private boolean C0;
    private int C1;
    private android.widget.ProgressBar D;
    private int D0;
    private com.alphainventor.filemanager.viewer.f D1;
    private android.widget.TextView E;
    private int E0;
    int E1;
    private androidx.media3.ui.AspectRatioFrameLayout F;
    private boolean F0;
    int F1;
    private com.google.android.material.snackbar.Snackbar G;
    private float G0;
    com.alphainventor.filemanager.viewer.VideoPlayerActivity$v G1;
    private android.view.View H;
    private boolean H0;
    boolean H1;
    private androidx.appcompat.widget.Toolbar I;
    private int I0;
    ax.i.r I1;
    private android.view.ViewGroup J;
    private boolean J0;
    Runnable J1;
    private android.view.ViewGroup K;
    private boolean K0;
    androidx.media3.ui.G$a K1;
    private android.view.View L;
    private long L0;
    Runnable L1;
    private android.view.View M;
    private long M0;
    private android.view.ScaleGestureDetector$SimpleOnScaleGestureListener M1;
    private android.view.View N;
    private ax.g1.n N0;
    private android.view.GestureDetector$SimpleOnGestureListener N1;
    private boolean O;
    private ax.g1.n$e O0;
    private android.view.View$OnClickListener O1;
    private boolean P;
    private ax.p7.z P0;
    com.alphainventor.filemanager.viewer.f$h P1;
    private String Q;
    private android.graphics.drawable.Drawable Q0;
    private com.alphainventor.filemanager.viewer.VideoPlayerActivity$y Q1;
    private String R;
    private android.graphics.drawable.Drawable R0;
    private androidx.media3.ui.b S;
    private android.graphics.drawable.Drawable S0;
    private android.widget.TextView T;
    private android.graphics.drawable.Drawable T0;
    private ax.U0.g$a U;
    private android.graphics.drawable.Drawable U0;
    private ax.e1.M V;
    private android.graphics.drawable.Drawable V0;
    private androidx.media3.exoplayer.ExoPlayer W;
    private android.graphics.drawable.Drawable W0;
    private ax.a1.O X;
    private android.graphics.drawable.Drawable X0;
    private ax.P0.y Y;
    private android.graphics.drawable.Drawable Y0;
    private android.net.Uri[] Z;
    private android.graphics.drawable.Drawable Z0;
    private android.view.View a;
    private android.net.Uri[] a0;
    private String a1;
    private androidx.media3.ui.PlayerView b;
    private android.net.Uri[] b0;
    private String b1;
    private boolean c;
    private java.util.List c0;
    private String c1;
    private Runnable d;
    private boolean d0;
    private String d1;
    private androidx.media3.ui.d e;
    private boolean e0;
    private String e1;
    private android.view.ViewGroup f;
    private boolean[] f0;
    private String f1;
    private android.view.View g;
    private int g0;
    private String g1;
    private android.view.View h;
    private int h0;
    private String h1;
    private android.view.View i;
    private int i0;
    private String i1;
    private android.view.View j;
    private boolean j0;
    private String j1;
    private android.widget.ImageButton k;
    private boolean k0;
    private float k1;
    private android.view.View l;
    private int l0;
    private float l1;
    private android.view.View m;
    private int m0;
    private boolean m1;
    private android.view.View n;
    private boolean n0;
    private int n1;
    private android.view.View o;
    private int o0;
    private long o1;
    private android.view.View p;
    private float p0;
    private String p1;
    private android.view.View q;
    private boolean q0;
    private int q1;
    private android.widget.ImageButton r;
    private boolean r0;
    private boolean r1;
    private android.view.View s;
    private boolean s0;
    private boolean s1;
    private android.widget.ImageView t;
    private long t0;
    private ax.W2.F t1;
    private android.widget.ImageButton u;
    private long u0;
    private boolean u1;
    private android.widget.ImageButton v;
    private boolean v0;
    private android.net.Uri v1;
    private android.widget.ImageButton w;
    private int w0;
    private long w1;
    private android.widget.ImageButton x;
    private int x0;
    private boolean x1;
    private androidx.appcompat.widget.MySpinner y;
    private float y0;
    private int y1;
    private android.view.View z;
    private boolean z0;
    private boolean z1;

    static VideoPlayerActivity()
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.R1 = java.util.logging.Logger.getLogger("FileManager.VideoPlayer");
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.S1 = 0;
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.T1 = 0;
        return;
    }

    public VideoPlayerActivity()
    {
        this.k0 = 0;
        this.p0 = 1065353216;
        this.w1 = 150;
        this.A1 = new android.os.Handler();
        this.I1 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$p(this, 1);
        this.J1 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$b(this);
        this.K1 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$c(this);
        this.L1 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$d(this);
        this.M1 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$e(this);
        this.N1 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$f(this);
        this.O1 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$g(this);
        this.P1 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$h(this);
        return;
    }

    static synthetic android.net.Uri A0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.v1;
    }

    static synthetic void A1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.Z3();
        return;
    }

    private int A2(int p2)
    {
        if (this.d0) {
            p2 = ((Integer) this.c0.get(p2)).intValue();
        }
        return p2;
    }

    private void A3()
    {
        if (this.P) {
            this.e2();
        }
        this.J0 = 1;
        if (this.P2()) {
            if (!this.R2()) {
                this.K.setBackgroundColor(-1);
                ax.M2.b.k(this, new com.alphainventor.filemanager.viewer.VideoPlayerActivity$j(this));
            } else {
                this.K.setBackgroundColor(0);
                this.N = ax.M2.b.j(this, new com.alphainventor.filemanager.viewer.VideoPlayerActivity$i(this));
                return;
            }
        }
        return;
    }

    private void A4(float p5, float p6, float p7, float p8, float p9)
    {
        if (this.d3()) {
            float v0_11 = (this.y0 * p5);
            this.y0 = v0_11;
            if (v0_11 >= 1065353216) {
                if (v0_11 > 1077936128) {
                    this.y0 = 1077936128;
                }
            } else {
                this.y0 = 1065353216;
            }
            if (!Float.isNaN(this.y0)) {
                this.F.setScaleX(this.y0);
                this.F.setScaleY(this.y0);
                this.p3(this.y0, (this.a2(this.F.getTranslationX(), (((float) this.b.getWidth()) / 1073741824), p6, p5) + p8), (this.a2(this.F.getTranslationY(), (((float) this.b.getHeight()) / 1073741824), p7, p5) + p9));
                return;
            } else {
                this.y0 = 1065353216;
                this.f2();
                return;
            }
        } else {
            this.f2();
            return;
        }
    }

    static synthetic android.net.Uri B0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, android.net.Uri p1)
    {
        p0.v1 = p1;
        return p1;
    }

    static synthetic boolean B1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.c3();
    }

    private String B2(ax.p7.z p8, String p9)
    {
        if (p8 != null) {
            int v2 = 0;
            while (v2 < p8.size()) {
                ax.P0.U$a v3_0 = ((ax.P0.U$a) p8.get(v2));
                int v4 = 0;
                while (v4 < v3_0.a) {
                    ax.P0.v v5_1 = v3_0.b(v4);
                    if (v5_1 != null) {
                        boolean v6_0 = v5_1.o;
                        if ((v6_0) && (v6_0.startsWith(p9))) {
                            return v5_1.o;
                        }
                    }
                    v4++;
                }
                v2++;
            }
            return 0;
        } else {
            return 0;
        }
    }

    private void B3()
    {
        if (this.Q1 == null) {
            this.Q1 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$y(this, this.A1);
        }
        this.Q1.d();
        return;
    }

    private void B4()
    {
        this.A0 = 1;
        return;
    }

    static synthetic void C0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.v4();
        return;
    }

    static synthetic void C1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, float p1, float p2, float p3)
    {
        p0.p3(p1, p2, p3);
        return;
    }

    private int C2()
    {
        int v0_0 = this.a0;
        if (v0_0 != 0) {
            return v0_0.length;
        } else {
            return 0;
        }
    }

    private void C3(int p4)
    {
        android.view.Window v0 = 255;
        android.view.Window v1_6 = (((int) (this.G0 * 1132396544)) + ((p4 * 255) / 360));
        if (v1_6 <= 255) {
            if (v1_6 >= null) {
                v0 = v1_6;
            } else {
                v0 = 0;
            }
        }
        android.widget.ProgressBar v4_3 = this.getWindow().getAttributes();
        v4_3.screenBrightness = (((float) v0) / 1132396544);
        this.getWindow().setAttributes(v4_3);
        this.D.setProgress(v0);
        return;
    }

    static synthetic void D0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.h2();
        return;
    }

    static synthetic int D1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.x0;
    }

    private void D3(int p4)
    {
        if (this.B0 != null) {
            String v0_1 = this.D0;
            android.media.AudioManager v1_1 = (this.E0 + ((p4 * v0_1) / 360));
            if (v1_1 <= v0_1) {
                if (v1_1 >= null) {
                    v0_1 = v1_1;
                } else {
                    v0_1 = 0;
                }
            }
            try {
                this.B0.setStreamVolume(3, v0_1, 0);
                this.D.setProgress(v0_1);
                return;
            } catch (SecurityException v4_4) {
                ax.K2.d.c("video set volume exception", v4_4);
            }
        } else {
            String v0_5 = ((android.media.AudioManager) this.getSystemService("audio"));
            this.B0 = v0_5;
            if (v0_5 != null) {
            }
        }
        return;
    }

    static synthetic boolean E0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.Y2();
    }

    static synthetic android.view.View E1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.a;
    }

    private boolean E2()
    {
        return this.J0;
    }

    private void E3(boolean p1, android.view.View p2)
    {
        if (p2 != null) {
            int v1_1;
            p2.setEnabled(p1);
            if (p1 == 0) {
                v1_1 = this.l1;
            } else {
                v1_1 = this.k1;
            }
            p2.setAlpha(v1_1);
            p2.setVisibility(0);
            return;
        } else {
            return;
        }
    }

    static synthetic long F0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, long p1)
    {
        p0.w1 = p1;
        return p1;
    }

    static synthetic int F1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.B1;
    }

    private static boolean F2(android.net.Uri[] p6)
    {
        int v2 = 0;
        while (v2 < p6.length) {
            boolean v3_2 = p6[v2];
            if (ax.W2.w.J(v3_2.getScheme())) {
                if (v3_2.getHost() != null) {
                    if (v3_2.getHost().startsWith(".")) {
                        return 1;
                    }
                } else {
                    return 1;
                }
            }
            v2++;
        }
        return 0;
    }

    private void F3(boolean p1)
    {
        this.n0 = p1;
        ax.p3.m.i(this, p1);
        this.m4();
        this.invalidateOptionsMenu();
        return;
    }

    static synthetic boolean G(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.c;
    }

    static synthetic androidx.media3.ui.b G0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.S;
    }

    static synthetic int G1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.C1;
    }

    private void G2()
    {
        ax.n.a v0 = this.getSupportActionBar();
        if (v0 != null) {
            v0.n();
            return;
        } else {
            return;
        }
    }

    private void G3(int p1)
    {
        this.i0 = p1;
        this.n4();
        return;
    }

    static synthetic boolean H(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.c = p1;
        return p1;
    }

    static synthetic void H0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.l2();
        return;
    }

    static synthetic void H1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.V1();
        return;
    }

    private void H2()
    {
        ax.n.a v0 = this.getSupportActionBar();
        if (v0 != null) {
            v0.H("");
            v0.x(1);
        }
        return;
    }

    private void H3()
    {
        if ((this.a0 != null) && (this.y2() != null)) {
            android.content.Intent v0_3 = new android.content.Intent();
            v0_3.setData(this.x2());
            this.setResult(-1, v0_3);
        }
        return;
    }

    static synthetic Runnable I(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.d;
    }

    static synthetic void I0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.m4();
        return;
    }

    static synthetic void I1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.y4();
        return;
    }

    private void I2()
    {
        if ((!ax.p3.m.o(this)) || (!ax.s3.f.r(this))) {
            boolean v0_2 = 0;
        } else {
            v0_2 = ax.s3.f.m(this);
        }
        if (!v0_2) {
            ax.s3.f.n(this);
        }
        return;
    }

    static synthetic boolean J(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.h3();
    }

    static synthetic void J0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.k4();
        return;
    }

    static synthetic int J1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.w0;
    }

    private void J2()
    {
        this.n0 = ax.p3.m.a(this);
        this.m4();
        this.L3(ax.p3.m.c(this));
        androidx.appcompat.widget.MySpinner v0_3 = this.p0;
        if (v0_3 != 0) {
            this.K3(v0_3, 1);
            this.y.setSelection(com.alphainventor.filemanager.viewer.d.c(this.p0));
        }
        this.t4();
        return;
    }

    private void J3(boolean p2)
    {
        this.a.setKeepScreenOn(p2);
        return;
    }

    static synthetic void K(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.B3();
        return;
    }

    static synthetic void K0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.n4();
        return;
    }

    static synthetic void K1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, int p1)
    {
        p0.D3(p1);
        return;
    }

    private void K2()
    {
        float v0_0 = this.getResources();
        this.Q0 = ax.o3.a.c(this, 2131231203);
        this.R0 = ax.o3.a.c(this, 2131231205);
        this.S0 = ax.o3.a.c(this, 2131231204);
        this.W0 = ax.o3.a.c(this, 2131231230);
        this.X0 = ax.o3.a.c(this, 2131231231);
        this.T0 = ax.o3.a.c(this, 2131231019);
        this.U0 = ax.o3.a.c(this, 2131231020);
        this.V0 = ax.o3.a.c(this, 2131231018);
        this.Z0 = ax.o3.a.c(this, 2131231024);
        this.Y0 = ax.o3.a.c(this, 2131231023);
        this.a1 = v0_0.getString(2131952540);
        this.b1 = v0_0.getString(2131952542);
        this.c1 = v0_0.getString(2131952541);
        this.d1 = v0_0.getString(2131951980);
        this.e1 = v0_0.getString(2131951981);
        this.f1 = v0_0.getString(2131951979);
        this.g1 = v0_0.getString(2131951966);
        this.h1 = v0_0.getString(2131951965);
        this.i1 = v0_0.getString(2131951987);
        this.j1 = v0_0.getString(2131951986);
        this.k1 = (((float) v0_0.getInteger(2131427337)) / 1120403456);
        this.l1 = (((float) v0_0.getInteger(2131427336)) / 1120403456);
        return;
    }

    private void K3(float p2, boolean p3)
    {
        ax.P0.G v0_0 = this.W;
        if (v0_0 != null) {
            if (p3 != null) {
                this.p0 = p2;
            }
            if ((v0_0.g() == null) || (this.W.g().a != p2)) {
                if (p2 != 1065353216) {
                    this.W.e(new ax.P0.G(p2));
                    return;
                } else {
                    this.W.e(ax.P0.G.d);
                    return;
                }
            }
        }
        return;
    }

    static synthetic void L0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.l4();
        return;
    }

    static synthetic void L1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, int p1)
    {
        p0.C3(p1);
        return;
    }

    private void L2()
    {
        android.net.Uri[] v0_0 = 0;
        if (this.a0 == null) {
            com.alphainventor.filemanager.service.b v2_9 = this.getIntent();
            ax.P0.y v3_17 = v2_9.getAction();
            this.g0 = -1;
            this.h0 = -1;
            if ((!"android.intent.action.VIEW".equals(v3_17)) || (v2_9.getData() == null)) {
                this.V3(2131951922);
                this.finish();
                return;
            } else {
                ax.P0.y v3_9 = com.alphainventor.filemanager.viewer.e.b().c();
                if (v3_9 == null) {
                    ax.W2.F v6_15 = new StringBuilder();
                    v6_15.append("Video play : ");
                    v6_15.append(v2_9.getData());
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.R1.fine(v6_15.toString());
                    ax.W2.F v6_17 = new android.net.Uri[1];
                    v6_17[0] = v2_9.getData();
                    this.Z = v6_17;
                    ax.W2.F v6_18 = new android.net.Uri[1];
                    v6_18[0] = this.i2(v2_9.getData());
                    this.a0 = v6_18;
                    ax.P0.y v3_15 = new java.util.ArrayList();
                    this.c0 = v3_15;
                    v3_15.add(Integer.valueOf(0));
                    ax.P0.y v3_16 = new android.net.Uri[1];
                    this.b0 = v3_16;
                } else {
                    ax.W2.F v6_21 = new android.net.Uri[v3_9.size()];
                    this.Z = v6_21;
                    ax.W2.F v6_23 = new android.net.Uri[v3_9.size()];
                    this.a0 = v6_23;
                    ax.W2.F v6_25 = new android.net.Uri[v3_9.size()];
                    this.b0 = v6_25;
                    this.c0 = new java.util.ArrayList();
                    ax.W2.F v6_13 = 0;
                    while (v6_13 < v3_9.size()) {
                        this.c0.add(Integer.valueOf(v6_13));
                        v6_13++;
                    }
                    java.util.Collections.shuffle(this.c0);
                    ax.W2.F v6_12 = 0;
                    while (v6_12 < v3_9.size()) {
                        android.net.Uri v7_7 = ((com.alphainventor.filemanager.viewer.e$a) v3_9.get(v6_12));
                        android.net.Uri v9_0 = v7_7.a;
                        this.Z[v6_12] = v9_0;
                        this.a0[v6_12] = this.i2(v9_0);
                        android.net.Uri v7_8 = v7_7.b;
                        if (v7_8 != null) {
                            this.b0[v6_12] = this.i2(v7_8);
                        }
                        v6_12++;
                    }
                    ax.P0.y v3_7 = 0;
                    while (v3_7 < this.Z.length) {
                        ax.W2.F v6_9 = ((Integer) this.c0.get(v3_7)).intValue();
                        android.net.Uri v7_2 = this.Z[v3_7];
                        if ((v7_2 != null) && (v7_2.equals(v2_9.getData()))) {
                            this.g0 = v3_7;
                        }
                        ax.W2.F v6_10 = this.Z[v6_9];
                        if ((v6_10 != null) && (v6_10.equals(v2_9.getData()))) {
                            this.h0 = v3_7;
                        }
                        v3_7++;
                    }
                }
                com.alphainventor.filemanager.service.b v2_10 = v2_9.getBooleanExtra("detect_subtitle", 1);
                this.e0 = v2_10;
                if (v2_10 != null) {
                    com.alphainventor.filemanager.service.b v2_13 = new boolean[this.a0.length];
                    this.f0 = v2_13;
                }
                if (!this.d0) {
                    com.alphainventor.filemanager.service.b v2_15 = this.g0;
                    if (v2_15 != -1) {
                        this.G3(v2_15);
                    } else {
                        this.G3(0);
                    }
                } else {
                    com.alphainventor.filemanager.service.b v2_0 = this.h0;
                    if (v2_0 != -1) {
                        this.G3(v2_0);
                    } else {
                        this.G3(0);
                    }
                }
                com.alphainventor.filemanager.service.b v2_1 = this.a0;
                ax.P0.y v3_0 = v2_1.length;
                int v4_0 = 0;
                while (v4_0 < v3_0) {
                    ax.W2.F v6_0 = v2_1[v4_0];
                    if (!com.alphainventor.filemanager.service.b.k(this, v6_0)) {
                        if (ax.W2.w.J(v6_0.getScheme())) {
                            this.x1 = 1;
                        }
                    } else {
                        this.x1 = 1;
                        this.s1 = 1;
                        ax.W2.F v6_4 = ax.k3.c.z(v6_0.getPath());
                        if (v6_4 != null) {
                            this.t1 = v6_4.d();
                        }
                    }
                    v4_0++;
                }
                if ((this.s1) && (this.t1 != null)) {
                    com.alphainventor.filemanager.service.b.f(this).l(1, this.t1);
                }
                com.alphainventor.filemanager.service.b v2_7 = new ax.P0.y[this.a0.length];
                while(true) {
                    ax.P0.y v3_2 = this.a0;
                    if (v0_0 >= v3_2.length) {
                        break;
                    }
                    v2_7[v0_0] = ax.P0.y.b(v3_2[v0_0]);
                    v0_0++;
                }
                if ((!com.alphainventor.filemanager.viewer.VideoPlayerActivity.F2(v3_2)) && (ax.S0.c0.l(v2_7))) {
                    if ((!ax.R2.Q.y0()) || (!ax.q3.o.c())) {
                        ax.S0.c0.T0(this, this.a0);
                        return;
                    }
                } else {
                    this.V3(2131951922);
                    return;
                }
            }
        }
        return;
    }

    private void L3(int p2)
    {
        androidx.media3.exoplayer.ExoPlayer v0 = this.W;
        if (v0 != null) {
            this.o0 = p2;
            v0.j(p2);
            this.q4();
            return;
        } else {
            return;
        }
    }

    static synthetic void M(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.a4();
        return;
    }

    static synthetic void M0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.J3(p1);
        return;
    }

    static synthetic void M1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.l3();
        return;
    }

    private void M2()
    {
        this.M3(ax.p3.m.e(this));
        this.L2();
        if ((this.a0 != null) && (this.W == null)) {
            this.I2();
            if (ax.R2.J.i()) {
                ax.W0.a.H0(2);
            }
            androidx.media3.ui.PlayerView v4_2;
            com.alphainventor.filemanager.viewer.a v0_4 = new ax.g1.a$b();
            android.view.GestureDetector v3_2 = new ax.X0.d(this);
            v3_2.o(1);
            if (!ax.p3.m.h(this)) {
                v4_2 = "";
            } else {
                v4_2 = ax.p3.m.f(this);
                if ((android.text.TextUtils.isEmpty(v4_2)) || ("default".equals(v4_2))) {
                    v4_2 = this.Q;
                }
            }
            this.R = v4_2;
            com.alphainventor.filemanager.viewer.VideoPlayerActivity$s v5_4 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$u(this, v0_4, v4_2);
            this.N0 = v5_4;
            v5_4.m(this.O0);
            this.P0 = 0;
            androidx.media3.ui.PlayerView v4_4 = new androidx.media3.exoplayer.j();
            com.alphainventor.filemanager.viewer.VideoPlayerActivity$s v5_6 = new androidx.media3.exoplayer.ExoPlayer$b(this, v3_2);
            v5_6.k(this.N0);
            v5_6.h(v4_4);
            v5_6.i(10000);
            v5_6.j(10000);
            android.view.GestureDetector v3_5 = v5_6.g();
            this.W = v3_5;
            v3_5.a(ax.X0.Y.g);
            this.W.H(new com.alphainventor.filemanager.viewer.VideoPlayerActivity$x(this, 0));
            this.W.L(this.m1);
            this.W.j0(new ax.i1.a(this.N0));
            if (!this.x1) {
                this.W.c(1);
            } else {
                this.W.c(2);
            }
            this.b.setPlayer(this.W);
            this.b.G();
            this.b.setOnTouchListener(new com.alphainventor.filemanager.viewer.VideoPlayerActivity$s(this, new android.view.ScaleGestureDetector(this, this.M1), new android.view.GestureDetector(this, this.N1), new com.alphainventor.filemanager.viewer.a(this, 1069547520, new com.alphainventor.filemanager.viewer.VideoPlayerActivity$r(this))));
        }
        com.alphainventor.filemanager.viewer.a v0_18 = this.W;
        if (v0_18 != null) {
            android.view.GestureDetector v3_0;
            android.view.ScaleGestureDetector v2_6 = this.n1;
            if (v2_6 == -1) {
                v3_0 = 0;
            } else {
                v3_0 = 1;
            }
            if (v3_0 != null) {
                v0_18.p(v2_6, this.o1);
            }
            this.J2();
            this.k4();
            this.n4();
            this.r3(this.w2(), (1 ^ v3_0));
        }
        return;
    }

    private void M3(boolean p1)
    {
        this.d0 = p1;
        this.r4();
        return;
    }

    static synthetic Runnable N(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, Runnable p1)
    {
        p0.d = p1;
        return p1;
    }

    static synthetic void N0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.c2();
        return;
    }

    static synthetic void N1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.F3(p1);
        return;
    }

    private void N2(float p6)
    {
        int v0_0 = this.W;
        if ((v0_0 != 0) && (v0_0.b())) {
            this.H0 = 1;
            this.E.setVisibility(0);
            int v0_2 = this.W.G();
            if (p6 != 1056964608) {
                if (p6 != 1073741824) {
                    ax.q3.b.f();
                    int v2_4 = this.E;
                    int v3_1 = new StringBuilder();
                    v3_1.append(p6);
                    v3_1.append("X\u25b6\u25b6");
                    v2_4.setText(v3_1.toString());
                } else {
                    this.E.setText("2X\u25b6\u25b6");
                }
            } else {
                this.E.setText("0.5X\u25b6\u25b6");
            }
            if ((v0_2.a() == -1) || ((this.b.getHeight() == 0) || (this.b.getHeight() <= v0_2.a()))) {
                int v3_12 = 0;
            } else {
                v3_12 = ((((this.b.getHeight() - v0_2.a()) / 2) - this.E.getHeight()) - ax.q3.A.e(this, 10));
                if (v3_12 < 0) {
                }
            }
            if (v3_12 == 0) {
                int v0_10;
                int v0_8 = this.getSupportActionBar();
                if ((v0_8 == 0) || (!v0_8.p())) {
                    v0_10 = 0;
                } else {
                    v0_10 = v0_8.l();
                }
                int v2_16;
                if (v0_10 <= 0) {
                    v2_16 = ax.q3.A.e(this, 5);
                } else {
                    v2_16 = ax.q3.A.e(this, 25);
                }
                v3_12 = (v2_16 + v0_10);
            }
            int v0_13 = ((android.view.ViewGroup$MarginLayoutParams) this.E.getLayoutParams());
            v0_13.setMargins(0, v3_12, 0, 0);
            this.E.setLayoutParams(v0_13);
            this.K3(p6, 0);
        }
        return;
    }

    private void N3(int p9, boolean p10)
    {
        int v10_2;
        androidx.media3.ui.SubtitleView v0_1 = this.b.getSubtitleView();
        if (p10 == 0) {
            v10_2 = android.graphics.Typeface.DEFAULT;
        } else {
            v10_2 = android.graphics.Typeface.DEFAULT_BOLD;
        }
        v0_1.setStyle(new ax.V1.a(-1, 0, 0, 2, -16777216, v10_2));
        v0_1.b(2, ((float) p9));
        return;
    }

    static synthetic void O0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.h4();
        return;
    }

    static synthetic void O1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.c4();
        return;
    }

    private boolean O2()
    {
        return this.K0;
    }

    private void O3(String p2)
    {
        ax.n.a v0 = this.getSupportActionBar();
        if (v0 != null) {
            v0.H(p2);
        }
        return;
    }

    static synthetic void P(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.e4();
        return;
    }

    static synthetic boolean P0(ax.P0.F p0)
    {
        return com.alphainventor.filemanager.viewer.VideoPlayerActivity.S2(p0);
    }

    static synthetic void P1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.n3();
        return;
    }

    private boolean P2()
    {
        if (this.I0 == 0) {
            return 0;
        } else {
            return 1;
        }
    }

    private void P3()
    {
        ax.n.a v0 = this.getSupportActionBar();
        if (v0 != null) {
            v0.J();
            return;
        } else {
            return;
        }
    }

    static synthetic boolean Q()
    {
        return com.alphainventor.filemanager.viewer.VideoPlayerActivity.T1;
    }

    static synthetic void Q0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.g2();
        return;
    }

    static synthetic void Q1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.u3();
        return;
    }

    private boolean Q2()
    {
        if ((this.M0 == 0) || ((System.currentTimeMillis() - this.M0) <= 90000)) {
            int v0_1 = 0;
        } else {
            v0_1 = 1;
        }
        if (v0_1 != 0) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.R1.fine("ad is expired");
        }
        return v0_1;
    }

    private void Q3(String p3)
    {
        com.google.android.material.snackbar.Snackbar v3_4;
        com.alphainventor.filemanager.viewer.VideoPlayerActivity$a v0_0 = this.z2(p3);
        if (((ax.s3.f.s(this)) || ((ax.p3.m.o(this)) && (ax.s3.f.r(this)))) || ((!ax.s3.f.q(p3)) || (ax.s3.f.k() == null))) {
            v3_4 = ax.q3.A.Y(this.a, v0_0, 0);
        } else {
            v3_4 = ax.q3.A.Y(this.a, v0_0, -2);
            v3_4.q0(2131951910, new com.alphainventor.filemanager.viewer.VideoPlayerActivity$a(this));
            this.G = v3_4;
        }
        v3_4.a0();
        return;
    }

    static synthetic boolean R(boolean p0)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.T1 = p0;
        return p0;
    }

    static synthetic void R0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.M2();
        return;
    }

    static synthetic void R1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.d4();
        return;
    }

    private boolean R2()
    {
        boolean v0_0 = this.I0;
        if ((v0_0 != 33) && (v0_0 != 34)) {
            if ((v0_0 != 17) && (v0_0 != 18)) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if (!new java.util.Random().nextBoolean()) {
                return 0;
            } else {
                return 1;
            }
        }
    }

    private void R3()
    {
        return;
    }

    static synthetic boolean S()
    {
        return com.alphainventor.filemanager.viewer.VideoPlayerActivity.S1;
    }

    static synthetic void S0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.j3(p1);
        return;
    }

    static synthetic void S1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.f4();
        return;
    }

    private static boolean S2(ax.P0.F p2)
    {
        if (!(p2 instanceof androidx.media3.exoplayer.s)) {
            if (p2 != null) {
                Throwable v2_2 = p2.getCause();
                while (v2_2 != null) {
                    v2_2 = v2_2.getCause();
                }
            }
        } else {
            if (((androidx.media3.exoplayer.s) p2).k0 == 0) {
                Throwable v2_1 = ((androidx.media3.exoplayer.s) p2).i();
                while (v2_1 != null) {
                    v2_1 = v2_1.getCause();
                }
            } else {
                return 0;
            }
        }
        return 0;
    }

    private void S3(boolean p2)
    {
        if (p2 == null) {
            this.z.setVisibility(8);
        } else {
            this.z.setVisibility(0);
        }
        this.j4();
        return;
    }

    static synthetic com.alphainventor.filemanager.viewer.f T0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.D1;
    }

    static synthetic void T1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.d2();
        return;
    }

    private boolean T2()
    {
        return this.F0;
    }

    private void T3(boolean p4)
    {
        android.widget.ImageView v0_2 = ((android.widget.ImageView) this.findViewById(2131362382));
        v0_2.setVisibility(0);
        if (p4 == null) {
            v0_2.setImageResource(2131231118);
        } else {
            v0_2.setImageResource(2131231119);
        }
        v0_2.setVisibility(0);
        android.view.animation.AlphaAnimation v4_2 = new android.view.animation.AlphaAnimation(0, 1065353216);
        v4_2.setDuration(750);
        v4_2.setInterpolator(new android.view.animation.DecelerateInterpolator());
        v0_2.startAnimation(v4_2);
        v4_2.setAnimationListener(new com.alphainventor.filemanager.viewer.VideoPlayerActivity$q(this, v0_2));
        return;
    }

    static synthetic boolean U(boolean p0)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.S1 = p0;
        return p0;
    }

    static synthetic ax.p7.z U0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.P0;
    }

    private void U1()
    {
        this.F0 = 0;
        this.B.setVisibility(8);
        return;
    }

    public static final boolean U2(int p1)
    {
        if ((p1 == 23) || ((p1 == 66) || (p1 == 160))) {
            return 1;
        } else {
            return 0;
        }
    }

    private void U3(int p3)
    {
        ax.q3.A.X(this.a, p3, 0).a0();
        return;
    }

    static synthetic String V(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, String p1)
    {
        return p0.z2(p1);
    }

    static synthetic ax.p7.z V0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, ax.p7.z p1)
    {
        p0.P0 = p1;
        return p1;
    }

    private void V1()
    {
        android.widget.ImageView v0_8 = this.getWindow().getAttributes().screenBrightness;
        if ((v0_8 < 0) || (v0_8 > 1065353216)) {
            this.G0 = 1056964608;
        } else {
            this.G0 = v0_8;
        }
        this.D.setMax(255);
        this.F0 = 1;
        this.B.setVisibility(0);
        this.D.setProgressDrawable(ax.o.a.b(this, 2131231544));
        this.C.setImageResource(2131231196);
        return;
    }

    private boolean V2()
    {
        return this.s0;
    }

    private void V3(int p1)
    {
        this.W3(this.getString(p1));
        return;
    }

    static synthetic void W(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.m3();
        return;
    }

    static synthetic boolean W0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.k0 = p1;
        return p1;
    }

    private ax.U0.g$a W1()
    {
        return new ax.U0.m(this, this.D2(), new ax.h1.h$b(this).a());
    }

    private boolean W2()
    {
        if ((!this.V2()) && ((!this.g3()) && (!this.T2()))) {
            return 0;
        } else {
            return 1;
        }
    }

    private void W3(String p2)
    {
        android.widget.Toast.makeText(this, p2, 1).show();
        return;
    }

    static synthetic boolean X(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.r1;
    }

    static synthetic int X0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, int p1)
    {
        p0.l0 = p1;
        return p1;
    }

    private ax.P0.y X1(int p3)
    {
        ax.P0.y v3_1 = this.A2(p3);
        if ((this.e0) && (!this.f0[v3_1])) {
            boolean[] v0_6 = this.b0;
            if (!v0_6[v3_1]) {
                v0_6[v3_1] = this.t2(this.a0[v3_1]);
                this.f0[v3_1] = 1;
            }
        }
        return this.Y1(this.a0[v3_1], this.b0[v3_1], 0);
    }

    private boolean X2()
    {
        if (this.z.getVisibility() != 0) {
            return 0;
        } else {
            return 1;
        }
    }

    private void X3()
    {
        if (!this.getSupportFragmentManager().P0()) {
            ax.U2.W v0_5 = this.W;
            if ((v0_5 == null) || (!v0_5.b())) {
                this.H1 = 0;
            } else {
                this.H1 = 1;
                this.W.f();
            }
            ax.q3.A.g0(this.getSupportFragmentManager(), ax.U2.W.i3(), "settings", 1);
            return;
        } else {
            return;
        }
    }

    static synthetic int Y0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p2)
    {
        int v0 = p2.l0;
        p2.l0 = (v0 + 1);
        return v0;
    }

    private ax.P0.y Y1(android.net.Uri p2, android.net.Uri p3, String p4)
    {
        ax.P0.y$c v4_1 = new ax.P0.y$c();
        v4_1.f(p2);
        if (p3 != 0) {
            ax.P0.y v2_7 = ax.W2.v.n(ax.W2.Y.f(p3.getPath()));
            ax.P0.y$k$a v0_1 = new ax.P0.y$k$a(p3);
            v0_1.l(1);
            v0_1.k(v2_7);
            v4_1.d(java.util.Collections.singletonList(v0_1.i()));
            return v4_1.a();
        } else {
            return v4_1.a();
        }
    }

    private boolean Y2()
    {
        if (this.y2() != null) {
            int v0_4 = this.y2().getScheme();
            if ((!"file".equals(v0_4)) && (!"content".equals(v0_4))) {
                return 0;
            } else {
                return 1;
            }
        } else {
            return 0;
        }
    }

    static synthetic float Z(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.y0;
    }

    static synthetic int Z0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, int p1)
    {
        p0.m0 = p1;
        return p1;
    }

    private float Z1(float p4, int p5, float p6, float p7)
    {
        float v6_1 = (p6 - p7);
        float v0_1 = (((float) p5) / 1073741824);
        float v4_2 = (p4 / 1073741824);
        float v7_2 = (v6_1 + v0_1);
        if ((v7_2 - v4_2) <= 0) {
            if ((v7_2 + v4_2) >= ((float) p5)) {
                return v6_1;
            } else {
                return (v0_1 - v4_2);
            }
        } else {
            return (v4_2 - v0_1);
        }
    }

    private boolean Z2()
    {
        return this.H0;
    }

    private void Z3()
    {
        if (!this.b.I()) {
            this.b.V();
            this.c2();
            return;
        } else {
            this.b.G();
            return;
        }
    }

    static synthetic void a0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.z4();
        return;
    }

    static synthetic int a1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p2)
    {
        int v0 = p2.m0;
        p2.m0 = (v0 + 1);
        return v0;
    }

    private float a2(float p2, float p3, float p4, float p5)
    {
        return ((p2 - (p4 - (p5 * (p4 - (p2 + p3))))) + p3);
    }

    private boolean a3()
    {
        return ax.q3.y.u(this);
    }

    private void a4()
    {
        this.F3((this.n0 ^ 1));
        return;
    }

    static synthetic boolean b0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.V2();
    }

    static synthetic ax.g1.n b1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.N0;
    }

    private void b2()
    {
        if (this.f3()) {
            this.z1 = 1;
            this.A1.removeCallbacks(this.J1);
        }
        return;
    }

    private boolean b3()
    {
        int v0_0 = this.I0;
        if ((v0_0 != 2) && ((v0_0 != 18) && (v0_0 != 34))) {
            return 0;
        } else {
            return 1;
        }
    }

    private void b4()
    {
        androidx.media3.ui.PlayerView v0_0 = this.W;
        if (v0_0 != null) {
            androidx.media3.ui.PlayerView v0_1 = v0_0.r();
            this.W.L((v0_1 ^ 1));
            if (v0_1 == null) {
                this.b.G();
            }
        }
        return;
    }

    static synthetic void c0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.o2();
        return;
    }

    static synthetic int c1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.q1;
    }

    private void c2()
    {
        if ((!this.b.getControllerAutoShow()) && (!this.V2())) {
            this.b.setControllerAutoShow(1);
        }
        return;
    }

    private boolean c3()
    {
        return this.z0;
    }

    private void c4()
    {
        androidx.media3.exoplayer.ExoPlayer v0 = this.W;
        if (v0 != null) {
            v0.j(ax.S0.H.a(v0.o(), 3));
            this.q4();
            return;
        } else {
            return;
        }
    }

    static synthetic boolean d0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.g3();
    }

    static synthetic String d1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, ax.p7.z p1, String p2)
    {
        return p0.B2(p1, p2);
    }

    private void d2()
    {
        this.D1.n(this.v);
        return;
    }

    private boolean d3()
    {
        int v0_0 = this.W;
        if (v0_0 != 0) {
            int v0_5 = v0_0.G();
            if ((v0_5.a() == -1) || ((v0_5.b() == -1) || (this.b.getHeight() == 0))) {
                return 0;
            } else {
                return 1;
            }
        } else {
            return 0;
        }
    }

    private void d4()
    {
        String v2_0;
        android.graphics.drawable.Drawable v0_1;
        android.graphics.drawable.Drawable v0_2 = this.b.getResizeMode();
        Runnable v1_1 = 3;
        if (v0_2 == null) {
            v0_1 = this.R0;
            v2_0 = this.b1;
        } else {
            if (v0_2 == 3) {
                v0_1 = this.S0;
                v2_0 = this.c1;
                v1_1 = 4;
            } else {
                v1_1 = 0;
                if (v0_2 == 4) {
                    v0_1 = this.Q0;
                    v2_0 = this.a1;
                } else {
                    ax.q3.b.f();
                    v0_1 = this.Q0;
                    v2_0 = this.a1;
                }
            }
        }
        this.b.setResizeMode(v1_1);
        this.r.setImageDrawable(v0_1);
        this.r.setContentDescription(v2_0);
        this.A.removeCallbacks(this.L1);
        this.A.setText(v2_0);
        this.A.postDelayed(this.L1, 1000);
        return;
    }

    static synthetic void e0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.x4();
        return;
    }

    static synthetic String e1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.k2();
    }

    private void e2()
    {
        android.view.ViewGroup v0_0 = this.N;
        if (v0_0 != null) {
            ax.M2.b.a(v0_0, this);
        }
        this.N = 0;
        this.P = 0;
        this.J0 = 0;
        this.K.removeAllViews();
        return;
    }

    private boolean e3()
    {
        return this.P;
    }

    private void e4()
    {
        this.d0 = (this.d0 ^ 1);
        boolean v0_5 = this.w2();
        if (!this.d0) {
            this.G3(((Integer) this.c0.get(v0_5)).intValue());
        } else {
            int v1_0 = 0;
            while (v1_0 < this.c0.size()) {
                if (v0_5 == ((Integer) this.c0.get(v1_0)).intValue()) {
                    this.G3(v1_0);
                }
                v1_0++;
            }
        }
        ax.p3.m.k(this, this.d0);
        this.r4();
        return;
    }

    static synthetic boolean f0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.T2();
    }

    static synthetic void f1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, String p1)
    {
        p0.Q3(p1);
        return;
    }

    private void f2()
    {
        this.F.setScaleX(1065353216);
        this.F.setScaleY(1065353216);
        this.F.setTranslationX(0);
        this.F.setTranslationY(0);
        return;
    }

    private boolean f3()
    {
        if (this.y1 < 0) {
            return 0;
        } else {
            return 1;
        }
    }

    private void f4()
    {
        if (this.l0 != 1) {
            this.D1.o(this.v, this.P1);
            return;
        } else {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.T1 = 1;
            if (!this.k0) {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.S1 = 0;
                this.D1.k();
                return;
            } else {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.S1 = 1;
                this.D1.l();
                return;
            }
        }
    }

    static synthetic void g0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.U1();
        return;
    }

    static synthetic boolean g1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.j0 = p1;
        return p1;
    }

    private void g2()
    {
        this.m1 = 1;
        this.n1 = -1;
        this.o1 = -9223372036854775807;
        return;
    }

    private boolean g3()
    {
        return this.C0;
    }

    private void g4()
    {
        if (this.e.n0()) {
            if (!this.X2()) {
                if (!this.r1) {
                    this.P3();
                    return;
                } else {
                    this.G2();
                    return;
                }
            } else {
                this.P3();
                return;
            }
        } else {
            this.G2();
            return;
        }
    }

    static synthetic boolean h0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.Z2();
    }

    static synthetic void h1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.u4();
        return;
    }

    private void h2()
    {
        this.K0 = 1;
        this.L0 = System.currentTimeMillis();
        this.e2();
        return;
    }

    private boolean h3()
    {
        return this.A0;
    }

    private void h4()
    {
        if (this.W != null) {
            if ((this.O2()) && ((System.currentTimeMillis() - this.L0) > 30000)) {
                this.K0 = 0;
            }
            android.view.View v2_0 = 1;
            if (!this.b3()) {
                v2_0 = (1 ^ this.W.r());
            } else {
                if ((this.W.r()) && (this.W.i() != 4)) {
                    v2_0 = 0;
                }
            }
            if ((v2_0 != null) && ((!this.O2()) && ((!this.V2()) && ((this.P2()) && (!this.a3()))))) {
                this.J.setVisibility(0);
                if ((!this.E2()) || (this.Q2())) {
                    this.A3();
                }
                if (!this.e3()) {
                    this.M.setVisibility(0);
                    this.L.setVisibility(8);
                    return;
                } else {
                    if (this.M0 == 0) {
                        this.M0 = System.currentTimeMillis();
                    }
                    if (this.O) {
                        android.view.View v2_15 = this.N.findViewById(2131362486);
                        if (v2_15 != null) {
                            android.view.ViewGroup$LayoutParams v3_5 = ax.q3.A.f(this, this.getResources().getDisplayMetrics().heightPixels);
                            int v4_3 = 150;
                            if (v3_5 <= 360) {
                                v4_3 = (150 - (360 - v3_5));
                                if (v4_3 < 60) {
                                    v4_3 = 60;
                                }
                            }
                            android.view.ViewGroup$LayoutParams v3_7 = v2_15.getLayoutParams();
                            v3_7.height = ax.q3.A.e(this, v4_3);
                            v2_15.setLayoutParams(v3_7);
                        }
                    }
                    this.M.setVisibility(8);
                    this.L.setVisibility(0);
                    return;
                }
            } else {
                this.J.setVisibility(8);
                return;
            }
        } else {
            return;
        }
    }

    static synthetic void i0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.k3();
        return;
    }

    static synthetic void i1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.i4();
        return;
    }

    private android.net.Uri i2(android.net.Uri p5)
    {
        if (!com.alphainventor.filemanager.provider.MyFileProvider.w(p5)) {
            if (!com.alphainventor.filemanager.provider.MyFileProvider.v(p5)) {
                com.alphainventor.filemanager.provider.MyFileProvider.y(p5);
                return p5;
            }
        } else {
            boolean v0_7 = com.alphainventor.filemanager.provider.MyFileProvider.d(p5);
            String v1_0 = v0_7.e();
            java.io.File v2_1 = new java.io.File(v1_0);
            boolean v0_2 = ax.W2.Y.v(v0_7.d(), v1_0, Boolean.FALSE);
            if ((!v0_2) || ((!v0_2.startsWith("/Android")) || (!com.alphainventor.filemanager.file.x.K0(v2_1).b1()))) {
                return android.net.Uri.fromFile(v2_1);
            }
        }
        return p5;
    }

    private void i3(boolean p3)
    {
        if (!ax.R2.Q.t0()) {
            if (p3 == 0) {
                this.setRequestedOrientation(-1);
                return;
            } else {
                this.setRequestedOrientation(ax.q3.y.l(this));
                return;
            }
        } else {
            if (p3 == 0) {
                this.setRequestedOrientation(-1);
                return;
            } else {
                this.setRequestedOrientation(14);
                return;
            }
        }
    }

    private void i4()
    {
        if (this.m0 <= 1) {
            this.u.setVisibility(8);
            return;
        } else {
            this.u.setVisibility(0);
            return;
        }
    }

    static synthetic android.view.View j0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.H;
    }

    static synthetic int j1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.o0;
    }

    private void j3(boolean p2)
    {
        this.r1 = p2;
        if (!p2) {
            this.b.setControllerShowTimeoutMs(5000);
        } else {
            this.b.setControllerShowTimeoutMs(3000);
        }
        this.i3(this.r1);
        this.m4();
        this.p4();
        this.j4();
        return;
    }

    private void j4()
    {
        if ((!this.r1) || (this.X2())) {
            int v0_2 = 0;
        } else {
            v0_2 = 1;
        }
        this.I1.j(v0_2);
        return;
    }

    static synthetic ax.P0.y k0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.Y;
    }

    static synthetic int k1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, int p1)
    {
        p0.o0 = p1;
        return p1;
    }

    private String k2()
    {
        if (this.y2() != null) {
            return ax.W2.q.h(this.y2().getPath());
        } else {
            return "";
        }
    }

    private void k3()
    {
        this.H0 = 0;
        this.E.setVisibility(4);
        this.K3(this.p0, 0);
        return;
    }

    private void k4()
    {
        return;
    }

    static synthetic ax.P0.y l0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, ax.P0.y p1)
    {
        p0.Y = p1;
        return p1;
    }

    static synthetic void l1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.o3();
        return;
    }

    private void l2()
    {
        androidx.appcompat.widget.MySpinner v0 = this.y;
        if (v0 != null) {
            v0.c();
            return;
        } else {
            return;
        }
    }

    private void l3()
    {
        this.N2(1073741824);
        return;
    }

    private void l4()
    {
        return;
    }

    static synthetic ax.P0.y m0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, int p1)
    {
        return p0.X1(p1);
    }

    static synthetic void m1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.q4();
        return;
    }

    private void m2(boolean p17)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity v0 = this;
        android.widget.TextView v1_0 = this.W;
        if (v1_0 != null) {
            String v7_0;
            android.widget.TextView v1_5 = v1_0.k0();
            String v3_4 = (((long) ax.p3.m.b(this)) * 1000);
            if (!p17) {
                v7_0 = (v1_5 - v3_4);
            } else {
                v7_0 = (v1_5 + v3_4);
            }
            long v9_1 = this.W.Y();
            if (v9_1 == -9223372036854775807) {
                v9_1 = 0;
            }
            if (v7_0 >= 0) {
                if (v7_0 > v9_1) {
                    v7_0 = v9_1;
                }
            } else {
                v7_0 = 0;
            }
            if (v1_5 != v7_0) {
                this.W.a(ax.X0.Y.c);
                this.W.s(v7_0);
                this.W.a(ax.X0.Y.g);
                v0.A.removeCallbacks(v0.L1);
                if (!p17) {
                    android.widget.TextView v1_6 = this.A;
                    Runnable v2_4 = new StringBuilder();
                    v2_4.append("-");
                    v2_4.append(ax.q3.A.q(v3_4));
                    v1_6.setText(v2_4.toString());
                } else {
                    android.widget.TextView v1_7 = this.A;
                    Runnable v2_7 = new StringBuilder();
                    v2_7.append("+");
                    v2_7.append(ax.q3.A.q(v3_4));
                    v1_7.setText(v2_7.toString());
                }
                this.A.postDelayed(this.L1, 1000);
                return;
            }
        }
        return;
    }

    private void m3()
    {
        this.N2(1056964608);
        return;
    }

    private void m4()
    {
        if (!this.X2()) {
            if (!this.r1) {
                if (!this.n0) {
                    this.g.setVisibility(8);
                    this.h.setVisibility(8);
                    this.i.setVisibility(0);
                    this.j.setVisibility(0);
                    this.p.setVisibility(0);
                    this.r.setVisibility(0);
                    this.l.setVisibility(8);
                    this.m.setVisibility(8);
                    this.f.setVisibility(0);
                    this.t.setVisibility(0);
                    this.t.setImageResource(2131231134);
                    this.t.setContentDescription(this.getString(2131952249));
                    this.s.setVisibility(0);
                } else {
                    this.g.setVisibility(8);
                    this.h.setVisibility(0);
                    this.i.setVisibility(0);
                    this.j.setVisibility(0);
                    this.p.setVisibility(0);
                    this.r.setVisibility(0);
                    this.l.setVisibility(8);
                    this.m.setVisibility(8);
                    this.f.setVisibility(0);
                    this.t.setVisibility(0);
                    this.t.setImageResource(2131231112);
                    this.t.setContentDescription(this.getString(2131952236));
                    this.s.setVisibility(0);
                }
            } else {
                this.g.setVisibility(0);
                this.h.setVisibility(8);
                this.i.setVisibility(8);
                this.j.setVisibility(8);
                this.f.setVisibility(8);
            }
        } else {
            this.g.setVisibility(8);
            this.h.setVisibility(8);
            this.i.setVisibility(0);
            this.j.setVisibility(0);
            this.p.setVisibility(8);
            this.r.setVisibility(8);
            this.l.setVisibility(8);
            this.m.setVisibility(8);
            this.f.setVisibility(8);
            this.t.setVisibility(8);
            this.s.setVisibility(8);
        }
        this.g4();
        return;
    }

    static synthetic void n0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, int p1)
    {
        p0.U3(p1);
        return;
    }

    static synthetic void n1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.p2();
        return;
    }

    private void n2(long p3, boolean p5, boolean p6)
    {
        if (p6 != 0) {
            this.A.setText(ax.q3.A.q(p3));
        }
        int v3_2;
        this.u0 = p3;
        if (this.v0 == p5) {
            v3_2 = 0;
        } else {
            v3_2 = 1;
        }
        this.v0 = p5;
        long v4_0 = System.currentTimeMillis();
        if ((v3_2 != 0) || ((v4_0 - this.t0) >= this.w1)) {
            this.o4(v3_2);
            return;
        } else {
            return;
        }
    }

    private void n3()
    {
        if ((this.W != null) && (this.w2() < (this.C2() - 1))) {
            this.s3();
        }
        return;
    }

    private void n4()
    {
        int v3;
        android.view.View v0_0 = this.C2();
        int v1 = 0;
        if (v0_0 <= null) {
            v3 = 0;
        } else {
            v3 = 1;
        }
        if (this.w2() < (v0_0 - 1)) {
            v1 = 1;
        }
        this.E3(v3, this.o);
        this.E3(v1, this.n);
        return;
    }

    static synthetic boolean o0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.z1;
    }

    static synthetic androidx.media3.exoplayer.ExoPlayer o1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.W;
    }

    private void o2()
    {
        this.s0 = 0;
        this.A.setText("");
        if (!this.q0) {
            this.b.setUseController(1);
        }
        if (this.r0) {
            androidx.media3.exoplayer.ExoPlayer v1_1 = this.W;
            if (v1_1 != null) {
                v1_1.L(1);
            }
        }
        this.o4(0);
        this.t0 = 0;
        this.u0 = 0;
        this.m4();
        return;
    }

    private void o3()
    {
        if (this.W != null) {
            if (this.w2() >= (this.C2() - 1)) {
                this.q3();
                return;
            } else {
                this.s3();
                return;
            }
        } else {
            return;
        }
    }

    private void o4(boolean p6)
    {
        long v0_0 = this.W;
        if (v0_0 != 0) {
            long v0_5 = v0_0.k0();
            if (((p6 != null) || ((v0_5 >= this.u0) || (!this.v0))) && ((p6 != null) || ((v0_5 <= this.u0) || (this.v0)))) {
                if (!this.v0) {
                    this.W.a(ax.X0.Y.f);
                } else {
                    this.W.a(ax.X0.Y.e);
                }
                this.W.s(this.u0);
                this.W.a(ax.X0.Y.g);
                this.t0 = System.currentTimeMillis();
                return;
            }
        }
        return;
    }

    static synthetic void p0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.r2();
        return;
    }

    static synthetic void p1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, long p1, boolean p3, boolean p4)
    {
        p0.n2(p1, p3, p4);
        return;
    }

    private void p2()
    {
        if (this.W != null) {
            this.s0 = 1;
            androidx.media3.exoplayer.ExoPlayer v0_8 = this.b.I();
            this.q0 = v0_8;
            if (v0_8 == null) {
                this.b.setUseController(0);
                this.b.setControllerAutoShow(0);
            }
            androidx.media3.exoplayer.ExoPlayer v0_4 = this.W.b();
            this.r0 = v0_4;
            if (v0_4 != null) {
                this.W.L(0);
            }
        }
        return;
    }

    private void p3(float p5, float p6, float p7)
    {
        if (this.d3()) {
            float v0_4 = this.W.G();
            androidx.media3.ui.AspectRatioFrameLayout v1_0 = ((int) (((float) v0_4.a()) * p5));
            int v2_1 = this.b.getHeight();
            if (v1_0 > v2_1) {
                this.F.setTranslationY(this.Z1(((float) v1_0), v2_1, this.F.getTranslationY(), p7));
            }
            float v5_1 = ((int) (((float) v0_4.b()) * p5));
            int v7_6 = this.b.getWidth();
            if (v5_1 > v7_6) {
                this.F.setTranslationX(this.Z1(((float) v5_1), v7_6, this.F.getTranslationX(), p6));
                return;
            } else {
                return;
            }
        } else {
            this.f2();
            return;
        }
    }

    private void p4()
    {
        if (this.e.n0()) {
            if (!this.X2()) {
                if (!this.r1) {
                    this.I3(0);
                } else {
                    this.I3(1);
                }
            } else {
                this.I3(0);
            }
        } else {
            this.I3(1);
        }
        this.g4();
        return;
    }

    static synthetic void q0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, float p1, boolean p2)
    {
        p0.K3(p1, p2);
        return;
    }

    static synthetic long q1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, long p1)
    {
        p0.u0 = p1;
        return p1;
    }

    private android.view.View q2()
    {
        this.I.setTouchscreenBlocksFocus(0);
        android.view.View v0_2 = this.I.getChildAt(0);
        if (!(v0_2 instanceof androidx.appcompat.widget.p)) {
            ax.q3.b.e("not work anymore");
            return v0_2;
        } else {
            if ((this.I.getNavigationContentDescription() == null) || (!this.I.getNavigationContentDescription().equals(v0_2.getContentDescription()))) {
                ax.q3.b.e("not work anymore");
                return v0_2;
            } else {
                v0_2.setId(16908332);
                return v0_2;
            }
        }
    }

    private void q3()
    {
        if (this.h3()) {
            this.z4();
        }
        this.G3(0);
        this.r3(this.w2(), 1);
        return;
    }

    private void q4()
    {
        android.widget.ImageButton v0_0 = this.W;
        if (v0_0 != null) {
            android.widget.ImageButton v0_5 = v0_0.o();
            if (v0_5 == null) {
                this.k.setImageDrawable(this.T0);
                this.k.setContentDescription(this.d1);
                return;
            } else {
                if (v0_5 == 1) {
                    this.k.setImageDrawable(this.U0);
                    this.k.setContentDescription(this.e1);
                    return;
                } else {
                    if (v0_5 == 2) {
                        this.k.setImageDrawable(this.V0);
                        this.k.setContentDescription(this.f1);
                        return;
                    } else {
                        return;
                    }
                }
            }
        } else {
            this.k.setImageDrawable(this.T0);
            this.k.setContentDescription(this.d1);
            return;
        }
    }

    static synthetic java.util.logging.Logger r0()
    {
        return com.alphainventor.filemanager.viewer.VideoPlayerActivity.R1;
    }

    static synthetic android.widget.TextView r1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.A;
    }

    private void r2()
    {
        this.A1.removeCallbacks(this.J1);
        this.b.setUseController(0);
        this.finish();
        return;
    }

    private void r3(int p2, boolean p3)
    {
        if ((p2 >= null) && (p2 < this.C2())) {
            if (this.W != null) {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity$v v0_7 = this.G1;
                if ((v0_7 != null) && ((!v0_7.isCancelled()) && (ax.q3.q.n(this.G1)))) {
                    this.G1.e();
                }
                com.alphainventor.filemanager.viewer.VideoPlayerActivity$v v0_4 = new com.alphainventor.filemanager.viewer.VideoPlayerActivity$v(this, p2, p3);
                this.G1 = v0_4;
                Void[] v2_2 = new Void[0];
                v0_4.i(v2_2);
                return;
            } else {
                return;
            }
        } else {
            ax.q3.b.f();
            return;
        }
    }

    private void r4()
    {
        if (!this.d0) {
            this.x.setImageDrawable(this.Y0);
            this.x.setContentDescription(this.j1);
            return;
        } else {
            this.x.setImageDrawable(this.Z0);
            this.x.setContentDescription(this.i1);
            return;
        }
    }

    static synthetic boolean s0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.f3();
    }

    static synthetic boolean s1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.W2();
    }

    private String s2(String p9, java.util.List p10)
    {
        if (ax.W2.Y.z(p9)) {
            if (p10 != null) {
                String v9_4 = ax.W2.Y.l(p9);
                String[] v0_4 = ax.W2.v.o();
                int v2_1 = v0_4.length;
                int v3 = 0;
                while (v3 < v2_1) {
                    String v4_0 = v0_4[v3];
                    java.util.Iterator v5_1 = new StringBuilder();
                    v5_1.append(v9_4);
                    v5_1.append(".");
                    v5_1.append(v4_0);
                    String v4_1 = v5_1.toString();
                    java.util.Iterator v5_2 = p10.iterator();
                    while (v5_2.hasNext()) {
                        com.alphainventor.filemanager.file.n v6_3 = ((com.alphainventor.filemanager.file.n) v5_2.next());
                        if (v4_1.equals(v6_3.E())) {
                            return v6_3.B();
                        }
                    }
                    v3++;
                }
                return 0;
            } else {
                return 0;
            }
        } else {
            ax.za.b v10_3 = ax.za.c.h().f().b("Invalid media path 3");
            String[] v0_3 = new StringBuilder();
            v0_3.append("path:");
            v0_3.append(p9);
            v10_3.g(v0_3.toString()).h();
            return 0;
        }
    }

    private void s3()
    {
        if (this.w2() < this.C2()) {
            if (this.h3()) {
                this.z4();
            }
            this.G3((this.w2() + 1));
            this.r3(this.w2(), 1);
            return;
        } else {
            ax.q3.b.e("bad index");
            return;
        }
    }

    private void s4()
    {
        long v0_0 = this.W;
        if (v0_0 != 0) {
            this.m1 = v0_0.r();
            this.n1 = this.W.I();
            this.o1 = Math.max(0, this.W.N());
        }
        return;
    }

    static synthetic void t0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.S3(p1);
        return;
    }

    static synthetic void t1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, float p1, float p2, float p3, float p4, float p5)
    {
        p0.A4(p1, p2, p3, p4, p5);
        return;
    }

    private android.net.Uri t2(android.net.Uri p7)
    {
        java.util.logging.Logger v0_0 = p7.toString();
        if (!"file".equals(p7.getScheme())) {
            android.net.Uri v1_0 = 0;
            if (!v0_0.startsWith("content://media")) {
                if (!"content".equals(p7.getScheme())) {
                    if (com.alphainventor.filemanager.service.b.k(this, p7)) {
                        java.util.logging.Logger v0_6 = ax.k3.c.z(p7.getPath());
                        StringBuilder v3_1 = ax.W2.Y.r(p7.getPath());
                        java.util.List v4_0 = ax.k3.c.z(v3_1);
                        if ((v4_0 != null) && ((v0_6 != null) && (ax.W2.s.e(v4_0.d()).a()))) {
                            java.util.List v4_2 = ax.T2.b.k().h(v4_0.toString());
                            if (v4_2 != null) {
                                java.util.logging.Logger v0_8 = this.s2(v0_6.e(), v4_2);
                                if (v0_8 != null) {
                                    android.net.Uri v1_2 = p7.buildUpon();
                                    v1_2.path(ax.W2.Y.N(v3_1, v0_8));
                                    v1_0 = v1_2.build();
                                    StringBuilder v3_3 = new StringBuilder();
                                    v3_3.append("subtitle uri : ");
                                    v3_3.append(v1_0);
                                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.R1.fine(v3_3.toString());
                                }
                            }
                        }
                    }
                    String v2_5 = new StringBuilder();
                    v2_5.append("media uri : ");
                    v2_5.append(p7);
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.R1.fine(v2_5.toString());
                    return v1_0;
                } else {
                    String v7_3 = this.u2(this, p7);
                    android.net.Uri v1_6 = new StringBuilder();
                    v1_6.append("subtitle uri : ");
                    v1_6.append(v7_3);
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.R1.fine(v1_6.toString());
                    return v7_3;
                }
            } else {
                String v7_4 = ax.W2.I.a(this, p7);
                if (v7_4 == null) {
                    return 0;
                } else {
                    return this.v2(v7_4);
                }
            }
        } else {
            return this.v2(p7.getPath());
        }
    }

    private void t3()
    {
        if (this.w2() > 0) {
            if (this.h3()) {
                this.z4();
            }
            this.G3((this.w2() - 1));
            this.r3(this.w2(), 1);
            return;
        } else {
            return;
        }
    }

    static synthetic void u0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.R3();
        return;
    }

    static synthetic boolean u1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.z0 = p1;
        return p1;
    }

    private android.net.Uri u2(android.content.Context p9, android.net.Uri p10)
    {
        String v0_0 = p10.getPath();
        if (ax.W2.Y.z(v0_0)) {
            String v0_1 = ax.W2.Y.l(v0_0);
            android.content.ContentResolver v9_5 = p9.getContentResolver();
            String[] v1_0 = ax.W2.v.o();
            int v3 = v1_0.length;
            int v4 = 0;
            while (v4 < v3) {
                android.net.Uri v5_0 = v1_0[v4];
                android.os.ParcelFileDescriptor v6_1 = new StringBuilder();
                v6_1.append(v0_1);
                v6_1.append(".");
                v6_1.append(v5_0);
                android.net.Uri v5_3 = p10.buildUpon().path(v6_1.toString()).build();
                try {
                    try {
                        v9_5.openFileDescriptor(v5_3, "r").close();
                    } catch (java.io.IOException) {
                    }
                    return v5_3;
                } catch (Exception) {
                    v4++;
                }
            }
            return 0;
        } else {
            android.content.ContentResolver v9_3 = ax.za.c.h().f().b("Invalid media path 2");
            String v10_3 = new StringBuilder();
            v10_3.append("path:");
            v10_3.append(v0_0);
            v9_3.g(v10_3.toString()).h();
            return 0;
        }
    }

    private void u3()
    {
        int v0_0 = this.W;
        if (v0_0 != 0) {
            int v0_4 = v0_0.i();
            long v1_2 = this.W.k0();
            if ((this.w2() != 0) && ((v0_4 == 4) || (v1_2 <= 3000))) {
                if (this.w2() > 0) {
                    this.t3();
                }
            } else {
                this.W.s(0);
                return;
            }
        }
        return;
    }

    private void u4()
    {
        this.E3(this.j0, this.v);
        if (!this.j0) {
            this.v.setImageDrawable(this.W0);
            this.v.setContentDescription(this.h1);
            this.v.setVisibility(8);
            this.b.getSubtitleView().setVisibility(8);
            return;
        } else {
            if (!this.k0) {
                this.v.setImageDrawable(this.W0);
                this.v.setContentDescription(this.h1);
                this.v.setVisibility(0);
                this.b.getSubtitleView().setVisibility(8);
                return;
            } else {
                this.v.setImageDrawable(this.X0);
                this.v.setContentDescription(this.g1);
                this.v.setVisibility(0);
                this.b.getSubtitleView().setVisibility(0);
                return;
            }
        }
    }

    static synthetic int v0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.y1;
    }

    static synthetic void v1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.B4();
        return;
    }

    private android.net.Uri v2(String p8)
    {
        if (ax.W2.Y.z(p8)) {
            android.net.Uri v8_4 = ax.W2.Y.l(p8);
            String[] v0_4 = ax.W2.v.o();
            int v2_3 = v0_4.length;
            int v3_0 = 0;
            while (v3_0 < v2_3) {
                boolean v4_0 = v0_4[v3_0];
                java.io.File v5_1 = new StringBuilder();
                v5_1.append(v8_4);
                v5_1.append(".");
                v5_1.append(v4_0);
                java.io.File v5_3 = new java.io.File(v5_1.toString());
                if (!v5_3.exists()) {
                    v3_0++;
                } else {
                    return android.net.Uri.fromFile(v5_3);
                }
            }
            return 0;
        } else {
            String[] v0_3 = ax.za.c.h().f().b("Invalid media path 1");
            int v2_2 = new StringBuilder();
            v2_2.append("path:");
            v2_2.append(p8);
            v0_3.g(v2_2.toString()).h();
            return 0;
        }
    }

    private void v4()
    {
        String v0_0 = this.x2();
        if (v0_0 != null) {
            if ((!"file".equals(v0_0.getScheme())) && ((!ax.W2.w.J(v0_0.getScheme())) && (!com.alphainventor.filemanager.provider.MyFileProvider.x(v0_0)))) {
                if ("content".equals(v0_0.getScheme())) {
                    this.O3(ax.W2.w.u(this, v0_0).a);
                }
                return;
            } else {
                if (v0_0.getPath() == null) {
                    this.O3("");
                    return;
                } else {
                    this.O3(ax.W2.Y.h(v0_0.getPath()));
                    return;
                }
            }
        } else {
            this.O3("");
            return;
        }
    }

    static synthetic android.os.Handler w0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.A1;
    }

    static synthetic void w1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.b2();
        return;
    }

    private int w2()
    {
        int v0_0 = this.i0;
        if (v0_0 >= 0) {
            if (v0_0 < this.C2()) {
                return this.i0;
            } else {
                ax.q3.b.f();
                return (this.C2() - 1);
            }
        } else {
            ax.q3.b.f();
            return 0;
        }
    }

    private void w3()
    {
        return;
    }

    private void w4()
    {
        ax.g1.n$e v0_0 = this.N0;
        if (v0_0 != null) {
            this.O0 = v0_0.K();
        }
        return;
    }

    static synthetic android.net.Uri x0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.y2();
    }

    static synthetic void x1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.m2(p1);
        return;
    }

    private android.net.Uri x2()
    {
        if (this.Z != null) {
            android.net.Uri v0_4 = this.A2(this.w2());
            if (v0_4 >= null) {
                android.net.Uri[] v2 = this.Z;
                if (v0_4 < v2.length) {
                    return v2[v0_4];
                }
            }
            ax.q3.b.e("what case is this");
            return 0;
        } else {
            ax.q3.b.f();
            return 0;
        }
    }

    private void x3()
    {
        int v0_0 = this.X;
        if (v0_0 != 0) {
            v0_0.d();
            this.X = 0;
        }
        return;
    }

    private void x4()
    {
        this.C0 = 0;
        this.B.setVisibility(8);
        return;
    }

    static synthetic boolean y0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.u1;
    }

    static synthetic void y1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        p0.b4();
        return;
    }

    private android.net.Uri y2()
    {
        if (this.a0 != null) {
            return this.a0[this.A2(this.w2())];
        } else {
            ax.q3.b.f();
            return 0;
        }
    }

    private void y3()
    {
        if (this.W != null) {
            this.w4();
            this.s4();
            this.W.d();
            this.W = 0;
            this.Y = 0;
            this.N0 = 0;
        }
        if (ax.R2.Q.f1()) {
            this.x3();
        }
        return;
    }

    private void y4()
    {
        if (this.B0 == null) {
            android.widget.ProgressBar v0_11 = ((android.media.AudioManager) this.getSystemService("audio"));
            this.B0 = v0_11;
            if (v0_11 == null) {
                return;
            }
        }
        this.D0 = this.B0.getStreamMaxVolume(3);
        this.E0 = this.B0.getStreamVolume(3);
        this.C0 = 1;
        this.B.setVisibility(0);
        this.C.setImageResource(2131231197);
        this.D.setProgressDrawable(ax.o.a.b(this, 2131231543));
        this.D.setMax(this.D0);
        return;
    }

    static synthetic boolean z0(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0, boolean p1)
    {
        p0.u1 = p1;
        return p1;
    }

    static synthetic androidx.media3.ui.PlayerView z1(com.alphainventor.filemanager.viewer.VideoPlayerActivity p0)
    {
        return p0.b;
    }

    private String z2(String p4)
    {
        int v0_0 = ax.s3.f.b(p4);
        if (!android.text.TextUtils.isEmpty(v0_0)) {
            p4 = v0_0;
        }
        Object[] v1_2 = new Object[1];
        v1_2[0] = p4;
        return this.getString(2131951943, v1_2);
    }

    private void z4()
    {
        this.A0 = 0;
        this.y0 = 1065353216;
        this.f2();
        return;
    }

    public String D2()
    {
        if (this.p1 == null) {
            this.p1 = ax.S0.c0.s0(this, "CxFileExplorer");
        }
        return this.p1;
    }

    public void I3(boolean p2)
    {
        int v2_1;
        if (p2 == 0) {
            v2_1 = 1792;
        } else {
            v2_1 = 3846;
        }
        this.q1 = v2_1;
        this.a.setSystemUiVisibility(v2_1);
        return;
    }

    public void T(int p2)
    {
        this.p4();
        if (p2 == 8) {
            this.l2();
            this.D1.d();
        }
        if (p2 == 0) {
            int v2_2 = this.G;
            if (v2_2 != 0) {
                v2_2.x();
                this.G = 0;
            }
        }
        return;
    }

    public void Y3()
    {
        this.v3();
        return;
    }

    public ax.P0.H c()
    {
        return this.W;
    }

    public boolean dispatchKeyEvent(android.view.KeyEvent p8)
    {
        androidx.media3.ui.PlayerView v5_2;
        boolean v0_0 = p8.getKeyCode();
        int v1 = p8.getAction();
        boolean v2_3 = this.getCurrentFocus();
        if ((v1 != 0) && ((v1 != 1) || (this.E1 != 0))) {
            v5_2 = 0;
        } else {
            v5_2 = 1;
        }
        if (v1 != 0) {
            if (v1 == 1) {
                this.E1 = 0;
            }
        } else {
            this.E1 = v0_0;
        }
        if ((this.F1 != v0_0) || (v1 != 1)) {
            if (v5_2 != null) {
                if (v0_0 != 20) {
                    if (v0_0 != 19) {
                        if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.U2(v0_0)) {
                            if ((v0_0 != 85) && (v0_0 != 62)) {
                                if (v0_0 != 126) {
                                    if ((v0_0 != 127) || ((v2_3 != this.b) || (ax.S0.c0.o1(this.W)))) {
                                        if ((!this.b.dispatchKeyEvent(p8)) && (!super.dispatchKeyEvent(p8))) {
                                            return 0;
                                        } else {
                                            return 1;
                                        }
                                    } else {
                                        this.b.setControllerAutoShow(0);
                                        this.T3(0);
                                        ax.S0.c0.u0(this.W);
                                        this.b.setControllerAutoShow(1);
                                    }
                                } else {
                                    if ((v2_3 != this.b) || (!ax.S0.c0.o1(this.W))) {
                                    } else {
                                        this.b.setControllerAutoShow(0);
                                        this.T3(1);
                                        ax.S0.c0.v0(this.W);
                                        this.b.setControllerAutoShow(1);
                                    }
                                }
                            } else {
                                androidx.media3.ui.PlayerView v5_12 = this.b;
                                if (v2_3 != v5_12) {
                                } else {
                                    v5_12.setControllerAutoShow(0);
                                    this.T3(ax.S0.c0.o1(this.W));
                                    ax.S0.c0.w0(this.W);
                                    this.b.setControllerAutoShow(1);
                                }
                            }
                        } else {
                            if (v2_3 != this.b) {
                            } else {
                                this.b4();
                            }
                        }
                    } else {
                        if (v2_3 != this.b) {
                            if ((!ax.q3.y.s(this.f, v2_3)) || (v1 != 0)) {
                            } else {
                                if (this.e.n0()) {
                                    this.Z3();
                                }
                            }
                        } else {
                            if (!this.e.n0()) {
                                androidx.media3.ui.PlayerView v8_21 = this.q2();
                                this.e.v0();
                                v8_21.requestFocus();
                            }
                        }
                    }
                } else {
                    if (v2_3 != this.b) {
                        if ((!ax.q3.y.s(this.I, v2_3)) || (v1 != 0)) {
                        } else {
                            if (this.e.n0()) {
                                this.Z3();
                            }
                        }
                    } else {
                        if (!this.e.n0()) {
                            this.e.v0();
                        }
                    }
                }
                if (v1 == 0) {
                    this.F1 = v0_0;
                }
                return 1;
            }
        } else {
            this.F1 = 0;
            return 1;
        }
    }

    public void finish()
    {
        if (!this.f3()) {
            this.H3();
        } else {
            if (!this.z1) {
                this.setResult(-1);
            } else {
                this.setResult(0);
            }
        }
        super.finish();
        if ((this.f3()) && (!this.z1)) {
            this.overridePendingTransition(2130772017, 2130772018);
        }
        return;
    }

    public androidx.media3.ui.d j()
    {
        return this.e;
    }

    ax.g1.n$e j2()
    {
        ax.g1.n$e v0_1 = new ax.g1.n$f(this);
        v0_1.c0(this.Q);
        v0_1.a0(this.Q);
        v0_1.f0(1);
        return v0_1.V();
    }

    public void onConfigurationChanged(android.content.res.Configuration p1)
    {
        super.onConfigurationChanged(p1);
        this.h4();
        return;
    }

    public void onCreate(android.os.Bundle p6)
    {
        ax.K2.b.f(this, 1);
        super.onCreate(p6);
        if (ax.R2.Q.M0()) {
            this.y1 = this.getIntent().getIntExtra("slide_interval", -1);
            this.overridePendingTransition(17432576, 17432577);
            try {
                int v1_11 = this.W1();
                this.U = v1_11;
                com.alphainventor.filemanager.viewer.VideoPlayerActivity$l v2_1 = new ax.e1.X$b(v1_11);
                this.V = v2_1;
                this.setContentView(2131558440);
                this.a = this.findViewById(2131362732);
                this.T = ((android.widget.TextView) this.findViewById(2131362097));
                int v1_42 = ((androidx.appcompat.widget.Toolbar) this.findViewById(2131362964));
                this.I = v1_42;
                this.setSupportActionBar(v1_42);
                int v1_47 = this.getResources().getConfiguration().locale;
            } catch (SecurityException) {
                ax.za.c.h().f().d("VIDEO PLAYER BUILD SOURCE").h();
                android.widget.Toast.makeText(this, v2_1, 1).show();
                this.finish();
                return;
            }
            if (v1_47 == 0) {
                this.Q = java.util.Locale.getDefault().toLanguageTag();
            } else {
                this.Q = v1_47.toLanguageTag();
            }
            this.D1 = new com.alphainventor.filemanager.viewer.f(this, this);
            int v1_56 = ((androidx.media3.ui.PlayerView) this.findViewById(2131362687));
            this.b = v1_56;
            if ((v1_56.getVideoSurfaceView() instanceof android.view.SurfaceView)) {
                ((android.view.SurfaceView) this.b.getVideoSurfaceView()).getHolder().addCallback(new com.alphainventor.filemanager.viewer.VideoPlayerActivity$k(this));
            }
            this.b.setControllerVisibilityListener(this);
            this.b.setErrorMessageProvider(new com.alphainventor.filemanager.viewer.VideoPlayerActivity$w(this, 0));
            this.b.requestFocus();
            this.H = this.findViewById(2131362698);
            this.F = ((androidx.media3.ui.AspectRatioFrameLayout) this.findViewById(2131362201));
            int v1_5 = ((androidx.media3.ui.d) this.findViewById(2131362202));
            this.e = v1_5;
            v1_5.setFitsSystemWindows(1);
            this.A = ((android.widget.TextView) this.findViewById(2131362155));
            this.B = this.findViewById(2131362153);
            this.C = ((android.widget.ImageView) this.findViewById(2131363013));
            this.D = ((android.widget.ProgressBar) this.findViewById(2131363012));
            this.E = ((android.widget.TextView) this.findViewById(2131362024));
            this.f = ((android.view.ViewGroup) this.findViewById(2131361988));
            this.g = this.findViewById(2131362062);
            this.h = this.findViewById(2131362063);
            this.i = this.findViewById(2131362064);
            this.j = this.findViewById(2131362066);
            String v0_27 = this.findViewById(2131362078);
            this.m = v0_27;
            v0_27.setOnClickListener(this.O1);
            String v0_29 = this.findViewById(2131362080);
            this.l = v0_29;
            v0_29.setOnClickListener(this.O1);
            String v0_32 = ((android.widget.ImageButton) this.findViewById(2131362083));
            this.k = v0_32;
            v0_32.setOnClickListener(this.O1);
            String v0_34 = this.findViewById(2131362081);
            this.n = v0_34;
            v0_34.setOnClickListener(this.O1);
            String v0_36 = this.findViewById(2131362082);
            this.o = v0_36;
            v0_36.setOnClickListener(this.O1);
            String v0_38 = this.findViewById(2131362079);
            this.p = v0_38;
            v0_38.setOnClickListener(this.O1);
            String v0_40 = this.findViewById(2131362090);
            this.q = v0_40;
            v0_40.setOnClickListener(this.O1);
            String v0_42 = this.findViewById(2131362085);
            this.s = v0_42;
            v0_42.setOnClickListener(this.O1);
            String v0_45 = ((android.widget.ImageButton) this.findViewById(2131362084));
            this.r = v0_45;
            v0_45.setOnClickListener(this.O1);
            String v0_48 = ((android.widget.ImageView) this.findViewById(2131362089));
            this.t = v0_48;
            v0_48.setOnClickListener(this.O1);
            String v0_51 = ((androidx.appcompat.widget.MySpinner) this.findViewById(2131362087));
            this.y = v0_51;
            v0_51.setPromptId(2131952486);
            String v0_53 = new com.alphainventor.filemanager.viewer.d(this);
            this.y.setAdapter(v0_53);
            this.y.setOnItemSelectedListener(new com.alphainventor.filemanager.viewer.VideoPlayerActivity$l(this, v0_53));
            String v0_56 = ((android.widget.ImageButton) this.findViewById(2131362077));
            this.u = v0_56;
            v0_56.setOnClickListener(this.O1);
            String v0_59 = ((android.widget.ImageButton) this.findViewById(2131362088));
            this.v = v0_59;
            v0_59.setOnClickListener(this.O1);
            String v0_62 = ((android.widget.ImageButton) this.findViewById(2131362086));
            this.x = v0_62;
            v0_62.setOnClickListener(this.O1);
            this.w = ((android.widget.ImageButton) this.findViewById(2131362223));
            this.z = this.findViewById(2131362178);
            this.J = ((android.view.ViewGroup) this.findViewById(2131361874));
            this.K = ((android.view.ViewGroup) this.findViewById(2131361873));
            this.L = this.findViewById(2131361872);
            this.M = this.findViewById(2131361875);
            this.L.setOnClickListener(new com.alphainventor.filemanager.viewer.VideoPlayerActivity$m(this));
            String v0_81 = ((androidx.media3.ui.b) this.b.findViewById(2131362227));
            this.S = v0_81;
            v0_81.a(this.K1);
            this.a.setOnSystemUiVisibilityChangeListener(new com.alphainventor.filemanager.viewer.VideoPlayerActivity$n(this));
            this.w0 = ax.q3.A.e(this, 30);
            this.x0 = ax.q3.A.e(this, 35);
            this.I0 = ax.p3.a.b();
            this.K2();
            this.H2();
            if (p6 == 0) {
                this.O0 = this.j2();
                this.g2();
            } else {
                String v0_89 = p6.getBundle("track_selector_parameters");
                if (v0_89 != null) {
                    this.O0 = ax.g1.n$e.Q(v0_89);
                }
                if (this.O0 == null) {
                    this.O0 = this.j2();
                }
                this.m1 = p6.getBoolean("auto_play");
                this.n1 = p6.getInt("window", -1);
                this.o1 = p6.getLong("position", -1);
                this.p0 = p6.getFloat("speed", 1065353216);
            }
            this.getOnBackPressedDispatcher().h(this, this.I1);
            this.B1 = ax.q3.A.e(this, 40);
            this.C1 = ax.q3.A.e(this, 52);
            this.getSupportFragmentManager().l1("dialog_dismiss_request", this, new com.alphainventor.filemanager.viewer.VideoPlayerActivity$o(this));
            return;
        } else {
            ax.za.c.h().f().d("VIDEO PLAYER NOT SUPPORTED").h();
            android.widget.Toast.makeText(this, 2131951922, 1).show();
            this.finish();
            return;
        }
    }

    public boolean onCreateOptionsMenu(android.view.Menu p3)
    {
        this.getMenuInflater().inflate(2131689509, p3);
        return 1;
    }

    public void onDestroy()
    {
        this.w3();
        if ((this.s1) && (this.t1 != null)) {
            com.alphainventor.filemanager.service.b.f(this).l(0, this.t1);
        }
        if (this.N != null) {
            this.e2();
        }
        super.onDestroy();
        return;
    }

    public void onNewIntent(android.content.Intent p1)
    {
        super.onNewIntent(p1);
        this.y3();
        this.w3();
        this.g2();
        this.setIntent(p1);
        return;
    }

    public boolean onOptionsItemSelected(android.view.MenuItem p3)
    {
        int v3_1 = p3.getItemId();
        if (v3_1 == 16908332) {
            this.finish();
            return 1;
        } else {
            if (v3_1 == 2131362531) {
                this.X3();
                return 1;
            } else {
                if (v3_1 == 2131362536) {
                    this.a4();
                    return 1;
                } else {
                    return 0;
                }
            }
        }
    }

    public void onPause()
    {
        super.onPause();
        if (ax.S0.c0.a <= 23) {
            android.view.View v0_1 = this.b;
            if (v0_1 != null) {
                v0_1.P();
            }
            this.y3();
        }
        android.view.View v0_2 = this.N;
        if ((v0_2 != null) && (!this.O)) {
            ax.M2.b.c(v0_2, this);
        }
        return;
    }

    public boolean onPrepareOptionsMenu(android.view.Menu p3)
    {
        android.view.MenuItem v0_1 = p3.findItem(2131362536);
        if (v0_1 != null) {
            v0_1.setVisible(0);
        }
        return super.onPrepareOptionsMenu(p3);
    }

    public void onRequestPermissionsResult(int p1, String[] p2, int[] p3)
    {
        super.onRequestPermissionsResult(p1, p2, p3);
        if (p3.length != 0) {
            if (p3[0] != 0) {
                this.V3(2131951924);
                this.finish();
                return;
            } else {
                this.M2();
                return;
            }
        } else {
            return;
        }
    }

    public void onResume()
    {
        super.onResume();
        if ((ax.S0.c0.a <= 23) || (this.W == null)) {
            this.M2();
            android.view.View v0_3 = this.b;
            if (v0_3 != null) {
                v0_3.Q();
            }
        }
        android.view.View v0_1 = this.N;
        if ((v0_1 != null) && (!this.O)) {
            ax.M2.b.l(v0_1, this);
        }
        return;
    }

    public void onSaveInstanceState(android.os.Bundle p4)
    {
        super.onSaveInstanceState(p4);
        this.w4();
        this.s4();
        String v0_3 = this.O0;
        if (v0_3 != null) {
            p4.putBundle("track_selector_parameters", v0_3.J());
        }
        p4.putBoolean("auto_play", this.m1);
        p4.putInt("window", this.n1);
        p4.putLong("position", this.o1);
        p4.putFloat("speed", this.p0);
        return;
    }

    public void onStart()
    {
        super.onStart();
        if (ax.S0.c0.a > 23) {
            this.M2();
            android.view.Window v0_3 = this.b;
            if (v0_3 != null) {
                v0_3.Q();
            }
        }
        if (ax.R2.Q.L1()) {
            ax.R2.v.s(this.getWindow(), -1157627904);
            ax.R2.v.r(this.getWindow(), -1157627904);
        }
        return;
    }

    public void onStop()
    {
        super.onStop();
        if (ax.S0.c0.a > 23) {
            androidx.media3.ui.PlayerView v0_1 = this.b;
            if (v0_1 != null) {
                v0_1.P();
            }
            this.y3();
        }
        return;
    }

    public void t4()
    {
        this.N3(ax.p3.m.g(this), 1);
        return;
    }

    public void v3()
    {
        androidx.media3.ui.PlayerView v0 = this.b;
        if (v0 != null) {
            v0.P();
        }
        this.y3();
        this.M2();
        return;
    }

    public void z3()
    {
        this.r3(this.w2(), 1);
        return;
    }
}
