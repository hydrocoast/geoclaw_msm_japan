using VisClaw
using Printf

using Plots

## directory
simdir = "../run09060950/_output"

## load fgmax
fg = fgmaxdata(simdir)
fgmax = loadfgmax.(simdir, fg)
replaceunit!.(fgmax, :hour)

## load topo
topo = loadtopo("../topo/depth_0810-02_zone01_lonlat.asc")
# dry05 = loadtopo("../topo/force_dry_init_05.dat")

## load track
track = loadtrack(simdir)



id = 2
plt1 = plotsfgmax(fg[id], fgmax[id], :D   ; clims=(0.0,3.0), c=:amp)
plt2 = plotsfgmax(fg[id], fgmax[id], :Dmin; clims=(-0.5,0.5), c=:ocean)
plt3 = plotsfgmax(fg[id], fgmax[id], :tD  ; c=:darkrainbow)
plt4 = plotsfgmax(fg[id], fgmax[id], :tarrival; c=:darkrainbow)
plt = plot(plt1, plt2, plt3, plt4, layout=(2,2), size=(800,600))


#=
plt_D4 = plotsfgmax(fg[1], fgmax[1], :D; clims=(-1e-5,3.0), c=:jet1)
plt_D5 = plotsfgmax(fg[2], fgmax[2], :D; clims=(-1e-5,3.0), c=:jet1)
plt_D5 = plotscoastline!(plt_D5, topo[5], drywet5; lc=:black, lw=1.5)
=#

# plt_D4 = plotsfgmax(fg[1], fgmax[1], :D; clims=(-1e-5,1.2), c=cgrad(:amp, 12, categorical = true))
# plt_D4 = plotscoastline!(plt_D4, topo[4]; lc=:black, lw=1.0)
# plt_D4 = plotstrack!(plt_D4, track; lc=:blue)
# plt_D4 = plotstoporange!(plt_D4, topo[5]; lc=:black)

plt_D5 = plotsfgmax(fg[2], fgmax[2], :D; clims=(-1e-5,3.0), c=cgrad(:amp, 12, categorical = true))
plt_D5 = plotstrack!(plt_D5, track; lc=:blue)
plt_D5 = plotscoastline!(plt_D5, topo; lc=:black, lw=1.5)
xlims!(plt_D5,(128.3,132.2))
ylims!(plt_D5,(30,35))

savefig("fgmax_09060950.png")
# plt = plot(plt_D4, plt_D5, layout=(1,2), size=(1000,600))

#savefig(plt, basename(dirname(simdir))*"_fgmax.png")
