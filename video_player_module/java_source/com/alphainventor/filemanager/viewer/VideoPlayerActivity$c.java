// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$c;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$c implements androidx.media3.ui.G$a {
    private long a;
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity b;

    VideoPlayerActivity$c(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1)
    {
        this.b = p1;
        return;
    }

    public void G(androidx.media3.ui.G p1, long p2)
    {
        if (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.b0(this.b)) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.n1(this.b);
            this.a = p2;
        }
        return;
    }

    public void T(androidx.media3.ui.G p5, long p6)
    {
        int v0_1;
        if (this.a <= p6) {
            v0_1 = 0;
        } else {
            v0_1 = 1;
        }
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.p1(this.b, p6, v0_1, 0);
        this.a = p6;
        return;
    }

    public void W(androidx.media3.ui.G p1, long p2, boolean p4)
    {
        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.b0(this.b)) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.q1(this.b, p2);
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.c0(this.b);
        }
        return;
    }
}
