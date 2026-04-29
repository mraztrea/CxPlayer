// Decompiled from: Lcom/alphainventor/filemanager/viewer/c;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
public class c {
    static com.alphainventor.filemanager.viewer.c b;
    java.util.HashMap a;

    public c()
    {
        this.a = new java.util.HashMap();
        return;
    }

    public static com.alphainventor.filemanager.viewer.c b()
    {
        if (com.alphainventor.filemanager.viewer.c.b == null) {
            com.alphainventor.filemanager.viewer.c.b = new com.alphainventor.filemanager.viewer.c();
        }
        return com.alphainventor.filemanager.viewer.c.b;
    }

    public com.alphainventor.filemanager.viewer.c$a a(String p2)
    {
        if (p2 != null) {
            return ((com.alphainventor.filemanager.viewer.c$a) this.a.remove(p2));
        } else {
            return 0;
        }
    }

    public void c(String p3, java.util.List p4, int p5)
    {
        this.a.put(p3, new com.alphainventor.filemanager.viewer.c$a(p4, p5));
        return;
    }
}
