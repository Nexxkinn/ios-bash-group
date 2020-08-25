#!/bin/bash

cd "$(dirname "$0")"
# make folder if not exists
mkdir -p {Camera,Videos,Downloaded,Downloaded-Videos}
# organise it

files=($(ls -p | grep -vE "/|.sh"))

flen=${#files[@]}
for (( i=0; i<$flen; i++ ))
do
    file=${files[$i]}
    echo -ne "($((i+1))/$flen) $file \033[0K\r"
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
    elif [ "$(exif $file -t 0xa433 -m 2> /dev/null)" = "Apple" ]
    then
        mv $file Camera/
    else
        mv $file Downloaded/
    fi
done

echo -ne "\n"
