# Arch Hyprland Dotfiles

My Hyprland configuration for Arch Linux with RTX 3050.

## Requirements

- Hyprland
- Waybar
- Kitty
- Waypaper
- Hypridle
- Wofi
- Grim + Slurp (screenshots)
- Playerctl
- Brightnessctl

## Installation

1. Clone the repository:
```bash
git clone https://github.com/mark-smitov/ArchDothFiles.git ~/.config/archdots
cd ~/.config/archdots
```

2. Create symlinks:
```bash
ln -sf $(pwd)/.config/hypr ~/.config/hypr
ln -sf $(pwd)/.config/waybar ~/.config/waybar
ln -sf $(pwd)/.config/kitty ~/.config/kitty
ln -sf $(pwd)/wallpapers ~/.config/wallpapers
```

3. Install fonts:
```bash
# JetBrains Mono for Kitty
yay -S jetbrains-mono
```

4. Log out and log back in to Hyprland, or restart waybar:
```bash
killall waybar && waybar &
```

## Keybindings

| Key | Action |
|-----|--------|
| Super + Return | Terminal (kitty) |
| Super + Q | Close window |
| Super + E | File manager |
| Super + M | Shutdown menu |
| Super + R | App launcher (wofi) |
| Super + B | Browser |
| Super + V | Float window |
| Super + P | Pseudotile |
| Super + J | Toggle split |
| Super + L | Lock screen |
| Print | Screenshot to clipboard |
| Super + Print | Screenshot region |
| Super + Shift + S | Screenshot region to Pictures |

## Wallpapers

Wallpapers are located in `wallpapers/`. To change wallpaper, run:
```bash
waypaper set ~/.config/wallpapers/your-image.jpg
```

Or use the wallpaper script in `~/.config/hypr/hypr/wallpaper.sh`