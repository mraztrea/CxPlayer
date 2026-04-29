// Decompiled from: Lcom/google/android/exoplayer2/ext/ffmpeg/a;
// Package: com.google.android.exoplayer2.ext.ffmpeg

package com.google.android.exoplayer2.ext.ffmpeg;
public final class a extends ax.V0.k {
    private final String o;
    private final byte[] p;
    private final int q;
    private final int r;
    private long s;
    private boolean t;
    private volatile int u;
    private volatile int v;
    private int w;
    private boolean x;
    private com.google.android.exoplayer2.ext.ffmpeg.FfmpegDecoder y;

    public a(boolean p8, ax.P0.v p9, int p10, int p11, int p12, boolean p13, int p14)
    {
        long v10_1 = new ax.V0.i[p10];
        ax.V0.l[] v11_1 = new ax.V0.l[p11];
        super(v10_1, v11_1);
        super.x = p8;
        super.y = new com.google.android.exoplayer2.ext.ffmpeg.FfmpegDecoder(p8);
        if (!com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.f()) {
            throw new com.google.android.exoplayer2.ext.ffmpeg.b("Failed to load decoder native libraries.");
        } else {
            try {
                com.google.android.exoplayer2.ext.ffmpeg.b v8_3 = p9.o;
            } catch (Error) {
                throw new com.google.android.exoplayer2.ext.ffmpeg.b("Initialization failed.");
            }
            if (v8_3 == null) {
                throw new com.google.android.exoplayer2.ext.ffmpeg.b("audio decoder sample mime type null.");
            } else {
                String v2 = com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.c(v8_3);
                super.o = v2;
                if (v2 == null) {
                    throw new com.google.android.exoplayer2.ext.ffmpeg.b("audio decoder codecName null.");
                } else {
                    com.google.android.exoplayer2.ext.ffmpeg.b v8_9;
                    byte[] v3 = com.google.android.exoplayer2.ext.ffmpeg.a.F(p9.o, p9.r);
                    super.p = v3;
                    if (p13 == 0) {
                        v8_9 = 2;
                    } else {
                        v8_9 = 4;
                    }
                    com.google.android.exoplayer2.ext.ffmpeg.b v8_10;
                    super.q = v8_9;
                    if (p13 == 0) {
                        v8_10 = 65536;
                    } else {
                        v8_10 = 131072;
                    }
                    super.r = v8_10;
                    com.google.android.exoplayer2.ext.ffmpeg.b v8_11 = super.y.d(v2, v3, p13, p9.H, p9.G);
                    super.s = v8_11;
                    if (v8_11 == 0) {
                        throw new com.google.android.exoplayer2.ext.ffmpeg.b("Initialization failed.");
                    } else {
                        super.w = p14;
                        super.x(p12);
                        return;
                    }
                }
            }
        }
    }

    private static byte[] C(java.util.List p3)
    {
        byte[] v3_3 = ((byte[]) p3.get(0));
        int v1_2 = (v3_3.length + 12);
        java.nio.ByteBuffer v2 = java.nio.ByteBuffer.allocate(v1_2);
        v2.putInt(v1_2);
        v2.putInt(1634492771);
        v2.putInt(0);
        v2.put(v3_3, 0, v3_3.length);
        return v2.array();
    }

    private static byte[] F(String p3, java.util.List p4)
    {
        p3.getClass();
        int v1 = -1;
        switch (p3.hashCode()) {
            case -1003765268:
                if (p3.equals("audio/vorbis")) {
                    v1 = 0;
                } else {
                }
                break;
            case -53558318:
                if (p3.equals("audio/mp4a-latm")) {
                    v1 = 1;
                } else {
                }
                break;
            case 1504470054:
                if (p3.equals("audio/alac")) {
                    v1 = 2;
                } else {
                }
                break;
            case 1504891608:
                if (p3.equals("audio/opus")) {
                    v1 = 3;
                } else {
                }
                break;
            default:
        }
        switch (v1) {
            case 0:
                return com.google.android.exoplayer2.ext.ffmpeg.a.I(p4);
            case 1:
            case 3:
                return ((byte[]) p4.get(0));
            case 2:
                return com.google.android.exoplayer2.ext.ffmpeg.a.C(p4);
            default:
                return 0;
        }
    }

    private static byte[] I(java.util.List p5)
    {
        int v1_1 = ((byte[]) p5.get(0));
        byte[] v5_2 = ((byte[]) p5.get(1));
        byte[] v3_2 = new byte[((v1_1.length + v5_2.length) + 6)];
        v3_2[0] = ((byte) (v1_1.length >> 8));
        v3_2[1] = ((byte) (v1_1.length & 255));
        System.arraycopy(v1_1, 0, v3_2, 2, v1_1.length);
        v3_2[(v1_1.length + 2)] = 0;
        v3_2[(v1_1.length + 3)] = 0;
        v3_2[(v1_1.length + 4)] = ((byte) (v5_2.length >> 8));
        v3_2[(v1_1.length + 5)] = ((byte) (v5_2.length & 255));
        System.arraycopy(v5_2, 0, v3_2, (v1_1.length + 6), v5_2.length);
        return v3_2;
    }

    public static synthetic void y(com.google.android.exoplayer2.ext.ffmpeg.a p0, ax.V0.j p1)
    {
        p0.u(p1);
        return;
    }

    protected com.google.android.exoplayer2.ext.ffmpeg.b A(Throwable p3)
    {
        return new com.google.android.exoplayer2.ext.ffmpeg.b("Unexpected decode error", p3);
    }

    protected com.google.android.exoplayer2.ext.ffmpeg.b B(ax.V0.i p9, ax.V0.l p10, boolean p11)
    {
        if (p11 != 0) {
            int v0_4 = this.y.f(this.s, this.p);
            this.s = v0_4;
            if (v0_4 == 0) {
                return new com.google.android.exoplayer2.ext.ffmpeg.b("Error resetting (see logcat).");
            }
        }
        java.nio.ByteBuffer v3_1 = ((java.nio.ByteBuffer) ax.S0.c0.h(p9.e0));
        if (v3_1 != null) {
            int v4 = v3_1.limit();
            java.nio.ByteBuffer v5 = p10.C(p9.g0, this.r);
            com.google.android.exoplayer2.ext.ffmpeg.b v9_2 = this.y.a(this.s, v3_1, v4, v5, this.r, this.w);
            if (v9_2 != -2) {
                if (v9_2 != -1) {
                    if (v9_2 != null) {
                        if (!this.t) {
                            this.u = this.y.b(this.s);
                            this.v = this.y.c(this.s);
                            if ((this.v == 0) && ("alac".equals(this.o))) {
                                ax.S0.a.e(this.p);
                                int v10_11 = new ax.S0.G(this.p);
                                v10_11.b0((this.p.length - 4));
                                this.v = v10_11.Q();
                            }
                            this.t = 1;
                        }
                        v5.position(0);
                        v5.limit(v9_2);
                        return 0;
                    } else {
                        p10.e0 = 1;
                        return 0;
                    }
                } else {
                    p10.e0 = 1;
                    return 0;
                }
            } else {
                return new com.google.android.exoplayer2.ext.ffmpeg.b("Error decoding (see logcat).");
            }
        } else {
            return new com.google.android.exoplayer2.ext.ffmpeg.b("Input data null.");
        }
    }

    public int D()
    {
        return this.u;
    }

    public int E()
    {
        return this.q;
    }

    public int G()
    {
        return this.w;
    }

    public int H()
    {
        return this.v;
    }

    public void d()
    {
        super.d();
        try {
            this.y.e(this.s);
        } catch (Error) {
        }
        this.s = 0;
        return;
    }

    public String getName()
    {
        String v0_1 = new StringBuilder();
        v0_1.append("ffmpeg");
        v0_1.append(com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.e());
        v0_1.append("-");
        v0_1.append(this.o);
        return v0_1.toString();
    }

    protected ax.V0.i j()
    {
        return new ax.V0.i(2, com.google.android.exoplayer2.ext.ffmpeg.FfmpegLibrary.d());
    }

    protected bridge synthetic ax.V0.j k()
    {
        return this.z();
    }

    protected bridge synthetic ax.V0.h l(Throwable p1)
    {
        return this.A(p1);
    }

    protected bridge synthetic ax.V0.h m(ax.V0.i p1, ax.V0.j p2, boolean p3)
    {
        return this.B(p1, ((ax.V0.l) p2), p3);
    }

    protected ax.V0.l z()
    {
        return new ax.V0.l(new ax.y5.a(this));
    }
}
