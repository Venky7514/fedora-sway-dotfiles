#!/usr/bin/env python3
import sys
import os
import math
import subprocess

# Papirus standard colors roughly estimated
PAPIRUS_COLORS = {
    "black": (0, 0, 0),
    "blue": (33, 150, 243),
    "bluegrey": (96, 125, 139),
    "breeze": (61, 174, 233),
    "brown": (121, 85, 72),
    "carmine": (224, 76, 76),
    "cyan": (0, 188, 212),
    "darkcyan": (0, 150, 136),
    "deeporange": (255, 87, 34),
    "green": (76, 175, 80),
    "grey": (158, 158, 158),
    "indigo": (63, 81, 181),
    "magenta": (233, 30, 99),
    "nordic": (76, 86, 106),
    "orange": (255, 152, 0),
    "palebrown": (141, 110, 99),
    "paleorange": (255, 183, 77),
    "pink": (244, 143, 177),
    "red": (244, 67, 54),
    "teal": (0, 150, 136),
    "violet": (156, 39, 176),
    "white": (255, 255, 255),
    "yaru": (233, 84, 32),
    "yellow": (255, 235, 59)
}

def hex_to_rgb(hex_code):
    hex_code = hex_code.lstrip('#')
    return tuple(int(hex_code[i:i+2], 16) for i in (0, 2, 4))

def color_distance(c1, c2):
    return math.sqrt(sum((a - b) ** 2 for a, b in zip(c1, c2)))

if __name__ == "__main__":
    color_file = os.path.expanduser("~/.cache/wal/colors")
    if not os.path.exists(color_file):
        sys.exit(0)
        
    with open(color_file, "r") as f:
        lines = f.readlines()
        if len(lines) < 7:
            sys.exit(0)
        # color6 is index 6
        target_hex = lines[6].strip()
        
    target_rgb = hex_to_rgb(target_hex)
    
    closest_name = "blue"
    min_dist = float("inf")
    
    for name, rgb in PAPIRUS_COLORS.items():
        dist = color_distance(target_rgb, rgb)
        if dist < min_dist:
            min_dist = dist
            closest_name = name

    # Apply to Papirus-Dark and Papirus
    print(f"Applying Papirus color: {closest_name} (closest to {target_hex})")
    subprocess.run([os.path.expanduser("~/.local/bin/papirus-folders"), "-C", closest_name, "--theme", "Papirus-Dark"])
    subprocess.run([os.path.expanduser("~/.local/bin/papirus-folders"), "-C", closest_name, "--theme", "Papirus"])
