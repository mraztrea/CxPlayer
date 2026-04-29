// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$v;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$v extends ax.q3.q {
    private int h;
    private boolean i;
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity j;

    VideoPlayerActivity$v(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1, int p2, boolean p3)
    {
        this.j = p1;
        super(ax.q3.q$e.d0);
        super.h = p2;
        super.i = p3;
        return;
    }

    static synthetic void w(com.alphainventor.filemanager.viewer.VideoPlayerActivity$v p0)
    {
        p0.z();
        return;
    }

    private void z()
    {
        if ((!this.j.isDestroyed()) && ((com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.j) != null) && (com.alphainventor.filemanager.viewer.VideoPlayerActivity.k0(this.j) != null))) {
            try {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.j).w(com.alphainventor.filemanager.viewer.VideoPlayerActivity.k0(this.j), this.i);
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.j).k();
                return;
            } catch (IllegalStateException v0_7) {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.n0(this.j, 2131951922);
                ax.K2.d.c("EXOPLAYER ILLEGALSTATE", v0_7);
                return;
            }
        } else {
            return;
        }
    }

    protected bridge synthetic Object g(Object[] p1)
    {
        return this.x(((Void[]) p1));
    }

    protected void o()
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.j0(this.j).setVisibility(8);
        return;
    }

    protected bridge synthetic void q(Object p1)
    {
        this.y(((Boolean) p1));
        return;
    }

    protected void r()
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.j0(this.j).setVisibility(0);
        return;
    }

    protected varargs Boolean x(Void[] p2)
    {
        try {
            Boolean v2_0 = this.j;
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.l0(v2_0, com.alphainventor.filemanager.viewer.VideoPlayerActivity.m0(v2_0, this.h));
            return Boolean.TRUE;
        } catch (IllegalStateException) {
            return Boolean.FALSE;
        }
    }

    protected void y(Boolean p3)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.j0(this.j).setVisibility(8);
        if (p3.booleanValue()) {
            if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.j) != null) {
                if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.G(this.j)) {
                    com.alphainventor.filemanager.viewer.VideoPlayerActivity.N(this.j, new com.alphainventor.filemanager.viewer.VideoPlayerActivity$v$a(this));
                    return;
                } else {
                    this.z();
                    return;
                }
            } else {
                return;
            }
        } else {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.n0(this.j, 2131951922);
            return;
        }
    }
}
