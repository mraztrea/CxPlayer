// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$u;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$u extends ax.g1.n {
    String m;

    public VideoPlayerActivity$u(android.content.Context p1, ax.g1.D$b p2, String p3)
    {
        super(ax.g1.n$e.R(p1), p2);
        super.m = p3;
        return;
    }

    public static boolean g0(ax.P0.v p1, String p2)
    {
        if (ax.g1.n.I(p1, p2, 0) <= 0) {
            return 0;
        } else {
            return 1;
        }
    }

    protected android.util.Pair c0(ax.g1.G$a p4, int[][][] p5, ax.g1.n$e p6, String p7)
    {
        android.util.Pair v4_1 = super.c0(p4, p5, p6, p7);
        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.Q()) {
            if (com.alphainventor.filemanager.viewer.VideoPlayerActivity.S()) {
                return 0;
            }
        } else {
            if (v4_1 != null) {
                ax.P0.O v5_3 = ((ax.g1.D$a) v4_1.first).a;
                int v0 = 0;
                if ((!android.text.TextUtils.isEmpty(this.m)) && (v5_3 != null)) {
                    int v7_3 = 0;
                    while (v0 < v5_3.a) {
                        if (com.alphainventor.filemanager.viewer.VideoPlayerActivity$u.g0(v5_3.b(v0), this.m)) {
                            v7_3 = 1;
                        }
                        v0++;
                    }
                    v0 = v7_3;
                }
                if (v0 == 0) {
                    return 0;
                }
            }
        }
        return v4_1;
    }
}
