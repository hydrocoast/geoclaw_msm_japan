# ============================================================================================
# (program) makefig_surface
# Reference: https://github.com/hydrocoast/VisClaw.jl/blob/master/Examples_using_Plots.ipynb
# Description; plot sea surface to check output by GeoClaw
# ============================================================================================

using VisClaw
using Plots

# chile2010 _output
simdir = joinpath("../GFS_ensemble/run090212GFS_1degEast/_output")
savedir = joinpath(simdir,"visclaw_plots")
if ~isdir(savedir)
    mkdir(savedir)
end
# Leyte Gulf
# xrange = (124.95,125.2);
# yrange = (11.05,11.3);
# D1
# xrange = (110,150);
# yrange = (-5,20);
# D3
# xrange = (124.5,126.5);
# yrange = (9.5,11.5);
# D4
xrange = (125,135);
yrange = (30,35);
# xrange = (127,140);
# yrange = (17,40);

# timestart = 130;
# timeend = 165;
# timestart = 1;
# timestart = 91;
# timeend = 119;
timestart = 1;
timeend = 120;
output_prefix = "haishen_eta"
using Dates: Dates
timeorigin = Dates.DateTime(2020,9,2,20,0)
# timeorigin = Dates.DateTime(2020,9,5,21) # spinup

surgeparams = surgedata(joinpath(simdir, "surge.data"))

# load water surface
amrall = loadsurface(simdir, timestart:timeend
                     ;xlims=xrange,ylims=yrange)
# rmvalue_coarser!.(amrall.amr)
topo = loadtopo("../topo/depth_0810-02_zone01_lonlat.asc")

# load track
track = loadtrack(simdir)

# plot
plts = plotsamr(amrall; c=:seismic, clims=(-3,3),
                xguide="Longitude", yguide="Latitude",
                # xlims=(120.0,140.0), ylims=(4.0,20.0),
                # xlims=xrange, ylims=yrange,
                guidefont=Plots.font("sans-serif",12),
                tickfont=Plots.font("sans-serif",10),
                colorbar=true,
                colorbar_title="m",
                aspect_ratio=true
                )

plts = map(p->plotscoastline!(p, topo; lc=:black), plts)
# plts = map(p->plotscoastline!(p, topo[3]; lc=:black), plts)
# plts = map(p->plotscoastline!(p, topo[4]; lc=:black), plts)
# plts = map(p->plotscoastline!(p, topo[5]; lc=:black), plts)
# plts = map(p->plotscoastline!(p, topo[6]; lc=:black), plts)
# plts = map(p->plotscoastline!(p, topo[7]; lc=:black), plts)
#



# time in string
time_dates = Dates.Second.(round.(amrall.timelap)) + timeorigin
time_str = Dates.format.(time_dates,"yyyy/mm/dd HH:MM")
plts = map((p,s)->plot!(p, title=s), plts, time_str)

# gauge locations (from gauges.data)
# gauges = gaugedata(simdir)
# gauge location
# plts = map(p -> plotsgaugelocation!(p, gauges; color=:white, offset=(0,0), font=Plots.font(10, :black)), plts)

# tiles
# plts = gridnumber!.(plts, amrall.amr; font=Plots.font(12, :white, :center))
# plts = tilebound!.(plts, amrall.amr)
plts = tilebound!.(plts, amrall.amr; AMRlevel=4, lc=Plots.RGBA(0.3,0.3,0.3,0.8))


# track
# plts = map((p,t) -> plotstrack!(p, track, 1:timestart+t-1; lc=:magenta, lw=3), plts, 1:amrall.nstep)

plts = map(p -> xlims!(p, xrange),plts)
plts = map(p -> ylims!(p, yrange),plts)

# save
plotssavefig(plts, joinpath(savedir,output_prefix*".png"))
# gif
plotsgif(plts, joinpath(savedir,output_prefix*".gif"), fps=2)
