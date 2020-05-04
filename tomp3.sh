#!/bin/bash
set -e

for var in "$@"
 do
  b=$(echo ${var} |sed -E "s/\.webm|\.flac|\.mp4/.mp3/g")
  ext=${var##*\.}

  case ${ext} in
   webm)
    echo "Processing ${var}"
    ffmpeg -nostats -loglevel 0 -i "${var}" -vn -ab 320k -ar 44100 -y "${b}" ;;
   flac)
    flac -c -d "${var}" | lame -b 320 --resample 44.1 - "${b}" ;;
  esac
done