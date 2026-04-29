// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$t;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$t extends ax.q3.q {
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity h;

    VideoPlayerActivity$t(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1)
    {
        this.h = p1;
        super(ax.q3.q$e.e0);
        return;
    }

    protected bridge synthetic Object g(Object[] p1)
    {
        return this.w(((Void[]) p1));
    }

    protected void o()
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.j0(this.h).setVisibility(8);
        return;
    }

    protected bridge synthetic void q(Object p1)
    {
        this.x(((Boolean) p1));
        return;
    }

    protected void r()
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.j0(this.h).setVisibility(0);
        super.r();
        return;
    }

    protected varargs Boolean w(Void[] p1)
    {
        return Boolean.valueOf(ax.s3.f.d(this.h));
    }

    protected void x(Boolean p3)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.j0(this.h).setVisibility(8);
        if (!p3.booleanValue()) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.n0(this.h, 2131951922);
            return;
        } else {
            ax.s3.f.n(this.h);
            this.h.z3();
            return;
        }
    }
}
