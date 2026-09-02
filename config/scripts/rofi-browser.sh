#!/usr/bin/env sh

url="$1"

browser=$(printf '%s\n' "Librewolf" "Zen" "Helium" | rofi -dmenu -p "Open with: ")

case "$browser" in
    "Librewolf")
        librewolf "$url";;
    "Zen")
        zen "$url";;
    "Helium")
        helium "$url";;
esac
