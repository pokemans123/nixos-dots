#!/usr/bin/env sh

prompt="Word to define: "
word=$(printf "" | rofi -dmenu -p "$prompt")

[ -z "$word" ] && exit 0

rofi -e "$( curl -s dict://dict.org/d:${word})"
