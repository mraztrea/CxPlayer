// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$y;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$y extends android.view.OrientationEventListener {
    android.app.Activity a;
    android.os.Handler b;
    boolean c;

    VideoPlayerActivity$y(android.app.Activity p1, android.os.Handler p2)
    {
        super(p1);
        super.b = p2;
        super.a = p1;
        return;
    }

    private boolean a(int p2, int p3)
    {
        if ((p2 <= (p3 - 10)) || (p2 >= (p3 + 10))) {
            return 0;
        } else {
            return 1;
        }
    }

    private boolean b(int p2)
    {
        if ((!this.a(p2, 90)) && (!this.a(p2, 270))) {
            return 0;
        } else {
            return 1;
        }
    }

    private boolean c(int p3)
    {
        if ((!this.a(p3, 0)) && (!this.a(p3, 180))) {
            return 0;
        } else {
            return 1;
        }
    }

    void d()
    {
        int v0_2;
        if (this.a.getResources().getConfiguration().orientation != 2) {
            this.a.setRequestedOrientation(6);
            v0_2 = 1;
        } else {
            this.a.setRequestedOrientation(7);
            v0_2 = 0;
        }
        if (android.provider.Settings$System.getInt(this.a.getContentResolver(), "accelerometer_rotation", 0) == 1) {
            this.e(v0_2);
        }
        return;
    }

    void e(boolean p1)
    {
        this.c = p1;
        this.enable();
        return;
    }

    public void onOrientationChanged(int p4)
    {
        if (((this.c) && (this.b(p4))) || ((!this.c) && (this.c(p4)))) {
            this.b.postDelayed(new com.alphainventor.filemanager.viewer.VideoPlayerActivity$y$a(this), 2000);
            this.disable();
        }
        return;
    }
}
