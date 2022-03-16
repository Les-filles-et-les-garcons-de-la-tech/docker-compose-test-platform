#!/usr/bin/env bash

A_WEEK_AGO=$(date -d "1 week ago" '+%Y%m%d')
TODAY=$(date +%Y%m%d)
ROOT='/ftp/client/TYPE1'
RANGE=23
IDS=(1020 1040 1034 1715 1716)
FREQUENCY=(00 15 30 45)
PATTERN_TECHNO1=("O3KMFVN" "GGD1DUC" "UL1GTJ1" "ANRFFRN" "H21OMBI" "RMBFRRR")
PATTERN_TECHNO2=("RLOUVJA" "KV4DVU4" "EAEJVUP" "V3MGMOT" "TMFRGR4" "3PV4PSN")
PATTERN_TECHNO3=("RTLALN3" "JE3IDJV" "B6VQTHF" "14PPMRJ")

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
            ts=${hs}${f}
            [[ $((f + 15)) == 60 ]] && te="${he}00" || te="${hs}$((f + 15))"
            for prv2 in ${PATTERN_TECHNO1[@]}
            do
                for i in ${IDS[@]}
                do
                    gzip_data_file "$path/C${date}.$ts-${date}.${te}_${prv2}_${i}"
                done
            done
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
        gzip_data_file "$path/C${date}.${hs}00+0100-${date}.${he}00+0100_${PATTERN_TECHNO2[0]},Context=${PATTERN_TECHNO2[1]}_statsfile.xml"
        for f in ${FREQUENCY[@]}
        do
            ts=${hs}${f}
            [[ $((f + 15)) == 60 ]] && te="${he}00" || te="${hs}$((f + 15))"
            for prv2 in ${PATTERN_TECHNO2[@]}
            do
                gzip_data_file "$path/A${date}.$ts+0100-${date}.${te}+0100_$prv2,Context=${prv2}_statsfile.xml"
            done
        done
    done
}

function generate_tech3_data_files
{
    path=$1
    date=$2
    for h in $(seq 0 $RANGE)
    do
        hs=$(printf '%02d' $h)
        he=$(printf '%02d' $((h+1)))
        gzip_data_file "$path/C${date}.${hs}00+0100-${date}.${he}00+0100_${PATTERN_TECHNO3[0]},Context=${PATTERN_TECHNO3[1]}_statsfile_TECHNO3.xml"
        gzip_data_file "$path/A${date}.${hs}00+0100-${date}.${he}00+0100_${PATTERN_TECHNO3[1]},Context=${PATTERN_TECHNO3[1]}_statsfile_TECHNO3.xml"
        for f in ${FREQUENCY[@]}
        do
            ts=${hs}${f}
            [[ $((f + 15)) == 60 ]] && te="${he}00" || te="${hs}$((f + 15))"
            gzip_data_file "$path/A${date}.$ts+0100-${date}.${te}+0100_${PATTERN_TECHNO3[0]},Context=${PATTERN_TECHNO3[1]}_statsfile_TECHNO3.xml"
            gzip_data_file "$path/A${date}.$ts+0100-${date}.${te}+0100_${PATTERN_TECHNO3[0]},Context=${PATTERN_TECHNO3[1]}_statsfile.xml"
            for prv2 in ${PATTERN_TECHNO3[@]}
            do
                gzip_data_file "$path/A${date}.$ts+0100-${date}.${te}+0100_$prv2,Context=${PATTERN_TECHNO3[1]}_statsfile_TECHNO3.xml"
            done
        done
    done
}

echo "Create PROVIDER2 DATA from $BEGIN_DATE to $END_DATE in $ROOT"
d=$BEGIN_DATE
while [ "$d" -le "$END_DATE" ];
do
    echo "Create DATA files for $d"
    DATA_PATH="$ROOT/PRV2TECHNO1/$(date -d "$d" +%d%m%Y)"
    mkdir -p "$DATA_PATH"
    generate_tech1_data_files "$DATA_PATH" $d
    DATA_PATH="$ROOT/PRV2TECHNO2/$(date -d "$d" +%d%m%Y)"
    mkdir -p "$DATA_PATH"
    generate_tech2_data_files "$DATA_PATH" $d
    DATA_PATH="$ROOT/PRV2TECHNO3/$(date -d "$d" +%d%m%Y)"
    mkdir -p "$DATA_PATH"
    generate_tech3_data_files "$DATA_PATH" $d

    d=$(date -d "$d + 1 day" +%Y%m%d)
done
