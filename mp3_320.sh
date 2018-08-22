#!/bin/bash
#output=$( "{1} |sed s/mp3/mp3/")

echo "(${1})"

lame -b 320 --resample 44.1 "$1" "$1.mp3"
