using VisClaw
using Printf
using Plots
gr()
using Dates

## directory
#simdir = "../run_0906T0145/_output"
simdir = "../runDigitalTC/_output"
# basetime = DateTime(2020,9,3,20,0)
basetime = DateTime(2020,9,5,21,0,0)
id = 2

## topo
#topo = loadtopo("../topo/gebco_2020_n45.0_s15.0_w120.0_e150.0.asc")
topo = loadtopo("../topo/depth_0810-02_zone01_lonlat.asc")

## load track
track = loadtrack(simdir)

## load fgmax
fg = fgmaxdata(simdir)
fgmax = loadfgmax.(simdir, fg)

tD = round.(1e3*fgmax[id].tD)
tD[isnan.(tD)] .= 0.0
tD_dates = basetime .+ Millisecond.(tD)

td_day = parse.(Int64, Dates.format.(tD_dates,"d"))
td_hour = parse.(Int64, Dates.format.(tD_dates,"H"))
td_min = parse.(Int64, Dates.format.(tD_dates,"M"))

td = td_hour .+ (td_day .- 7)*24
td = convert.(Float64, td)
td[fgmax[id].topo .> 0.0] .= NaN

plt = heatmap(LinRange(fg[id].xlims[1], fg[id].xlims[2], fg[id].nx),
              LinRange(fg[id].ylims[1], fg[id].ylims[2], fg[id].ny),
              td, axis_ratio=:equal,
              clims=(-12,12), c=cgrad(:phase, 24, categorical = true),
              colorbar_title="± 09/06 15:00 (UTC)")
plt = plotscoastline!(plt, topo, lc=:black)
plt = plotstrack!(plt, track; lc=:blue, xlims=(128.5,132.5), ylims=(30.0,35.0))
## save without contourline
savefig(plt, basename(dirname(simdir))*"_fgmax0"*string(id)*"_time.png")

## save with contourline
plt = contour!(plt, LinRange(fg[id].xlims[1], fg[id].xlims[2], fg[id].nx), LinRange(fg[id].ylims[1], fg[id].ylims[2], fg[id].ny), td, levels=-22:2:22, lc=:black, xlims=(128.5,132.5), ylims=(30.0,35.0))
savefig(plt, basename(dirname(simdir))*"_fgmax0"*string(id)*"_time_contour.png")
