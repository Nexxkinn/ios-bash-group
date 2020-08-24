# ios-group
Bash script to group picture and videos backed up from iOS/iPadOS device.

## Usages
- Put `organize.sh` into the directory
- Run the script
- The script group files into folders with these condition:
    - **Camera** : Pictures taken from your device
    - **Videos** : Videos recorded from your device
    - **Downloaded** : Pictures saved from an app or internet
    - **Downloaded-Videos** : Videos saved from an app or internet

## Limitation and assumptions
- The script assumed that all pictures and videos are stored into one directory.
- It only scan files inside the directory and ignore all subdirectories.
- Any undefined files will the grouped into `Downloaded` folder.
- Screen-recorded files will be stored into `Downloaded` folder due to no metadata available to identify the file.

## Depedencies
- [`exif`](https://aur.archlinux.org/packages/exif/) to identify pictures
- [`ffprobe`](https://www.archlinux.org/packages/extra/x86_64/ffmpeg/) to identify videos