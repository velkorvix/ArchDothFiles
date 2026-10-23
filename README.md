# Arch Hyprland Dotfiles

Hyprland configuration for Arch Linux with RTX 3050.

## Dependencies

```
hyprland hypridle hyprlock waybar kitty wofi rofi waypaper   grim slurp libnotify playerctl brightnessctl wireplumber   thunar firefox zsh jetbrains-mono
```

Install:
```bash
sudo pacman -S hyprland hypridle hyprlock waybar kitty wofi rofi   grim slurp libnotify playerctl brightnessctl wireplumber   thunar firefox zsh

yay -S waypaper jetbrains-mono
```

## Install

```bash
git clone https://github.com/velkorvix/ArchDothFiles.git ~/.config/archdots
cd ~/.config/archdots

cp -r .config/cava ~/.config/
cp -r .config/hypr ~/.config/
cp -r .config/kitty ~/.config/
cp -r .config/rofi ~/.config/
cp -r .config/waybar ~/.config/
cp -r .config/wofi ~/.config/
cp -r .config/waypaper ~/.config/
cp -r wallpapers ~/.config/
```

Kitty is set to use `zsh`. If zsh is not your default shell:
```bash
chsh -s $(which zsh)
```

## Keybinds

| Key | Action |
|-----|--------|
| Super + Return | Terminal (kitty) |
| Super + Q | Close window |
| Super + E | File manager (thunar) |
| Super + M | Exit Hyprland |
| Super + R | App launcher (wofi) |
| Super + D | App launcher (rofi) |
| Super + B | Browser (firefox) |
| Super + V | Toggle float |
| Super + P | Pseudotile |
| Super + J | Toggle split |
| Super + L | Lock screen (hyprlock) |
| Print | Screenshot to clipboard |
| Super + Print | Screenshot region to clipboard |
| Super + Shift + S | Screenshot region to Pictures |
| Super + [1-0] | Switch workspace |
| Super + Shift + [1-0] | Move window to workspace |
| Super + S | Toggle special workspace |
| Super + Scroll | Switch workspace |
| Super + LMB/RMB | Move/resize window |
| XF86Audio* | Volume (wpctl) |
| XF86MonBrightness* | Brightness (brightnessctl) |
| XF86AudioNext/Prev/Play | Media (playerctl) |

## Wallpapers

```bash
waypaper set ~/.config/wallpapers/your-image.jpg
```

Or use `~/.config/hypr/hypr/wallpaper.sh`.
