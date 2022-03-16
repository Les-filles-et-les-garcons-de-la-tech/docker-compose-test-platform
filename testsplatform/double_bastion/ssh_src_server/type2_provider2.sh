#!/usr/bin/env bash

A_WEEK_AGO=$(date -d "1 week ago" '+%Y%m%d')
TODAY=$(date +%Y%m%d)
ROOT='/ftp/client/type2'
RANGE=23
FREQUENCY=(00 15 30 45)

# $1 is the first date of the files to create
[[ "$1" != "" ]] && BEGIN_DATE=$1 || BEGIN_DATE=$A_WEEK_AGO
# $2 is the last date of the files to create
[[ "$2" != "" ]] && END_DATE=$2 || END_DATE=$TODAY

function gzip_data_file
{

    if [ -f $1 ]
    then
        rm $1
    fi
    touch $1
    gzip $1
}

function generate_tech1_data_files
{
    path=$1
    date=$2
    for h in $(seq 0 $RANGE)
    do
        hs=$(printf '%02d' $h)
        he=$(printf '%02d' $((h+1)))
        for f in ${FREQUENCY[@]}
        do
            touch "$path/C${date}.${hs}00-${date}.${he}00_LAKCHK:3345"
            touch "$path/C${date}.${hs}00-${date}.${he}00_4QIPUP:1350"
            touch "$path/C${date}.${hs}00-${date}.${he}00_KET3ST:2254"
        done
    done
}

function generate_tech2_data_files
{
    path=$1
    date=$2
    for h in $(seq 0 $RANGE)
    do
        hs=$(printf '%02d' $h)
        he=$(printf '%02d' $((h+1)))
        for f in ${FREQUENCY[@]}
        do
            ts=${hs}${f}
            [[ $((f + 15)) == 60 ]] && te="${he}00" || te="${hs}$((f + 15))"
                touch "$path/A${date}.$ts+0000-${te}+0000_Context=B14QKOR_stats.xml"
        done
    done
}

echo "Create PROVIDER2 DATA from $BEGIN_DATE to $END_DATE in $ROOT"
d=$BEGIN_DATE
while [ "$d" -le "$END_DATE" ];
do
    echo "Create DATA files for $d"
    DATA_PATH="$ROOT/PRV2TECHNO1/"
    mkdir -p "$DATA_PATH"
    generate_tech1_data_files "$DATA_PATH" $d
    DATA_PATH="$ROOT/PRV2TECHNO2/"
    mkdir -p "$DATA_PATH"
    generate_tech2_data_files "$DATA_PATH" $d

    d=$(date -d "$d + 1 day" +%Y%m%d)
done
