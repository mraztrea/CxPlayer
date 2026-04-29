// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$f;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$f extends android.view.GestureDetector$SimpleOnGestureListener {
    float a;
    float b;
    long c;
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity d;

    VideoPlayerActivity$f(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1)
    {
        this.d = p1;
        return;
    }

    public boolean onDoubleTap(android.view.MotionEvent p8)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.w1(this.d);
        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.d) != null) {
            int v0_1 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.z1(this.d).getWidth();
            if (v0_1 > 0) {
                if (p8.getX() >= ((float) (v0_1 / 3))) {
                    if (p8.getX() > ((float) ((v0_1 * 2) / 3))) {
                        if (ax.p3.m.r(this.d)) {
                            com.alphainventor.filemanager.viewer.VideoPlayerActivity.x1(this.d, 1);
                            return 1;
                        } else {
                            return 0;
                        }
                    }
                } else {
                    if (ax.p3.m.r(this.d)) {
                        com.alphainventor.filemanager.viewer.VideoPlayerActivity.x1(this.d, 0);
                        return 1;
                    } else {
                        return 0;
                    }
                }
            }
            com.alphainventor.filemanager.viewer.VideoPlayerActivity v8_5 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.d).i();
            if ((v8_5 != 2) && (v8_5 != 3)) {
                if (v8_5 == 4) {
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.A1(this.d);
                }
            } else {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.y1(this.d);
            }
            return 1;
        } else {
            return 0;
        }
    }

    public boolean onDoubleTapEvent(android.view.MotionEvent p1)
    {
        return 1;
    }

    public boolean onDown(android.view.MotionEvent p1)
    {
        return 1;
    }

    public boolean onFling(android.view.MotionEvent p1, android.view.MotionEvent p2, float p3, float p4)
    {
        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.d) != null) {
            if (Math.abs(p3) >= Math.abs(p4)) {
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }

    public void onLongPress(android.view.MotionEvent p1)
    {
        if ((!com.alphainventor.filemanager.viewer.VideoPlayerActivity.J(this.d)) && ((!com.alphainventor.filemanager.viewer.VideoPlayerActivity.h0(this.d)) && (ax.p3.m.p(this.d)))) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.M1(this.d);
            return;
        } else {
            return;
        }
    }

    public boolean onScroll(android.view.MotionEvent p10, android.view.MotionEvent p11, float p12, float p13)
    {
        int v1 = 0;
        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.d) != null) {
            if ((p10 != null) && (p11 != 0)) {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.w1(this.d);
                if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.J(this.d)) {
                    if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.h0(this.d)) {
                        if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.s1(this.d)) {
                            if (p11.getPointerCount() <= 1) {
                                if (Math.abs(p12) >= Math.abs(p13)) {
                                    if (Math.abs((p10.getX() - p11.getX())) >= ((float) com.alphainventor.filemanager.viewer.VideoPlayerActivity.J1(this.d))) {
                                        this.a = p10.getX();
                                        this.c = com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.d).k0();
                                        if (ax.p3.m.s(this.d)) {
                                            com.alphainventor.filemanager.viewer.VideoPlayerActivity.n1(this.d);
                                        } else {
                                            return 0;
                                        }
                                    } else {
                                        return 0;
                                    }
                                } else {
                                    if (Math.abs((p10.getY() - p11.getY())) >= ((float) com.alphainventor.filemanager.viewer.VideoPlayerActivity.D1(this.d))) {
                                        com.alphainventor.filemanager.viewer.VideoPlayerActivity v13_2;
                                        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.E1(this.d).getHeight() >= (com.alphainventor.filemanager.viewer.VideoPlayerActivity.F1(this.d) * 10)) {
                                            if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.E1(this.d).getHeight() >= (com.alphainventor.filemanager.viewer.VideoPlayerActivity.G1(this.d) * 10)) {
                                                v13_2 = (com.alphainventor.filemanager.viewer.VideoPlayerActivity.E1(this.d).getHeight() / 10);
                                            } else {
                                                v13_2 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.G1(this.d);
                                            }
                                        } else {
                                            v13_2 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.F1(this.d);
                                        }
                                        if ((p10.getY() >= ((float) v13_2)) && (p10.getY() <= ((float) (com.alphainventor.filemanager.viewer.VideoPlayerActivity.E1(this.d).getHeight() - v13_2)))) {
                                            this.b = p10.getY();
                                            if ((com.alphainventor.filemanager.viewer.VideoPlayerActivity.z1(this.d) == null) || (p10.getX() >= ((float) (com.alphainventor.filemanager.viewer.VideoPlayerActivity.z1(this.d).getWidth() / 2)))) {
                                                if (ax.p3.m.t(this.d)) {
                                                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.I1(this.d);
                                                } else {
                                                    return 0;
                                                }
                                            } else {
                                                if (ax.p3.m.n(this.d)) {
                                                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.H1(this.d);
                                                } else {
                                                    return 0;
                                                }
                                            }
                                        } else {
                                            return 0;
                                        }
                                    } else {
                                        return 0;
                                    }
                                }
                            } else {
                                return 0;
                            }
                        }
                        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.s1(this.d)) {
                            if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.b0(this.d)) {
                                if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.d0(this.d)) {
                                    if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.f0(this.d)) {
                                        com.alphainventor.filemanager.viewer.VideoPlayerActivity.L1(this.d, ax.q3.A.f(this.d, ((int) (this.b - p11.getY()))));
                                        return 1;
                                    }
                                } else {
                                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.K1(this.d, ax.q3.A.f(this.d, ((int) (this.b - p11.getY()))));
                                    return 1;
                                }
                            } else {
                                int v3_8 = (this.c + ((((long) ax.q3.A.f(this.d, ((int) (p11.getX() - this.a)))) * 40000) / 360));
                                com.alphainventor.filemanager.viewer.VideoPlayerActivity v10_24 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.d).Y();
                                if (v10_24 == -9223372036854775807) {
                                    v10_24 = 0;
                                }
                                if (v3_8 >= 0) {
                                    if (v3_8 > v10_24) {
                                        v3_8 = v10_24;
                                    }
                                } else {
                                    v3_8 = 0;
                                }
                                if (p12 > 0) {
                                    v1 = 1;
                                }
                                com.alphainventor.filemanager.viewer.VideoPlayerActivity.p1(this.d, v3_8, v1, 1);
                                return 1;
                            }
                        } else {
                            float v11_12 = new StringBuilder();
                            v11_12.append("what case is this : ");
                            v11_12.append(this.a);
                            v11_12.append(",");
                            v11_12.append(p10.getX());
                            ax.q3.b.e(v11_12.toString());
                            return 1;
                        }
                    } else {
                        return 0;
                    }
                } else {
                    if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.B1(this.d)) {
                        return 0;
                    } else {
                        com.alphainventor.filemanager.viewer.VideoPlayerActivity v10_30 = this.d;
                        com.alphainventor.filemanager.viewer.VideoPlayerActivity.C1(v10_30, com.alphainventor.filemanager.viewer.VideoPlayerActivity.Z(v10_30), p12, p13);
                        return 1;
                    }
                }
            }
            return 0;
        } else {
            return 0;
        }
    }

    public boolean onSingleTapConfirmed(android.view.MotionEvent p1)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.w1(this.d);
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.A1(this.d);
        return 1;
    }

    public boolean onSingleTapUp(android.view.MotionEvent p1)
    {
        return 1;
    }
}
