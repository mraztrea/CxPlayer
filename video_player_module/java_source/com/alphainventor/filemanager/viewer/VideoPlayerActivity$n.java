// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$n;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$n implements android.view.View$OnSystemUiVisibilityChangeListener {
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity a;

    VideoPlayerActivity$n(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1)
    {
        this.a = p1;
        return;
    }

    public void onSystemUiVisibilityChange(int p2)
    {
        if ((p2 == null) && (com.alphainventor.filemanager.viewer.VideoPlayerActivity.c1(this.a) == 3846)) {
            this.a.I3(0);
        }
        return;
    }
}
