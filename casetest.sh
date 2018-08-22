#!/bin/bash

ping -c 1 ysdasdasdasdasa.asdasdasru
if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi
