// Decompiled from: Lcom/alphainventor/filemanager/viewer/a;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public class a {
    private int a;
    private float b;
    private final android.os.Handler c;
    private final com.alphainventor.filemanager.viewer.a$b d;
    private boolean e;
    private boolean f;
    private boolean g;
    private android.view.MotionEvent h;
    private android.view.MotionEvent i;
    private android.view.MotionEvent j;
    private float k;
    private float l;
    private float m;
    private float n;
    private int o;
    private boolean p;

    public a(android.content.Context p3, float p4, com.alphainventor.filemanager.viewer.a$b p5)
    {
        this(p3, p5, 0, 0);
        this.o = ((int) (((float) android.view.ViewConfiguration.getLongPressTimeout()) * p4));
        return;
    }

    public a(android.content.Context p1, com.alphainventor.filemanager.viewer.a$b p2, android.os.Handler p3, int p4)
    {
        if (p3 == null) {
            this.c = new com.alphainventor.filemanager.viewer.a$a(this);
        } else {
            this.c = new com.alphainventor.filemanager.viewer.a$a(this, p3);
        }
        this.d = p2;
        this.f(p1);
        return;
    }

    static synthetic void a(com.alphainventor.filemanager.viewer.a p0)
    {
        p0.d();
        return;
    }

    private void b()
    {
        this.c.removeMessages(2);
        this.e = 0;
        this.g = 0;
        this.f = 0;
        return;
    }

    private void c()
    {
        this.c.removeMessages(2);
        this.g = 0;
        this.f = 0;
        return;
    }

    private void d()
    {
        this.f = 1;
        this.d.a(this.h);
        return;
    }

    private int e()
    {
        return this.o;
    }

    private void f(android.content.Context p4)
    {
        if (this.d == null) {
            throw new NullPointerException("OnGestureListener must not be null");
        } else {
            this.p = 1;
            int v4_7 = android.view.ViewConfiguration.get(p4);
            int v0_1 = v4_7.getScaledTouchSlop();
            int v1 = android.os.Build$VERSION.SDK_INT;
            if (v1 < 30) {
                if (v1 < 29) {
                    this.b = 1065353216;
                } else {
                    this.b = ax.s3.c.a();
                }
            } else {
                this.b = ax.s3.b.a(v4_7);
            }
            this.a = (v0_1 * v0_1);
            return;
        }
    }

    public boolean g(android.view.MotionEvent p13)
    {
        long v0_0 = p13.getAction();
        int v1_3 = this.i;
        if (v1_3 != 0) {
            v1_3.recycle();
        }
        int v4_0;
        this.i = android.view.MotionEvent.obtain(p13);
        long v0_13 = (v0_0 & 255);
        android.os.Handler v2_0 = 1;
        if (v0_13 != 6) {
            v4_0 = 0;
        } else {
            v4_0 = 1;
        }
        long v5_3;
        if (v4_0 == 0) {
            v5_3 = -1;
        } else {
            v5_3 = p13.getActionIndex();
        }
        boolean v6_0 = p13.getPointerCount();
        float v7_0 = 0;
        float v8_0 = 0;
        android.os.Message v9_0 = 0;
        while (v9_0 < v6_0) {
            if (v5_3 != v9_0) {
                v7_0 += p13.getX(v9_0);
                v8_0 += p13.getY(v9_0);
            }
            v9_0++;
        }
        int v4_1;
        if (v4_0 == 0) {
            v4_1 = v6_0;
        } else {
            v4_1 = (v6_0 - 1);
        }
        int v4_2 = ((float) v4_1);
        float v7_1 = (v7_0 / v4_2);
        float v8_1 = (v8_0 / v4_2);
        if (v0_13 == 0) {
            this.k = v7_1;
            this.m = v7_1;
            this.l = v8_1;
            this.n = v8_1;
            long v0_3 = this.h;
            if (v0_3 != 0) {
                v0_3.recycle();
            }
            this.h = android.view.MotionEvent.obtain(p13);
            this.g = 1;
            this.e = 1;
            this.f = 0;
            return 0;
        } else {
            if (v0_13 == 1) {
                this.e = 0;
                float v13_13 = android.view.MotionEvent.obtain(p13);
                if (this.f) {
                    this.f = 0;
                }
                long v0_5 = this.j;
                if (v0_5 != 0) {
                    v0_5.recycle();
                }
                this.j = v13_13;
                this.c.removeMessages(2);
                return 0;
            } else {
                if (v0_13 == 2) {
                    if ((!this.f) && (this.g)) {
                        long v0_12 = ((((int) (v7_1 - this.m)) * ((int) (v7_1 - this.m))) + (((int) (v8_1 - this.n)) * ((int) (v8_1 - this.n))));
                        int v1_2 = this.a;
                        if (android.os.Build$VERSION.SDK_INT >= 29) {
                            long v5_5 = ax.s3.a.a(p13);
                            boolean vtmp10 = this.c.hasMessages(2);
                            if (v5_5 != 1) {
                                v2_0 = 0;
                            }
                            if ((vtmp10) && (v2_0 != null)) {
                                if (v0_12 > v1_2) {
                                    this.c.removeMessages(2);
                                    android.os.Handler v2_4 = this.c;
                                    v2_4.sendMessageAtTime(v2_4.obtainMessage(2, 0, 0), (p13.getDownTime() + ((long) (((float) ((long) this.e())) * this.b))));
                                }
                                v1_2 = ((int) (((float) v1_2) * (this.b * this.b)));
                            }
                        }
                        if (v0_12 > v1_2) {
                            this.k = v7_1;
                            this.l = v8_1;
                            this.g = 0;
                            this.c.removeMessages(2);
                        }
                    }
                } else {
                    if (v0_13 == 3) {
                        this.b();
                        return 0;
                    } else {
                        if (v0_13 == 5) {
                            this.k = v7_1;
                            this.m = v7_1;
                            this.l = v8_1;
                            this.n = v8_1;
                            if (v6_0 != 2) {
                                this.c();
                                return 0;
                            } else {
                                if (this.p) {
                                    long v0_1;
                                    float v13_10;
                                    this.c.removeMessages(2);
                                    float v13_9 = this.h;
                                    if (v13_9 == 0) {
                                        v0_1 = android.os.SystemClock.uptimeMillis();
                                        v13_10 = this.e();
                                    } else {
                                        v0_1 = v13_9.getDownTime();
                                        v13_10 = this.e();
                                    }
                                    float v13_11 = this.c;
                                    v13_11.sendMessageAtTime(v13_11.obtainMessage(2, 0, 0), (v0_1 + ((long) v13_10)));
                                    return 0;
                                }
                            }
                        } else {
                            if (v0_13 == 6) {
                                this.k = v7_1;
                                this.m = v7_1;
                                this.l = v8_1;
                                this.n = v8_1;
                                if (v6_0 == 2) {
                                    this.c();
                                    return 0;
                                }
                            }
                        }
                    }
                }
                return 0;
            }
        }
    }
}
