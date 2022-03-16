#!/usr/bin/env bash

A_WEEK_AGO=$(date -d "1 week ago" '+%Y%m%d')
TODAY=$(date +%Y%m%d)
ROOT='/ftp/client/TYPE2'
RANGE=23
IDS=(1001 1717)
FREQUENCY=(00 15 30 45)
PATTERN_TECHNO1=("O3KMFVN" "GGD1DUC")
PATTERN_TECHNO2=("RLOUVJA" "KV4DVU4" "EAEJVUP" "V3MGMOT" "TMFRGR4")

# $1 is the first date of the files to create
[[ "$1" != "" ]] && BEGIN_DATE=$1 || BEGIN_DATE=$A_WEEK_AGO
# $2 is the last date of the files to create
[[ "$2" != "" ]] && END_DATE=$2 || END_DATE=$TODAY

function tar_data_files
{
    tar czf "$1" -C "$2" . || exit 8
    rm $2/* || exit 9
}

function gzip_data_file
{
    if [ -f $1 ] || [ -f $1.gz ]
    then
        rm $1*
    fi
    touch $1
    gzip $1
}

function generate_tech1_data_files
{
    path=$1
    date=$2
    mkdir -p "$path/tmp"
    for h in $(seq 0 $RANGE)
    do
        hs=$(printf '%02d' $h)
        he=$(printf '%02d' $((h+1)))
        for f in ${FREQUENCY[@]}
        do
            ts=${hs}${f}
            [[ "$f" == "45" ]] && te="${he}00" || te="${hs}$((f + 15))"
            for prv2 in ${PATTERN_TECHNO1[@]}
            do
                for id in ${IDS[@]}
                do
                    touch "$path/tmp/C${date}.$ts-${date}.${te}_${prv2}:${id}"
                done
            done
        done
        tar_data_files "$path/BSC_${date}${h}00.tar.gz" "$path/tmp"
    done
    rm -rf "$path/tmp"
}

function generate_tech2_data_files
{
    path=$1
    date=$2
    mkdir -p "$path/tmp"
    for prv2 in ${PATTERN_TECHNO2[@]}
    do
        for h in $(seq 0 $RANGE)
        do
            hs=$(printf '%02d' $h)
            he=$(printf '%02d' $((h+1)))
            for f in ${FREQUENCY[@]}
            do
                ts=${hs}${f}
                [[ "$f" == "45" ]] && te="${he}00" || te="${hs}$((f + 15))"
                gzip_data_file "$path/tmp/A${date}.$ts+0100-${date}.${te}+0100_$prv2,Context=${prv2}"
            done
            tar_data_files "$path/${prv2}_${date}${hs}00.tar.gz" "$path/tmp"
        done
    done
    rm -rf "$path/tmp"
}

function generate_tech3_data_files
{
    path="$1/tmp"
    date=$2
    mkdir -p "$path"
    for h in $(seq 0 $RANGE)
    do
        hs=$(printf '%02d' $h)
        he=$(printf '%02d' $((h+1)))
        for f in ${FREQUENCY[@]}
        do
            ts=${hs}${f}
            [[ "$f" == "45" ]] && te="${he}00" || te="${hs}$((f + 15))"
            touch "$path/A${date}.$ts+0100-${date}.${te}+0100_SubNetwork=RTLALN3,MeContext=I_EMK.xml"
            touch "$path/A${date}.$ts+0100-${date}.${te}+0100_SubNetwork=RTLALN3,MeContext=I_EMK_statsfile.xml"
            touch "$path/A${date}.$ts+0100-${date}.${te}+0100_SubNetwork=RTLALN3,MeContext=I_EMKVNDP_3,ManagedElement=I_EMKVNDP_3_statsfile.xml"
        done
        tar_data_files "$path/../RTLALN3_${date}${hs}00.tar.gz" "$path"
    done
    rm -rf "$path"
}

echo "Create PROVIDER2 DATA from $BEGIN_DATE to $END_DATE in $ROOT"
d=$BEGIN_DATE
while [ "$d" -le "$END_DATE" ];
do
    echo "Create DATA files for $d"
    DATA_PATH="$ROOT/PRV2TECHNO1"
    mkdir -p "$DATA_PATH"
    generate_tech1_data_files "$DATA_PATH" $d
    DATA_PATH="$ROOT/PRV2TECHNO2"
    mkdir -p "$DATA_PATH"
    generate_tech2_data_files "$DATA_PATH" $d
    DATA_PATH="$ROOT/PRV2TECHNO3"
    mkdir -p "$DATA_PATH"
    generate_tech3_data_files "$DATA_PATH" $d

    d=$(date -d "$d + 1 day" +%Y%m%d)
done
