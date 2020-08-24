#!/bin/bash

cd "$(dirname "$0")"
# make folder if not exists
mkdir -p Camera
mkdir -p Videos
mkdir -p Downloaded
mkdir -p Downloaded-Videos
# organise it

shopt -s nullglob
files=($(ls -p | grep -vE "/|.sh"))
shopt -u nullglob

i=1
flen=${#files[@]}
for file in "${files[@]}"
do
    printf "($i/$flen) $file \r"

    device=$(exif $file -t 0xa433 -m 2> /dev/null)

    # check if file is a video
    if [[ ${file^^} =~ .MOV|.MP4 ]]
    then
        device=$(ffprobe $file 2>&1 | grep com.apple.quicktime.make | awk '{print $2}')
        if [ "$device" = "Apple" ]
        then
            mv $file Videos/
        else
            mv $file Downloaded-Videos/
        fi
    elif [ "$device" = "Apple" ]
    then
        mv $file Camera/
    else
        mv $file Downloaded/
    fi
    ((i+=1))
done

printf "\n"

