#!/bin/bash

url_parent='http://database.rish.kyoto-u.ac.jp/arch/jmadata/data/gpv/latest/'
datestr=`date -u "+%Y%m%d"`

hh_init='12'

url_target="${url_parent}${datestr}/MSM${datestr}${hh_init}S.nc"

dir_download="ncfile_msm/$datestr/$hh_init"

if [ ! -d $dir_download ]; then
    mkdir -p $dir_download
fi

wget -P $dir_download/  $url_target


