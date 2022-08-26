using GMT: GMT


GMT.gmt("set BASEMAP_TYPE = plain")
GMT.gmt("set TICK_LENGTH   -0.2c")
GMT.gmt("set MAP_ANNOT_OFFSET_PRIMARY   0.15c")
GMT.coast(J="M10/10", R="130/141/31/38", B="a2f1 neSW", S=:white, G=:gray, D=:f)



#gmtgaugeannotation!.(gauges, an;)
GMT.coast!(W=:black, D=:f; savefig="kainan.png")
