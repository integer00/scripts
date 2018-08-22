#!/bin/sh

a="${1}"

/usr/bin/shnsplit -f *.cue -t "%p - %n %t" -o flac *.flac
