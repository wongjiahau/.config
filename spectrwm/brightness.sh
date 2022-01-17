#!/bin/sh
brightnessctl set $1
BRIGHTNESS=$(brightnessctl info | awk -F'[()]' '{print $2}' | xargs)
dunstify --printid=888 --replace=888 "BRIGHTNESS: $BRIGHTNESS"
