// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$e;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$e extends android.view.ScaleGestureDetector$SimpleOnScaleGestureListener {
    float a;
    float b;
    float c;
    float d;
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity e;

    VideoPlayerActivity$e(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1)
    {
        this.e = p1;
        return;
    }

    public boolean onScale(android.view.ScaleGestureDetector p9)
    {
        if ((!com.alphainventor.filemanager.viewer.VideoPlayerActivity.s1(this.e)) && (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.h0(this.e))) {
            if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.J(this.e)) {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.t1(this.e, p9.getScaleFactor(), p9.getFocusX(), p9.getFocusY(), (this.c - p9.getFocusX()), (this.d - p9.getFocusY()));
                this.c = p9.getFocusX();
                this.d = p9.getFocusY();
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }

    public boolean onScaleBegin(android.view.ScaleGestureDetector p3)
    {
        if ((!com.alphainventor.filemanager.viewer.VideoPlayerActivity.s1(this.e)) && (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.h0(this.e))) {
            if (ax.p3.m.u(this.e)) {
                this.a = p3.getFocusX();
                this.b = p3.getFocusY();
                this.c = p3.getFocusX();
                this.d = p3.getFocusY();
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.u1(this.e, 1);
                if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.J(this.e)) {
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.v1(this.e);
                }
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }

    public void onScaleEnd(android.view.ScaleGestureDetector p2)
    {
        if ((!com.alphainventor.filemanager.viewer.VideoPlayerActivity.s1(this.e)) && (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.h0(this.e))) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.u1(this.e, 0);
            this.a = 0;
            this.b = 0;
            this.c = 0;
            this.d = 0;
        }
        return;
    }
}
