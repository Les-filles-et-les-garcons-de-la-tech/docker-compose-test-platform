#!/bin/bash

A_WEEK_AGO=$(date -d "1 week ago" '+%Y%m%d')
TODAY=$(date +%Y%m%d)
ROOT="/ftp/client/TYPE1/PRV1TECHNO1/"

# $1 is the first date of the files to create
[[ "$1" != "" ]] && BEGIN_DATE=$1 || BEGIN_DATE=$A_WEEK_AGO
# $2 is the last date of the files to create
[[ "$2" != "" ]] && END_DATE=$2 || END_DATE=$TODAY

echo "Create PROVIDER1 DATA CSV from $BEGIN_DATE to $END_DATE in $ROOT"
PATTERNIDTECH1="210264 391470 154217 498763 573082 122740 523190 633497 286161 736430 997148 834965 951540 263184 510786 961860 588369 619050 620490 987970 873621 971838 228578 361578 789220 443634 630671 305132"
RANGE=23

d=$BEGIN_DATE
while [ "$d" -le "$END_DATE" ];
do
    echo "Create DATA files for $d"
    DATA_PATH="$ROOT/$(date -d "$d" +%d%m%Y)"
    mkdir -p $DATA_PATH
    for h in $(seq 0 $RANGE)
    do
        for f in $PATTERNIDTECH1
        do
            hs=$(printf '%02d' $h)
            he=$(printf '%02d' $((h+1)))

            frequency=(15 45 60)
            for i in ${frequency[@]}
            do
                name="$DATA_PATH/dataresult_127${f}_${i}_${d}${hs}00_${he}00.csv"
                if [ -f $name ]
                then
                    rm $name
                fi
                touch $name
                gzip $name
            done
        done
    done

    d=$(date -d "$d + 1 day" +%Y%m%d)
done
