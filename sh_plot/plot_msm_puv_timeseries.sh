#/bin/bash

## arg check
if [ -z "$1" ]; then echo "No directory specified."; exit 0; fi

## directory for plot
dir_puv="$1"
if [ ! -d "$1" ]; then echo "Directory not found: $dir_puv"; exit 0; fi

## plot for each nc file
for f in $dir_puv/*_psea_*.nc
do
    echo $f
    ./snapshot_msm_puv.sh $f
done


