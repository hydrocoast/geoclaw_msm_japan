using Printf
using Dates
using VisClaw
using JLD2
using Plots
gr()


jld2dir = "../jebi_ascii/_jld2"

## set t0 time
t0_datetime = DateTime(2018,08,30,0,0,0)

#=
## load surface
@load joinpath(jld2dir, "amrall.jld2") amrall
coarsegridmask!(amrall)
#replaceunit!(amrall, :hour)
converttodatetime!(amrall, t0_datetime)
tstr = Dates.format.(amrall.timelap, "yyyy/mm/dd HH:MM")
=#

plts = plotsamr(amrall, 120:130; AMRlevel=1:4, xlims=(132.5,137.5), ylims=(32.5,37.5),
                clims=(0.0,2.0), c=cgrad(:jet, 8, categorical = true), colorbar=true)
map((p,k)->savefig(p, "./surf_"*@sprintf("%03d",k)*".png"), plts, 120:130)

