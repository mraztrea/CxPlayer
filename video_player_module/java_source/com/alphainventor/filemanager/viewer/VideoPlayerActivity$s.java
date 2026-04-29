// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$s;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$s implements android.view.View$OnTouchListener {
    final synthetic android.view.ScaleGestureDetector a;
    final synthetic android.view.GestureDetector b;
    final synthetic com.alphainventor.filemanager.viewer.a c;
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity d;

    VideoPlayerActivity$s(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1, android.view.ScaleGestureDetector p2, android.view.GestureDetector p3, com.alphainventor.filemanager.viewer.a p4)
    {
        this.d = p1;
        this.a = p2;
        this.b = p3;
        this.c = p4;
        return;
    }

    public boolean onTouch(android.view.View p4, android.view.MotionEvent p5)
    {
        int v0 = 0;
        if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.X(this.d)) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity v4_26 = this.a.onTouchEvent(p5);
            if ((this.b.onTouchEvent(p5)) || (v4_26 != null)) {
                v0 = 1;
            }
            this.c.g(p5);
            if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.J(this.d)) {
                if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.b0(this.d)) {
                    if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.d0(this.d)) {
                        if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.f0(this.d)) {
                            if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.h0(this.d)) {
                                return v0;
                            } else {
                                if (p5.getAction() == 1) {
                                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.i0(this.d);
                                }
                                return 1;
                            }
                        } else {
                            if (p5.getAction() == 1) {
                                com.alphainventor.filemanager.viewer.VideoPlayerActivity.g0(this.d);
                            }
                            return 1;
                        }
                    } else {
                        if (p5.getAction() == 1) {
                            com.alphainventor.filemanager.viewer.VideoPlayerActivity.e0(this.d);
                        }
                        return 1;
                    }
                } else {
                    if (p5.getAction() == 1) {
                        com.alphainventor.filemanager.viewer.VideoPlayerActivity.c0(this.d);
                    }
                    return 1;
                }
            } else {
                if ((p5.getAction() == 1) && (com.alphainventor.filemanager.viewer.VideoPlayerActivity.Z(this.d) <= 1065353216)) {
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.a0(this.d);
                }
                return 1;
            }
        } else {
            return 0;
        }
    }
}
