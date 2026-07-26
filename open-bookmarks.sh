#!/usr/bin/env sh

# Setup:
#   chmod +x rofi-bookmarks.sh
#   Bind it to a key in your WM (e.g. i3/sway: bindsym $mod+b exec rofi-bookmarks.sh)
#
# Config (env vars, optional):
#   BOOKMARKS_FILE  - path to your org file (default: ~/org/bookmarks.org)
#   BROWSER_CMD     - command to launch Zen Browser (default: zen-browser)
#                     Change this to whatever the actual binary/launcher is on
#                     your system, e.g. "zen", "/usr/bin/zen-browser", or a
#                     flatpak run command.

set -euo pipefail

BOOKMARKS_FILE="${BOOKMARKS_FILE:-$HOME/org/bookmarks.org}"
BROWSER_CMD="${BROWSER_CMD:-zen}"

if [[ ! -f "$BOOKMARKS_FILE" ]]; then
    notify-send "Bookmarks" "File not found: $BOOKMARKS_FILE" 2>/dev/null || true
    exit 1
fi

# Parse the org file into TSV: tag \t title \t url
entries=$(python3 - "$BOOKMARKS_FILE" <<'PYEOF'
import re
import sys

path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    text = f.read()

# Split into headline blocks starting with "** "
blocks = re.split(r'(?m)^\*\* ', text)[1:]

link_re = re.compile(r'\[\[(.*?)\]\[(.*?)\]\]')
tag_re = re.compile(r':TAGS:\s*(.*)')

for block in blocks:
    first_line = block.splitlines()[0]
    m = link_re.search(first_line)
    if not m:
        continue
    url, title = m.group(1), m.group(2)

    tag_match = tag_re.search(block)
    tags = tag_match.group(1).strip() if tag_match else ""

    # Guard against tabs/newlines breaking the TSV format
    title = title.replace("\t", " ")
    tags = tags.replace("\t", " ")

    print(f"{tags}\t{title}\t{url}")
PYEOF
)

if [[ -z "$entries" ]]; then
    notify-send "Bookmarks" "No bookmarks found in $BOOKMARKS_FILE" 2>/dev/null || true
    exit 1
fi

# Build the rofi display list: "[tag] Title"
display_list=$(echo "$entries" | awk -F'\t' '{printf "[%s] %s\n", $1, $2}')

# Show rofi, get back the index of the selected line (0-based)
selected_index=$(echo "$display_list" | rofi -dmenu -i -p "Bookmarks" -format i)

if [[ -z "$selected_index" ]]; then
    exit 0
fi

# Extract the corresponding URL by line number
selected_url=$(echo "$entries" | awk -F'\t' -v idx="$selected_index" 'NR-1==idx {print $3}')

if [[ -z "$selected_url" ]]; then
    notify-send "Bookmarks" "Could not resolve URL for selection" 2>/dev/null || true
    exit 1
fi

"$BROWSER_CMD" "$selected_url" &
