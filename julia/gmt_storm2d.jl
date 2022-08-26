using VisClaw
using Printf
using GMT: GMT

## directory
simdir = joinpath("../force_dry05/_output")

## setup
# makecpt
cpt = GMT.makecpt(C=:wysiwyg, T="950/1020", D=true, I=true)
# arrow style
arrow = "0.01/0.15/0.05" # -A LineWidth/HeadLength/HeadSize
vscale = "e0.03/0.0/12"  # -Se <velscale> / <confidence> / <fontsize>
arrow_color = "black" # -G


## load topo
topo = loadtopo(simdir)
Gtopo = geogrd(topo[1])
scalefile = txtwind_scale(topo[1].x[1]+ 0.2(topo[1].x[end]-topo[1].x[1]), 0.70*topo[1].y[end], 30.0, 0.0) # for legend

## load storm
amrall = loadstorm(simdir, AMRlevel=1)
replaceunit!(amrall, :hour)

# projection and region GMT
region = getR(topo[1])
proj = getJ("X10", axesratio(topo[1]))

output_prefix="./fig/gmtstorm_"

# plot
for i = 1:amrall.nstep
    outpng = output_prefix*@sprintf("%03d", i)

    # surface grids
    G = tilegrd_xyz.(amrall.amr[i])

    # plot pressure field
    GMT.basemap(J=proj, R=region, B="nesw")
    GMT.grdimage!.(G, C=cpt, B="", Q=true)
    GMT.colorbar!(B="xa10f10 y+lhPa", D="jBR+w8.0/0.3+o-1.5/0.0")
    gmtcoastline!(Gtopo, lc=:white, lw=0.5)

    # plot wind field
    psfile = GMT.fname_out(Dict())[1]
    velofile = txtwind(amrall.amr[i], skip=15, offset1=10)
    GMT.gmt("psvelo $velofile -J$proj -R$region -G$arrow_color -A$arrow -S$vscale -P -K -O >> $psfile ")
    rm(velofile, force=true)
    GMT.gmt("psvelo $scalefile -J$proj -R$region -G$arrow_color -A$arrow -S$vscale -Y1.2 -P -O >> $psfile ")

    GMT.psconvert("-TG -A -F$outpng  $psfile")
end

rm(scalefile, force=true)
