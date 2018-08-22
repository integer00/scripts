#!/bin/sh

trap "exit" INT 


for a in *.{webm,mp4,flac}; do

b=$(echo $a |sed -E "s/\.webm|\.flac|\.mp4/.mp3/g")


echo $a
ffmpeg -i "$a" -acodec libmp3lame -ar 44100 -b:a 320k "$b"
rm "$a"

done
