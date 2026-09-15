#!/bin/bash
# Toggle between light and dark mode

if [ ! -f ~/.config/sway/current_wallpaper ]; then
    exit 1
fi

WP=$(grep -o '".*"' ~/.config/sway/current_wallpaper | tr -d '"')
WP_NAME=$(basename "$WP")
THUMB_PATH="$HOME/.cache/wal/thumbs/${WP_NAME}.jpg"

# Fallback to original if thumbnail doesn't exist
[ -f "$THUMB_PATH" ] || THUMB_PATH="$WP"

# Block Pywal from setting wallpaper itself
mkdir -p /tmp/wal_block
for cmd in swaymsg swaybg swww feh display xwallpaper; do
    ln -sf /usr/bin/true "/tmp/wal_block/$cmd"
done

# Toggle mode
if [ -f ~/.cache/wal/light_mode ]; then
    rm ~/.cache/wal/light_mode
    PATH="/tmp/wal_block:$PATH" wal -q -n -i "$THUMB_PATH"
else
    touch ~/.cache/wal/light_mode
    PATH="/tmp/wal_block:$PATH" wal -q -n -i "$THUMB_PATH" -l
fi

# Apply Sway border colors instantly
source ~/.cache/wal/colors.sh
swaymsg "client.focused $color6 $color6 $background $color6 $color6; \
client.focused_inactive $color2 $background $color7 $color2 $color2; \
client.unfocused $color2 $background $color7 $color2 $color2; \
client.urgent $color1 $color1 $foreground $color1 $color1"

# Update Waybar tooltip + CSS
pkill -RTMIN+9 waybar
killall -SIGUSR2 waybar

# Instantly reload Dunst synchronously before backgrounding
dunstctl close-all 2>/dev/null || true
dunstctl reload 2>/dev/null || true

# Apply GTK/Papirus/wlogout in background
bash ~/.config/sway/scripts/apply-theme.sh > /dev/null 2>&1 & disown
