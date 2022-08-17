using VisClaw
using Printf
using GMT:GMT

## directory
simdir = "../run090212UTC_1kmWRF_OISST/_output"

## read
#topo = loadtopo(simdir)
gauges = loadgauge(simdir, loadvel=true)
replaceunit!.(gauges, :hour)

#=
## plot
cpt = gmttopo(topo[2])
gmtcoastline!(topo[2])
gmtgaugelocation!(gauges; marker=:circle, markerfacecolor=:tomato, markeredgecolor=:black, show=true)
=#
