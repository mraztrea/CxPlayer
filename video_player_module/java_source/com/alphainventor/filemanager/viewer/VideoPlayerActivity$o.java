// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$o;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$o implements ax.A0.l {
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity a;

    VideoPlayerActivity$o(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1)
    {
        this.a = p1;
        return;
    }

    public void a(String p1, android.os.Bundle p2)
    {
        if (p2.getBoolean("result")) {
            androidx.media3.exoplayer.ExoPlayer v1_7 = this.a;
            if ((v1_7.H1) && ((com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(v1_7) != null) && (!com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.a).b()))) {
                com.alphainventor.filemanager.viewer.VideoPlayerActivity.o1(this.a).L(1);
            }
        }
        return;
    }
}
