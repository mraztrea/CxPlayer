// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$k;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$k implements android.view.SurfaceHolder$Callback {
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity a;

    VideoPlayerActivity$k(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1)
    {
        this.a = p1;
        return;
    }

    public void surfaceChanged(android.view.SurfaceHolder p1, int p2, int p3, int p4)
    {
        return;
    }

    public void surfaceCreated(android.view.SurfaceHolder p2)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.H(this.a, 1);
        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.I(this.a) != null) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.I(this.a).run();
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.N(this.a, 0);
        }
        return;
    }

    public void surfaceDestroyed(android.view.SurfaceHolder p2)
    {
        com.alphainventor.filemanager.viewer.VideoPlayerActivity.H(this.a, 0);
        return;
    }
}
