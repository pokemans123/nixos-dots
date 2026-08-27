#!/usr/bin/env bash

BOOKMARKS="$HOME/org/bookmarks.org"

# Tag -> command mapping
declare -A OPENERS=(
    [school]="helium"
    [misc]="librewolf"
    [yt]="mpv"
    [video]="mpv"
    [astronomy]="zen"
)

menu=$(
awk '
BEGIN {
    title=""
    url=""
    tags=""
}

function print_entry() {
    if (title != "" && url != "")
        printf "%s [%s]\t%s\t%s\n", title, tags, url, tags
}

/^\*+[[:space:]]+\[\[/ {

    print_entry()

    title=""
    url=""
    tags=""

    line=$0

    if (match(line, /\[\[([^]]+)\]\[([^]]+)\]\]/, m)) {
        url=m[1]
        title=m[2]
    }

    # Headline tags
    if (match(line, /:[[:alnum:]_@#%:-]+:$/, t)) {
        tags=t[0]
        gsub(/^:/,"",tags)
        gsub(/:$/,"",tags)
        gsub(/:/," ",tags)
    }

    next
}

/^:TAGS:/ {
    tags=$2
    for(i=3;i<=NF;i++)
        tags=tags " " $i
}

END {
    print_entry()
}
' "$BOOKMARKS"
)

selection=$(
printf "%s\n" "$menu" |
cut -f1 |
rofi -dmenu -i  -p "Bookmarks"
)

[[ -z "$selection" ]] && exit

entry=$(printf "%s\n" "$menu" |
awk -F'\t' -v sel="$selection" '$1==sel')

url=$(printf "%s" "$entry" | cut -f2)
tags=$(printf "%s" "$entry" | cut -f3)

# Check for video/yt tags first -> ask which player/site to use
is_video=0
for tag in $tags; do
    if [[ "$tag" == "yt" || "$tag" == "video" ]]; then
        is_video=1
        break
    fi
done

if [[ "$is_video" -eq 1 ]]; then
    choice=$(printf "YouTube\nMPV\n" | rofi -dmenu -i -p "Open video with")

    [[ -z "$choice" ]] && exit

    case "$choice" in
        YouTube)
            exec xdg-open "$url"
            ;;
        MPV)
            exec mpv "$url"
            ;;
    esac
fi

# Open with browser based on tag (fallback for non-video entries)
for tag in $tags; do
    if [[ -n "${OPENERS[$tag]}" ]]; then
        exec ${OPENERS[$tag]} "$url"
    fi
done

# Default
exec xdg-open "$url"
