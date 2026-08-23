#!/usr/bin/env sh

choice=$(printf "App Launcher\nBookmarks\nWallpaper & Theme\nActive Windows\nClipboard\nComboview[mango only]" | rofi -dmenu -i -p "Search")

case "$choice" in
    "Bookmarks") ~/nixos-dots/config/scripts/rofimarks.sh ;;
    "Wallpaper & Theme") noctalia msg panel-toggle wallpaper ;;
    "Active Windows") rofi -show window ;;
    "Clipboard") noctalia msg panel-toggle clipboard ;;
    "Comboview[mango only]") ~/nixos-dots/config/scripts/comboview.sh ;;
    "App Launcher") noctalia msg panel-toggle launcher ;;
esac
