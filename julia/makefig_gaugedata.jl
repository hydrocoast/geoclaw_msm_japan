# ============================================================================================
# (program) makefig_gaugedata
# Reference: https://github.com/hydrocoast/VisClaw.jl/blob/master/Examples_using_Plots.ipynb
# Description; plot sea surface to check output by GeoClaw
# ============================================================================================


using VisClaw
using Printf
### Waveform plots from gauges
using Plots
gr()

sec1h = 3.6e3
sec1d = 24sec1h

# -----------------------------
# haiyano
# -----------------------------
simdir = "../Realtime_forecast/run09052045JST_JMAForecast/_output"
# simdir = "../runDigitalTC/_output"
# simdir = joinpath(CLAW,"geoclaw/examples/storm-surge/ike/_output")

matdir = joinpath(simdir,"../_mat/")
if ~isdir(matdir)
mkdir(matdir)
end

# read
params = geodata(simdir)
gauges = loadgauge(simdir, eta0=params.eta0,loadvel=true)

# plot
plt = plotsgaugewaveform(gauges, lw=1.0)
plt = plot!(plt;
           xlims=(2.5sec1d, 3.5sec1d),
           ylims=(-0.5,5.0),
           xlabel="Hours relative to landfall",
           ylabel="Surface (m)",
           xticks=(0sec1d:0.25sec1d:3.0sec1d, [@sprintf("%d",i) for i=-3*24:6:1*24]),
           legendfont=Plots.font("sans-serif",12),
           guidefont=Plots.font("sans-serif",10),
           tickfont=Plots.font("sans-serif",10),
           legend=false,
           )

using MAT

time = gauges[1].time;
# save as matfile
file = matopen(joinpath(simdir,"../_mat/gaugedata.mat"), "w")
write(file,"wse_gauge_1", gauges[1].eta)
write(file,"wse_gauge_2", gauges[2].eta)
write(file,"wse_gauge_3", gauges[3].eta)
write(file,"wse_gauge_4", gauges[4].eta)
write(file,"wse_gauge_5", gauges[5].eta)
write(file,"wse_gauge_6", gauges[6].eta)
write(file,"wse_gauge_7", gauges[7].eta)
write(file,"wse_gauge_8", gauges[8].eta)
write(file,"wse_gauge_9", gauges[9].eta)
write(file,"wse_gauge_10", gauges[10].eta)
write(file,"wse_gauge_11", gauges[11].eta)
write(file,"wse_gauge_12", gauges[12].eta)
write(file,"wse_gauge_13", gauges[13].eta)

write(file,"level_gauge_1", gauges[1].AMRlevel)
write(file,"level_gauge_2", gauges[2].AMRlevel)
write(file,"level_gauge_3", gauges[3].AMRlevel)
write(file,"level_gauge_4", gauges[4].AMRlevel)
write(file,"level_gauge_5", gauges[5].AMRlevel)
write(file,"level_gauge_6", gauges[6].AMRlevel)
write(file,"level_gauge_7", gauges[7].AMRlevel)
write(file,"level_gauge_8", gauges[8].AMRlevel)
write(file,"level_gauge_9", gauges[9].AMRlevel)
write(file,"level_gauge_10", gauges[10].AMRlevel)
write(file,"level_gauge_11", gauges[11].AMRlevel)
write(file,"level_gauge_12", gauges[12].AMRlevel)
write(file,"level_gauge_13", gauges[13].AMRlevel)

write(file,"time_gauge_1", gauges[1].time)
write(file,"time_gauge_2", gauges[2].time)
write(file,"time_gauge_3", gauges[3].time)
write(file,"time_gauge_4", gauges[4].time)
write(file,"time_gauge_5", gauges[5].time)
write(file,"time_gauge_6", gauges[6].time)
write(file,"time_gauge_7", gauges[7].time)
write(file,"time_gauge_8", gauges[8].time)
write(file,"time_gauge_9", gauges[9].time)
write(file,"time_gauge_10", gauges[10].time)
write(file,"time_gauge_11", gauges[11].time)
write(file,"time_gauge_12", gauges[12].time)
write(file,"time_gauge_13", gauges[13].time)

close(file)



# pltv = plotsgaugevelocity(gauges)

# save
# savefig(plt, joinpath(savedir,"haiyan_waveform_gauge.png"))
# -----------------------------
