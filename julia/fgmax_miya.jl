using VisClaw
using Printf
using Plots
gr()
using Dates

## directory
simdir = "../runLandMaskWRF/_output"
#simdir = "../run_0905T1645/_output"
basetime = DateTime(2020,9,4,21,0,0)

## topo
#topo = loadtopo("../topo/gebco_2020_n45.0_s15.0_w120.0_e150.0.asc")
topo = loadtopo("../topo/depth_0270-04_zone01_lonlat_5mWall.asc")

## load track
track = loadtrack(simdir)

## load fgmax
fg = fgmaxdata(simdir)
fgmax = loadfgmax.(simdir, fg)

for k = 4:4
    plt = plotsfgmax(fg[k], fgmax[k], :D; clims=(-1e-5,1.5), c=cgrad(:jet, 12, categorical = true))
    plt = plotscoastline!(plt, topo; lc=:black)
    if k==2
        plt = plotstrack!(plt, track; lc=:blue, xlims=(128.5,132.5), ylims=(30.0,35.0))
    else
        plt = plotstrack!(plt, track; lc=:blue, xlims=fg[k].xlims, ylims=fg[k].ylims)
    end

    savefig(plt, basename(dirname(simdir))*@sprintf("_fgmax%02d",k)*".png")
end
