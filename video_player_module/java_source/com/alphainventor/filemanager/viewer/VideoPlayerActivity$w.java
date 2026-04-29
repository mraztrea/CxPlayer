// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$w;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$w implements ax.P0.p {
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity a;

    private VideoPlayerActivity$w(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1)
    {
        this.a = p1;
        return;
    }

    synthetic VideoPlayerActivity$w(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1, com.alphainventor.filemanager.viewer.VideoPlayerActivity$k p2)
    {
        this(p1);
        return;
    }

    public bridge synthetic android.util.Pair a(Throwable p1)
    {
        return this.b(((ax.P0.F) p1));
    }

    public android.util.Pair b(ax.P0.F p4)
    {
        String v0_2 = this.a.getString(2131951953);
        if (ax.p3.k.m(this.a)) {
            if (!(p4 instanceof androidx.media3.exoplayer.s)) {
                StringBuilder v1_2 = new StringBuilder();
                v1_2.append(v0_2);
                v1_2.append(":");
                v1_2.append(p4.getMessage());
                v0_2 = v1_2.toString();
            } else {
                StringBuilder v1_4 = new StringBuilder();
                v1_4.append(v0_2);
                v1_4.append(":");
                v1_4.append(((androidx.media3.exoplayer.s) p4).k0);
                v1_4.append(":");
                v1_4.append(p4.getMessage());
                v0_2 = v1_4.toString();
            }
        }
        if ((p4 instanceof androidx.media3.exoplayer.s)) {
            StringBuilder v1_6 = ((androidx.media3.exoplayer.s) p4).k0;
            if ((v1_6 != null) && (v1_6 == 1)) {
                String v4_2 = ((androidx.media3.exoplayer.s) p4).h();
                if ((v4_2 instanceof ax.c1.L$c)) {
                    String v4_3 = ((ax.c1.L$c) v4_2);
                    if (!v4_3.c0) {
                        v0_2 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.V(this.a, v4_3.q);
                    } else {
                        String v0_9 = this.a;
                        StringBuilder v1_10 = new StringBuilder();
                        v1_10.append(v4_3.q);
                        v1_10.append(":secure");
                        v0_2 = com.alphainventor.filemanager.viewer.VideoPlayerActivity.V(v0_9, v1_10.toString());
                    }
                }
            }
        }
        return android.util.Pair.create(Integer.valueOf(0), v0_2);
    }
}
