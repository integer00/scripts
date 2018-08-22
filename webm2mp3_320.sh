#!/bin/sh


ffmpeg -i "$1" -acodec libmp3lame -ar 44100 -b:a 320k "$1.mp3"
