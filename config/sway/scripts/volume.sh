#!/bin/bash
# volume.sh - Increases/decreases volume and shows a Dunst progress bar

# See if pactl or wpctl is available
if hash wpctl 2>/dev/null; then
    if [ "$1" == "up" ]; then
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
    elif [ "$1" == "down" ]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    elif [ "$1" == "mute" ]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    fi
    
    # Get current volume and mute state
    VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d. -f1)
    MUTE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -i MUTED)
else
    # Fallback to pactl if wpctl is not available
    if [ "$1" == "up" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +5%
    elif [ "$1" == "down" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ -5%
    elif [ "$1" == "mute" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi

    VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
    MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -i yes)
fi

if [ -n "$MUTE" ]; then
    notify-send -a "Volume" -h string:x-dunst-stack-tag:volume -t 1500 -u normal "Volume Muted" "🔇"
else
    notify-send -a "Volume" -h string:x-dunst-stack-tag:volume -h int:value:"$VOL" -t 1500 -u normal "Volume: $VOL%" "🔊"
fi
