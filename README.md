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
The installer script attempts to install the required dependencies using `dnf` and `pip`.
The core dependencies are:
- `sway`, `waybar`, `foot`, `rofi-wayland`, `wlogout`, `swaylock`, `swayidle`, `dunst`
- `python3-pip`, `ImageMagick`, `wl-clipboard`, `grim`, `slurp`
- `pywal16` and `autotiling` (installed via pip)
- `papirus-icon-theme`

## Installation
Clone the repository and run the install script:

```bash
git clone https://github.com/yourusername/fedora-sway-dotfiles.git
cd fedora-sway-dotfiles
./install.sh
```

### What the installer does:
1. Installs missing required packages via `dnf` (asks for `sudo`).
2. Installs `pywal16` and `autotiling` via `pip` (user-level).
3. Backs up any existing configurations in `~/.config/sway`, `waybar`, `rofi`, `foot`, and `wlogout`.
4. Copies the configurations from this repository into your `~/.config/` directory.
5. Copies custom binaries to `~/.local/bin/`.
6. Sets up a default Pywal wallpaper so Sway launches successfully on the first boot.

## Customization
- **Lock Screen Avatar:** Replace `~/.config/sway/assets/face.jpg` with your own image to customize the lock screen avatar.
- **Wallpapers:** Add your images to `~/Wallpapers/`. Press `Super + \` to open the wallpaper selector.

## Keybindings
- `Super + Space`: Rofi App Launcher
- `Super + E`: Thunar (File Manager)
- `Super + \`: Rofi Wallpaper Selector
- `Super + .`: Toggle Light/Dark Mode
- `Super + M`: Lock Screen
- `Super + Del`: Wlogout Menu
- `Print`: Select region to screenshot (copies to clipboard)

## Uninstallation
If you wish to revert to your previous setup, run:
```bash
./uninstall.sh
```
This will restore the backups created during installation. It will *not* uninstall the `dnf` packages.
