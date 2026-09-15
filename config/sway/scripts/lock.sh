#!/bin/bash

# Source Pywal colors
source ~/.cache/wal/colors.sh

# Pywal colors to Swaylock format
C5="${color5:1}88"  # Resting ring (semi-transparent vibrant)
C6="${color6:1}ff"  # Typing highlight (full opacity)
C1="${color1:1}ff"  # Backspace highlight
C0="${color0:1}ff"  # Inside clear

# Get current wallpaper
WP=$(cat ~/.config/sway/current_wallpaper | cut -d'"' -f2)
WP_CLEAN=$(basename "$WP")

# Define cache path
CACHE="/tmp/swaylock_bg_${WP_CLEAN}_v2.png"

# Generate the background with blurred wallpaper and PERFECT center face if not cached
if [ ! -f "$CACHE" ]; then
    # Calculate perfect face size based on wallpaper resolution (Swaylock ring is 130px on 1080p logical)
    WP_H=$(magick identify -format '%h' "$WP")
    FACE_SIZE=$((WP_H * 240 / 1080))
    HALF_FACE=$((FACE_SIZE / 2))

    FACE_IMG="$HOME/.config/sway/assets/face.jpg"
    
    if [ -f "$FACE_IMG" ]; then
        magick "$WP" -scale 10% -blur 0x2 -resize 1000% \
          \( "$FACE_IMG" -resize ${FACE_SIZE}x${FACE_SIZE}^ -gravity center -extent ${FACE_SIZE}x${FACE_SIZE} \
             -alpha set -background none \( -size ${FACE_SIZE}x${FACE_SIZE} xc:none -fill white -draw "circle ${HALF_FACE},${HALF_FACE} ${HALF_FACE},0" \) \
             -compose DstIn -composite \) \
          -gravity center -compose over -composite "$CACHE"
    else
        magick "$WP" -scale 10% -blur 0x2 -resize 1000% "$CACHE"
    fi
fi

# Launch Swaylock with NCS Visualizer aesthetic
swaylock \
  --image "$CACHE" \
  --indicator-radius 130 \
  --indicator-thickness 4 \
  --inside-color 00000000 \
  --inside-clear-color 00000000 \
  --inside-ver-color 00000000 \
  --inside-wrong-color 00000000 \
  --line-color 00000000 \
  --line-clear-color 00000000 \
  --line-ver-color 00000000 \
  --line-wrong-color 00000000 \
  --ring-color "$C5" \
  --ring-clear-color "$C5" \
  --ring-ver-color 00ff00ff \
  --ring-wrong-color ff0000ff \
  --key-hl-color "$C6" \
  --bs-hl-color "$C1" \
  --separator-color 00000000 \
  --text-color 00000000 \
  --text-clear-color 00000000 \
  --text-ver-color 00000000 \
  --text-wrong-color 00000000 \
  --indicator-idle-visible
