#!/bin/bash
# applies Pywal colors to GTK, Thunar, Papirus, wlogout, and dunst.

# GTK theme settings
if [ -f ~/.cache/wal/light_mode ]; then
    echo -e "[Settings]\ngtk-theme-name=Adwaita\ngtk-icon-theme-name=Papirus\ngtk-application-prefer-dark-theme=0" > ~/.config/gtk-3.0/settings.ini
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light' 2>/dev/null || true
    xfconf-query -c xsettings -p /Net/ThemeName -n -t string -s "Adwaita" 2>/dev/null || true
    xfconf-query -c xsettings -p /Net/IconThemeName -n -t string -s "Papirus" 2>/dev/null || true
else
    echo -e "[Settings]\ngtk-theme-name=Adwaita-dark\ngtk-icon-theme-name=Papirus-Dark\ngtk-application-prefer-dark-theme=1" > ~/.config/gtk-3.0/settings.ini
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
    xfconf-query -c xsettings -p /Net/ThemeName -n -t string -s "Adwaita-dark" 2>/dev/null || true
    xfconf-query -c xsettings -p /Net/IconThemeName -n -t string -s "Papirus-Dark" 2>/dev/null || true
fi

# Restart Thunar daemon so it reads the new settings
thunar -q 2>/dev/null || true

# Symlink Pywal GTK CSS
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
ln -sf ~/.cache/wal/gtk.css ~/.config/gtk-3.0/gtk.css
ln -sf ~/.cache/wal/gtk.css ~/.config/gtk-4.0/gtk.css

# Sync Papirus folder color to Pywal accent
python3 ~/.config/sway/scripts/papirus-pywal.py

# Regenerate wlogout icons
bash ~/.config/wlogout/update_icons.sh
ln -sf ~/.cache/wal/wlogout.css ~/.config/wlogout/style.css
