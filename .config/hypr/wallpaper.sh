#!/bin/bash
# Wallpaper picker for awww.
# Original ArchDothFiles wallpaper.sh depended on wal, pywalfox, swayosd-server,
# awww and swaync-client; only awww is relevant here, so this is a trimmed rewrite.

WALLPAPER_DIR="$HOME/.config/wallpapers"

menu() {
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
        -printf 'img:%f\n' | sort
}

main() {
    command -v awww >/dev/null || { notify-send "Wallpaper" "awww is not installed"; return 1; }
    command -v wofi  >/dev/null || { notify-send "Wallpaper" "wofi is not installed"; return 1; }

    choice=$(menu | wofi --dmenu --prompt "Обои" --width 500 --height 400)
    [ -n "$choice" ] || return 0

    selected="$WALLPAPER_DIR/${choice#img:}"
    [ -f "$selected" ] || { notify-send "Wallpaper" "Файл не найден: $selected"; return 1; }

    awww img "$selected" \
        --transition-type any \
        --transition-fps 60 \
        --transition-duration .5

    notify-send "Wallpaper" "Установлено: ${choice#img:}"
}

main