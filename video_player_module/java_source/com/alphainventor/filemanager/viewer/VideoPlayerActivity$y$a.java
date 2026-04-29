// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y$a;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$y$a implements java.lang.Runnable {
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity$y q;

    VideoPlayerActivity$y$a(com.alphainventor.filemanager.viewer.VideoPlayerActivity$y p1)
    {
        this.q = p1;
        return;
    }

    public void run()
    {
        if (!this.q.a.isFinishing()) {
            this.q.a.setRequestedOrientation(-1);
            return;
        } else {
            return;
        }
    }
}
