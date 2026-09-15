# Fedora Sway Dotfiles

This is my personal Fedora Sway desktop configuration. It focuses on a clean, dynamic, Pywal-integrated aesthetic while retaining the solid foundation of Fedora's default system integrations.

## Features
- **Sway:** Base window manager with modular config (relies on Fedora's native `layered-include`).
- **Waybar:** Clean, module-based top bar with dynamic Pywal colors and WirePlumber audio integration.
- **Rofi (Wayland):** Application launcher and custom gallery-style wallpaper selector.
- **Foot:** Fast Wayland-native terminal emulator.
- **Pywal16:** Instant, dynamic theme generation across Sway, Waybar, Foot, Rofi, Dunst (notifications), and GTK/Papirus icons.
- **Wlogout:** Customized logout menu with blurred background.
- **Swaylock:** Custom locking script with a blurred, avatar-centered visualizer aesthetic.

## Target Environment
This setup is specifically designed for **Fedora Linux** running the **Sway** window manager. It relies on Fedora's specific `sway-systemd` integration and default config structure. It may require manual tweaking to work on Arch, Ubuntu, or other distributions.

## Prerequisites
The core dependencies are:
- `sway`, `waybar`, `foot`, `rofi-wayland`, `wlogout`, `swaylock`, `swayidle`, `dunst`
- `python3-pip`, `ImageMagick`, `wl-clipboard`, `grim`, `slurp`
- `pywal16` and `autotiling` (installed via pip)
- `papirus-icon-theme`

## Installation
There is no automated install script. You can manually copy the configuration files you want into your own `~/.config/` directory.

```bash
git clone https://github.com/yourusername/fedora-sway-dotfiles.git
cd fedora-sway-dotfiles

# Copy the core configurations
cp -r config/* ~/.config/

# Copy the custom scripts to your local bin (make sure it's in your $PATH)
mkdir -p ~/.local/bin
cp -r bin/* ~/.local/bin/

# Set up the Dunst Pywal symlink manually
ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
```

### Pywal Bootstrap
Since everything in this setup is dynamically themed using Pywal16, **Sway will crash on its first boot** if the Pywal cache hasn't been generated yet (because it won't be able to find `~/.cache/wal/colors-sway`).

Before you reload Sway for the first time, you must run Pywal manually to generate the initial theme cache:
```bash
wal -q -t -n -i ~/.config/sway/assets/default-wallpaper.jpg
```

## Customization
- **Lock Screen Avatar:** Replace `~/.config/sway/assets/face.jpg` with your own image to customize the lock screen avatar.
- **Wallpapers:** Add your images to `~/Wallpapers/`. Press `Super + \` to open the wallpaper selector. You can find my wallpapers in /Wallpapers

## Keybindings
- `Super + Space`: Rofi App Launcher
- `Super + E`: Thunar (File Manager)
- `Super + \`: Rofi Wallpaper Selector
- `Super + .`: Toggle Light/Dark Mode
- `Super + M`: Lock Screen
- `Super + Del`: Wlogout Menu
- `Print`: Select region to screenshot (copies to clipboard)
