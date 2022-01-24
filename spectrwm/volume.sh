#!/bin/sh
pamixer $1 10
VOLUME=$(pamixer --get-volume-human)
dunstify --printid=999 --replace=999 "VOLUME: $VOLUME"
