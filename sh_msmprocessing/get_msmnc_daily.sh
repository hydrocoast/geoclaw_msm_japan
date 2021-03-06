#!/bin/bash

if [ -z "$2" ]; then echo "usage: $0 YYYY MMDD"; exit 0 ; fi

url_parent='http://database.rish.kyoto-u.ac.jp/arch/jmadata/data/gpv/netcdf/MSM-S/'
str_year="$1"
str_date="$2"

url_target="${url_parent}/${str_year}/${str_date}.nc"

dir_download="../ncfile_daily/${str_year}"

if [ ! -d $dir_download ]; then
    mkdir -p $dir_download
fi

wget -P $dir_download/  $url_target


