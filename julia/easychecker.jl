using VisClaw

using Printf
using Plots
gr()
# plotlyjs()

cs = cgrad([:blue, :white, :red])

simdir = joinpath("../CalSet/testrun_haishen_Wa05/_output")
# simdir = joinpath("../run090212UTC_1kmWRF_HIMSST/_output")

# sea surface height
plt = plotscheck(simdir; color=cs, clims=(-1.0,1.0), colorbar=true)

# pressure
# plt2 = plotscheck(simdir; vartype=:storm,clims=(1000,1020), color=:jet, colorbar=true)

# current
# plt3 = plotscheck(simdir; vartype=:current,color=:jet, clims=(-1,1), colorbar=true)
