// Decompiled from: Lcom/alphainventor/filemanager/viewer/d;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public class d extends android.widget.ArrayAdapter {
    static java.util.List b;
    android.view.LayoutInflater a;

    public d(android.content.Context p3)
    {
        super(p3, 0, com.alphainventor.filemanager.viewer.d.b());
        super.a = android.view.LayoutInflater.from(super.getContext());
        return;
    }

    static java.util.List b()
    {
        if (com.alphainventor.filemanager.viewer.d.b == null) {
            java.util.List v0_6 = new java.util.ArrayList();
            com.alphainventor.filemanager.viewer.d.b = v0_6;
            v0_6.add(new com.alphainventor.filemanager.viewer.d$a("0.25X", 1048576000));
            com.alphainventor.filemanager.viewer.d.b.add(new com.alphainventor.filemanager.viewer.d$a("0.5X", 1056964608));
            com.alphainventor.filemanager.viewer.d.b.add(new com.alphainventor.filemanager.viewer.d$a("0.75X", 1061158912));
            com.alphainventor.filemanager.viewer.d.b.add(new com.alphainventor.filemanager.viewer.d$a("1X", 1065353216));
            com.alphainventor.filemanager.viewer.d.b.add(new com.alphainventor.filemanager.viewer.d$a("1.25X", 1067450368));
            com.alphainventor.filemanager.viewer.d.b.add(new com.alphainventor.filemanager.viewer.d$a("1.5X", 1069547520));
            com.alphainventor.filemanager.viewer.d.b.add(new com.alphainventor.filemanager.viewer.d$a("1.75X", 1071644672));
            com.alphainventor.filemanager.viewer.d.b.add(new com.alphainventor.filemanager.viewer.d$a("2X", 1073741824));
        }
        return com.alphainventor.filemanager.viewer.d.b;
    }

    public static int c(float p3)
    {
        java.util.List v0 = com.alphainventor.filemanager.viewer.d.b();
        int v1 = 0;
        while (v1 < v0.size()) {
            if (((com.alphainventor.filemanager.viewer.d$a) v0.get(v1)).b != p3) {
                v1++;
            } else {
                return v1;
            }
        }
        ax.q3.b.f();
        return com.alphainventor.filemanager.viewer.d.c(1065353216);
    }

    android.view.View a(int p2, android.view.View p3, android.view.ViewGroup p4, int p5)
    {
        if (p3 == null) {
            p3 = this.a.inflate(p5, p4, 0);
        }
        ((android.widget.TextView) p3).setText(((com.alphainventor.filemanager.viewer.d$a) this.getItem(p2)).a);
        return p3;
    }

    public android.view.View getDropDownView(int p2, android.view.View p3, android.view.ViewGroup p4)
    {
        return this.a(p2, p3, p4, 2131558582);
    }

    public android.view.View getView(int p2, android.view.View p3, android.view.ViewGroup p4)
    {
        return this.a(p2, p3, p4, 2131558581);
    }
}
