#!/bin/bash

## narg check
if [ -z "$1" ]; then
    echo "No MSM nc file is specified."
    exit 0
fi

## file
filename=$1
if [ ! -e $filename ]; then
    echo "Not found: $filename"
    exit 0
fi
t_end=`gmt grdinfo -Q -Cn -o13 "${filename}?psea"  | awk '{print $1-1}'`

## convert
fbase=`basename $filename`
for i in `seq -w 0 $t_end`
do
     echo "$fbase -- $i"
     #gmt grdconvert  "${filename}?psea[${i}]" -G"${fbase//.nc/_psea_${i}.nc}=nf"
     gmt grdmath  "${filename}?psea[${i}]" 100 DIV = ${fbase//.nc/_psea_${i}.nc}=nf
     gmt grdconvert  "${filename}?u[${i}]" -G"${fbase//.nc/_u_${i}.nc}=nf"
     gmt grdconvert  "${filename}?v[${i}]" -G"${fbase//.nc/_v_${i}.nc}=nf"
done

## move files
dir_org=`dirname $filename`
dir_save=${dir_org//ncfile_msm/ncfile_puv}
if [ ! -d $dir_save ]; then
    mkdir -p $dir_save
fi
mv ${fbase//.nc/}_*.nc $dir_save/


