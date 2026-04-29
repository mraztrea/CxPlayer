// Decompiled from: Lcom/alphainventor/filemanager/viewer/b$d;
// Package: com.alphainventor.filemanager.viewer

package com.alphainventor.filemanager.viewer;
final enum class b$d extends java.lang.Enum {
    public static final enum com.alphainventor.filemanager.viewer.b$d c0;
    public static final enum com.alphainventor.filemanager.viewer.b$d d0;
    private static final synthetic com.alphainventor.filemanager.viewer.b$d[] e0;
    public static final enum com.alphainventor.filemanager.viewer.b$d q;

    static b$d()
    {
        com.alphainventor.filemanager.viewer.b$d.q = new com.alphainventor.filemanager.viewer.b$d("BUILT_IN", 0);
        com.alphainventor.filemanager.viewer.b$d.c0 = new com.alphainventor.filemanager.viewer.b$d("GENERAL", 1);
        com.alphainventor.filemanager.viewer.b$d.d0 = new com.alphainventor.filemanager.viewer.b$d("IN_IMAGE_VIEWER", 2);
        com.alphainventor.filemanager.viewer.b$d.e0 = com.alphainventor.filemanager.viewer.b$d.d();
        return;
    }

    private b$d(String p1, int p2)
    {
        super(p1, p2);
        return;
    }

    private static synthetic com.alphainventor.filemanager.viewer.b$d[] d()
    {
        com.alphainventor.filemanager.viewer.b$d[] v0_1 = new com.alphainventor.filemanager.viewer.b$d[3];
        v0_1[0] = com.alphainventor.filemanager.viewer.b$d.q;
        v0_1[1] = com.alphainventor.filemanager.viewer.b$d.c0;
        v0_1[2] = com.alphainventor.filemanager.viewer.b$d.d0;
        return v0_1;
    }

    public static com.alphainventor.filemanager.viewer.b$d valueOf(String p1)
    {
        return ((com.alphainventor.filemanager.viewer.b$d) Enum.valueOf(com.alphainventor.filemanager.viewer.b$d, p1));
    }

    public static com.alphainventor.filemanager.viewer.b$d[] values()
    {
        return ((com.alphainventor.filemanager.viewer.b$d[]) com.alphainventor.filemanager.viewer.b$d.e0.clone());
    }
}
