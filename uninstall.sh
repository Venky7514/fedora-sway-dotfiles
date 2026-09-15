#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo " Fedora Sway Dotfiles Uninstaller "
echo "=========================================="

# Find the most recent backup
LATEST_BACKUP=$(ls -td "$HOME"/.config/dotfiles_backup_* 2>/dev/null | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "Error: No backup directory found in ~/.config/"
    echo "Cannot automatically restore previous configuration."
    exit 1
fi

echo "Found most recent backup: $LATEST_BACKUP"
read -p "Are you sure you want to restore this backup? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

# Remove current configs
echo "Removing current repository configurations..."
for conf in sway waybar rofi foot wlogout dunst; do
    if [ -d "$HOME/.config/$conf" ]; then
        rm -rf "$HOME/.config/$conf"
    fi
done

# Restore backup
echo "Restoring from $LATEST_BACKUP..."
cp -r "$LATEST_BACKUP/"* "$HOME/.config/"

echo "Removing custom scripts from ~/.local/bin..."
rm -f "$HOME/.local/bin/rofi-wallpaper"
rm -f "$HOME/.local/bin/papirus-folders"

echo "=========================================="
echo " Uninstallation Complete! "
echo "=========================================="
echo "Your previous configuration has been restored."
echo "You may want to run 'swaymsg reload' or log out."
