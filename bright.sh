#!/bin/bash

if [[ $# -eq 0 ]] ; then
    cat /sys/class/backlight/intel_backlight/brightness

    exit 0

fi

sudo sh -c "echo $1 > /sys/class/backlight/intel_backlight/brightness"
