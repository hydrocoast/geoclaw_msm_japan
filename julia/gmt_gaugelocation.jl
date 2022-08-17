using VisClaw
using GMT: GMT
using Printf
using Dates
## directory
simdir = "../runLandMask/_output"
basetime = DateTime(2020,9,5,21,0,0)
## load gauge
gauges = loadgauge(simdir)
station_str = ["Oura","Kuchinotsu","Saga","Reihoku","Fukue","Kagoshima","Makurazaki","Aburatsu","Saeki","Tosa-Shimizu","Uwajima","Matsuyama","Shimonoseki"]
GMT.coast(J="M10/10", R="128/133/30/35", B="a1f1 neSW", S=:white, G=:gray, D=:f)
for g in gauges
    GMT.scatter!([g.loc[1]], [g.loc[2]], marker=:circle, markerfacecolor=:tomato, markeredgecolor=:black)
end
#gmtgaugeannotation!.(gauges, an;)
GMT.coast!(W=:black, D=:f; savefig="gaugelocation.png")
