# 
# (program) reviseTopo
#

using VisClaw
using GMT
using Plots;gr()
using Printf
include("printtopofmtD.jl")

minElev = 5.0

topogebco = loadtopo("../topo/gebco_2020_n60.0_s0.0_w105.0_e165.0.asc")
topo243002 = loadtopo("../topo/depth_2430-01_zone01_lonlat.asc")
topo81002 = loadtopo("../topo/depth_0810-02_zone01_lonlat.asc")
topo27003 = loadtopo("../topo/depth_0270-03_zone01_lonlat.asc")
topo27004 = loadtopo("../topo/depth_0270-04_zone01_lonlat.asc")

topogebco.elevation[findall(x->x>0,topogebco.elevation)] .= minElev
topo243002.elevation[findall(x->x>0,topo243002.elevation)] .= minElev
topo81002.elevation[findall(x->x>0,topo81002.elevation)] .= minElev
topo27003.elevation[findall(x->x>0,topo27003.elevation)] .= minElev
topo27004.elevation[findall(x->x>0,topo27004.elevation)] .= minElev


printtopoESRIFMTD(topogebco,"gebco_2020_n60.0_s0.0_w105.0_e165.0_5mWall.asc";nodatavalue=-32767)
printtopoESRI(topo243002,"depth_2430-01_zone01_lonlat_5mWall.asc")
printtopoESRI(topo81002,"depth_0810-02_zone01_lonlat_5mWall.asc")
printtopoESRI(topo27003,"depth_0270-03_zone01_lonlat_5mWall.asc")
printtopoESRI(topo27004,"depth_0270-04_zone01_lonlat_5mWall.asc")


# check

toponew = loadtopo("./depth_0270-04_zone01_lonlat_5mWall.asc")