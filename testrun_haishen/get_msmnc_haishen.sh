#!/bin/bash

# download MSM data (edit here depending on TC cases)
yearList=( 2020 2020 2020 2020 )
dateList=( 0904 0905 0906 0907 )
ndays=${#dateList[*]} # number of days
ie=$(($ndays-1))

for i in `seq 0 ${ie}` 
do
    dir_download="$(pwd)/../ncfile_daily/${yearList[i]}"
    FILE="${dir_download}/${dateList[i]}.nc"
    if [ -e $FILE ]; then
        echo "File exists... skip"
    else
        ./get_msmnc_daily.sh ${yearList[i]} ${dateList[i]}
    fi
done

# make storm_list.data
echo '# ========================================================= # ' > storm_list.data
echo '# LIST OF STORM DATA FILES                                  # ' >> storm_list.data  
echo '# (from GSM forecast)                                       # ' >> storm_list.data  
echo '# ========================================================= # ' >> storm_list.data  
echo ' ' >> storm_list.data
echo ${ndays} >> storm_list.data
for i in `seq 0 ${ie}` 
do
    dir_download="$(pwd)/../ncfile_daily/${yearList[i]}"
    echo "${dir_download}/${dateList[i]}.nc" >> storm_list.data
done
echo "storm_list.data has been made"
