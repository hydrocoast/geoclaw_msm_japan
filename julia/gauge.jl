using VisClaw
using Printf
# include("datenum.jl")
### Waveform plots from gauges
using Plots
gr()
using Dates
## directory
simdir = "../run090212UTC_1kmWRF_OISST/_output"
basetime = DateTime(2020,9,2,20,0,0)
# tend = 60*60*12*5
## load gauge
gauges = loadgauge(simdir)
station_str = ["Oura","Kuchinotsu","Nagasaki","Reihoku","Fukue"]
# station_str = ["Isahaya","Saga","Goto","Ibusuki","Kagoshima"]
xt = basetime+Hour(1):Hour(6):basetime+Hour(120)
xtl = Dates.format.(xt, "mm/dd\nHH:MM")
global plt = plot()
for k = 1:5
    tt = basetime .+ Millisecond.(round.(1e3*gauges[k].time))
    global plt = plot!(plt, tt, gauges[k].eta; label=station_str[k], legend=:topleft, xticks=(xt,xtl),dpi=400)
end

# tstart = Second(DateTime(2020,9,2,21,0,0)-DateTime(2020,9,2,20,0,0)).value;
# tend = Second(DateTime(2020,9,7,19,0,0)-DateTime(2020,9,2,20,0,0)).value
# plotsgaugewaveform(gauges; label=station_str, legend=:topleft,xlims=(tstart,tend))
plotsgaugewaveform(gauges; label=station_str, legend=:topleft)


# xlim
# xlims!(plt,Second(DateTime(2020,9,5,21,0,0)-DateTime(2020,9,2,20,0,0)).value,Second(DateTime(2020,9,7,19,0,0)-DateTime(2020,9,2,20,0,0)).value)

savefig(plt, joinpath(simdir*"/visclaw_plots","gauges.png"))
