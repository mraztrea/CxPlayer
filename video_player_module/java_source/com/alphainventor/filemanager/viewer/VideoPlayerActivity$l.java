// Decompiled from: Lcom/alphainventor/filemanager/viewer/VideoPlayerActivity$l;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
 class VideoPlayerActivity$l implements android.widget.AdapterView$OnItemSelectedListener {
    final synthetic com.alphainventor.filemanager.viewer.d a;
    final synthetic com.alphainventor.filemanager.viewer.VideoPlayerActivity b;

    VideoPlayerActivity$l(com.alphainventor.filemanager.viewer.VideoPlayerActivity p1, com.alphainventor.filemanager.viewer.d p2)
    {
        this.b = p1;
        this.a = p2;
        return;
    }

    public void onItemSelected(android.widget.AdapterView p1, android.view.View p2, int p3, long p4)
    {
        float v1_2 = ((com.alphainventor.filemanager.viewer.d$a) this.a.getItem(p3));
        if (v1_2 != 0) {
            com.alphainventor.filemanager.viewer.VideoPlayerActivity.q0(this.b, v1_2.b, 1);
        }
        return;
    }

    public void onNothingSelected(android.widget.AdapterView p1)
    {
        return;
    }
}
