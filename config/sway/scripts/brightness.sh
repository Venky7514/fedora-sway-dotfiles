#!/bin/bash
# brightness.sh - Increases/decreases brightness and shows a Dunst progress bar

if [ "$1" == "up" ]; then
    brightnessctl set +5%
elif [ "$1" == "down" ]; then
    brightnessctl set 5%-
fi

# Get current brightness percentage
MAX=$(brightnessctl m)
CUR=$(brightnessctl g)
PERC=$(( CUR * 100 / MAX ))

notify-send -a "Brightness" -h string:x-dunst-stack-tag:brightness -h int:value:"$PERC" -t 1500 -u normal "Brightness: $PERC%" "☀️"
