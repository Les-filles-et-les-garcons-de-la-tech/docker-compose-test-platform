#!/bin/bash

A_WEEK_AGO=$(date -d "1 week ago" '+%Y%m%d')
TODAY=$(date +%Y%m%d)
RANGE=23
ROOT='/ftp/client/type2/'
PATTERNIDTECH1="210264 391470 154217 498763 573082 122740 523190 633497 286161 736430 997148 834965 951540 263184 510786 961860 588369 619050 620490 987970 873621 971838 228578 361578 789220 443634 630671 305132"
PATTERNIDTECH2="210264 338111 624720 202327 745767 555816 479903 908601 97899 528914 916409 294385 635413 129625 10509 786200 924671 95969 413072 319811 437563 12721 731136"

# $1 is the first date of the files to create
[[ "$1" != "" ]] && BEGIN_DATE=$1 || BEGIN_DATE=$A_WEEK_AGO
# $2 is the last date of the files to create
[[ "$2" != "" ]] && END_DATE=$2 || END_DATE=$TODAY

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
    functionsetids=$PATTERNIDTECH1
    mkdir -p "$path"
    for h in $(seq 0 $RANGE)
    do
        hs=$(printf '%02d' $h)
        he=$(printf '%02d' $((h+1)))
        for fset in ${functionsetids[@]}
        do
            gzip_data_file "$path/A${date}.${hs}00.0000-${he}00-0000_2T4CKF.xml"
            gzip_data_file "$path/A${date}.${hs}00.0000-${he}00-0000_LNS2SR.xml"
        done
    done
}

function generate_tech2_data_files
{
    path=$1
    date=$2
    functionsetids=$PATTERNIDTECH2
    mkdir -p "$path"
    for h in $(seq 0 $RANGE)
    do
        hs=$(printf '%02d' $h)
        he=$(printf '%02d' $((h+1)))
        for fset in ${functionsetids[@]}
        do
            gzip_data_file "$path/A${date}.${hs}00.0000-${he}00-0000_2T4CKF.xml"
            gzip_data_file "$path/A${date}.${hs}00.0000-${he}00-0000_LNS2SR.xml"
            gzip_data_file "$path/A${date}.${hs}00.0000-${he}00-0000_2T4CKF_X001.xml"
        done
    done
}

echo "Create PROVIDER1 DATA CSV from $BEGIN_DATE to $END_DATE in $ROOT"
d=$BEGIN_DATE
while [ "$d" -le "$END_DATE" ];
do
    echo "Create DATA files for $d"
    DATA_PATH="$ROOT/PRV1TECHNO1/"
    mkdir -p "$DATA_PATH"
    generate_tech1_data_files "$DATA_PATH" $d
    DATA_PATH="$ROOT/PRV1TECHNO2/"
    mkdir -p "$DATA_PATH"
    generate_tech2_data_files "$DATA_PATH" $d

    d=$(date -d "$d + 1 day" +%Y%m%d)
done