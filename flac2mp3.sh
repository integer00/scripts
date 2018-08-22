#!/bin/sh

a="${1}"
flac -c -d "$a" | lame -b 320 --resample 44.1 - "$a.mp3"
mv *.mp3 /garbage
