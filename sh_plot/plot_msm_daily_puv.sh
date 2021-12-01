#/bin/bash

## arg check
if [ -z "$1" ]; then echo "No directory specified."; exit 0; fi
if [ -z "$2" ]; then dir_out="fig" ; else dir_out="$2" ; fi

## directory for plot
dir_puv="$1"
if [ ! -d "$1" ]; then echo "Directory not found: $dir_puv"; exit 0; fi
if [ ! -d $dir_out ]; then mkdir $dir_out ; fi

## plot for each nc file
for f in $dir_puv/*_psea_*.nc
do
    echo $f
    ./snapshot_msm_daily_puv.sh $f
    outpdf=`basename $f`
    outpdf=${outpdf//_psea/}
    outpdf=${outpdf//.nc/.pdf}
    mv $outpdf $dir_out/
    mv ${outpdf//.pdf/.png} $dir_out/

done

