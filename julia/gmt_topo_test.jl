using VisClaw
using Printf
using GMT: GMT

## directory output
simdir = "../landmask/_output"

## read
topo = loadtopo(simdir)
G = geogrd(topo[1])

## setup
proj = getJ("X10", axesratio(topo[1]))
region = getR(topo[1])
cpt = GMT.makecpt(; C=:geo, T="-6000/3000", D=true)

## topo
GMT.grdimage(G, C=cpt, J=proj, R=region, B="nesw", Q=true)
gmtcoastline!(G, lc=:black)

## other regions
gmttoporange!(topo[2], lw=0.5)
gmttoporange!(topo[3], lw=0.5)
gmttoporange!(topo[4], lw=0.5)
gmttoporange!(topo[5], lw=0.5)
GMT.colorbar!(C=cpt, B="xa1000f1000 y+l\"(m)\"", D="jBR+w8.0/0.3+o-1.2/0.0", savefig="topo1.pdf")
