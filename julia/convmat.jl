using VisClaw
using JLD2
using MAT: MAT
using Printf

jld2dir = "./tmp"
matdir = "./tmp"

flist = readdir(jld2dir)
filter!(x->occursin("eta_topo",x), flist)

function jld2tomat_eta(filename)
    @load joinpath(filename) eta_uniformgrid topoid x y timelap elevation

    filebase = basename(filename)
    matfilename = replace(filebase, ".jld2" => ".mat")


    file = MAT.matopen(matfilename, "w")
    MAT.write(file, "topoid",  topoid)
    MAT.write(file, "x",  x)
    MAT.write(file, "y", y)
    MAT.write(file, "timelap", timelap)
    MAT.write(file, "eta_uniformgrid", eta_uniformgrid)
    MAT.write(file, "elevation", elevation)
    MAT.close(file)
end

map(f->jld2tomat_eta(joinpath(jld2dir,f)), flist)


