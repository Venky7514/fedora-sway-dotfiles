#!/bin/bash
source ~/.cache/wal/colors.sh

mkdir -p ~/.cache/wal/wlogout_icons

for icon in lock logout suspend reboot shutdown hibernate; do
    if [ -f "/usr/share/wlogout/icons/${icon}.png" ]; then
        # Normal state (Accent color)
        magick "/usr/share/wlogout/icons/${icon}.png" -fill "$color6" -colorize 100% ~/.cache/wal/wlogout_icons/${icon}.png
        # Hover state (Background color to contrast against Accent background)
        magick "/usr/share/wlogout/icons/${icon}.png" -fill "$background" -colorize 100% ~/.cache/wal/wlogout_icons/${icon}_hover.png
    fi
done
