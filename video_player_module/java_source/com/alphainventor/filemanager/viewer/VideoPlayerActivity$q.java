// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$q;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$q implements android.view.animation.Animation$AnimationListener {
    final synthetic android.widget.ImageView a;
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity b;

    VideoPlayerActivity$q(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1, android.widget.ImageView p2)
    {
        this.b = p1;
        this.a = p2;
        return;
    }

    public void onAnimationEnd(android.view.animation.Animation p3)
    {
        this.a.setVisibility(8);
        android.view.animation.AlphaAnimation v3_2 = new android.view.animation.AlphaAnimation(1065353216, 0);
        v3_2.setDuration(750);
        v3_2.setInterpolator(new android.view.animation.DecelerateInterpolator());
        this.a.startAnimation(v3_2);
        return;
    }

    public void onAnimationRepeat(android.view.animation.Animation p1)
    {
        return;
    }

    public void onAnimationStart(android.view.animation.Animation p1)
    {
        return;
    }
}
