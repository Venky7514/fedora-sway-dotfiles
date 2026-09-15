#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo " Fedora Sway Dotfiles Installer "
echo "=========================================="

# 1. Detect Fedora
if [ ! -f "/etc/fedora-release" ]; then
    echo "Warning: This setup is heavily optimized for Fedora."
    echo "You can proceed, but system integrations (like sway-systemd) may fail."
    read -p "Press Enter to continue or Ctrl+C to abort..."
fi

# 2. Check for required dependencies and install them
echo "Checking for required system packages..."
PACKAGES="sway waybar rofi-wayland foot wlogout swaylock swayidle dunst ImageMagick wl-clipboard grim slurp papirus-icon-theme thunar"
MISSING=""

for pkg in $PACKAGES; do
    if ! rpm -q "$pkg" >/dev/null 2>&1; then
        MISSING="$MISSING $pkg"
    fi
done

if [ -n "$MISSING" ]; then
    echo "The following packages are missing and need to be installed: $MISSING"
    sudo dnf install -y $MISSING
else
    echo "All system dependencies are already installed."
fi

# 3. Install Python dependencies (user level)
echo "Checking Python dependencies (pywal16, autotiling)..."
if ! command -v wal >/dev/null 2>&1 || ! command -v autotiling >/dev/null 2>&1; then
    echo "Installing pywal16 and autotiling via pip..."
    pip3 install --user --upgrade pywal16 autotiling
fi

# 4. Backup existing configurations
echo "Backing up existing configurations..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.config/dotfiles_backup_$TIMESTAMP"
mkdir -p "$BACKUP_DIR"

for conf in sway waybar rofi foot wlogout dunst; do
    if [ -d "$HOME/.config/$conf" ]; then
        echo "  Backing up ~/.config/$conf to $BACKUP_DIR/$conf"
        mv "$HOME/.config/$conf" "$BACKUP_DIR/"
    fi
done

# 5. Copy new configurations
echo "Installing new configurations..."
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.config"
cp -r "$REPO_DIR/config/"* "$HOME/.config/"

# Ensure bin directory exists
mkdir -p "$HOME/.local/bin"
cp -r "$REPO_DIR/bin/"* "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/"*

# Ensure wallpaper directory exists
mkdir -p "$HOME/Wallpapers"

# 6. Set up initial wallpaper state
if [ ! -f "$HOME/.config/sway/current_wallpaper" ]; then
    echo "Setting up default wallpaper configuration..."
    echo "set \$wallpaper \"$HOME/.config/sway/assets/default-wallpaper.jpg\"" > "$HOME/.config/sway/current_wallpaper"
fi

# 7. Symlink Dunst config for Pywal
echo "Setting up Dunst Pywal symlink..."
mkdir -p "$HOME/.config/dunst"
# Pywal will generate this file when it runs, but we create the symlink now
ln -sf "$HOME/.cache/wal/dunstrc" "$HOME/.config/dunst/dunstrc"

echo "=========================================="
echo " Installation Complete! "
echo "=========================================="
echo "To apply the new setup, either:"
echo " 1. Run 'swaymsg reload' if you are already in Sway."
echo " 2. Log out and log back in."
echo ""
echo "Note: The lock screen avatar is located at ~/.config/sway/assets/face.jpg"
echo "You can replace this image with your own."
