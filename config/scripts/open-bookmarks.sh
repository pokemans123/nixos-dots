#!/usr/bin/env bash
# rofi-bookmarks: browse ~/org/bookmarks.org entries in rofi, open in Zen Browser
#

set -euo pipefail

BOOKMARKS_FILE="${BOOKMARKS_FILE:-$HOME/org/bookmarks.org}"
BROWSER_CMD="${BROWSER_CMD:-zen-browser}"

# --- Per-tag browser overrides ----------------------------------------------
#
# Most tags open in Zen (BROWSER_CMD above). Any tag listed here opens in a
# different browser entirely instead. Workspace switching is skipped for
# these, since it doesn't apply outside of Zen.
declare -A TAG_BROWSER=(
    [school]="helium"
    # add more tag -> browser overrides here
)
# -----------------------------------------------------------------------------

# --- Workspace switching (X11 only, requires xdotool) -----------------------
#
# Zen doesn't have a stable/released way to open a link directly into a named
# workspace yet. There's an open PR (zen-browser/desktop#14104) adding a
# --zen-workspace flag, but as of writing it hasn't been merged/released.
#
# Workaround: Zen lets you assign a custom keyboard shortcut to switch to
# each workspace (Settings > Keyboard Shortcuts > "Switch to Workspace N").
# Assign one per workspace, then map your org tags to those shortcuts below.
# Zen opens external links in whichever workspace was last active, so
# switching first and then opening the URL lands it in the right place.
#
# Set WORKSPACE_SWITCH=1 to enable this. Leave at 0 to just open links
# without touching workspaces.
WORKSPACE_SWITCH="${WORKSPACE_SWITCH:-1}"

# Map org :TAGS: values to the xdotool key combo you assigned in Zen.
declare -A TAG_WORKSPACE=(
    [misc]="ctrl+1"
    [personal]="ctrl+2"
    [work]="ctrl+3"
    # add more tag -> shortcut mappings here
)

# Window class Zen registers with the X server. Verify with:
#   xdotool search --name "Zen" getwindowclassname
ZEN_WM_CLASS="${ZEN_WM_CLASS:-zen}"

switch_to_workspace_for_tag() {
    local tag="$1"
    local combo="${TAG_WORKSPACE[$tag]:-}"

    [[ "$WORKSPACE_SWITCH" == "1" ]] || return 0
    [[ -n "$combo" ]] || return 0
    command -v xdotool >/dev/null 2>&1 || return 0

    local win
    win=$(xdotool search --class "$ZEN_WM_CLASS" | head -n1 || true)
    [[ -n "$win" ]] || return 0

    xdotool windowactivate "$win"
    sleep 0.15
    xdotool key --window "$win" "$combo"
    sleep 0.15
}
# -----------------------------------------------------------------------------

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

# Extract the corresponding tag and URL by line number
selected_line=$(echo "$entries" | awk -F'\t' -v idx="$selected_index" 'NR-1==idx {print}')
selected_tag=$(echo "$selected_line" | awk -F'\t' '{print $1}')
selected_url=$(echo "$selected_line" | awk -F'\t' '{print $3}')

if [[ -z "$selected_url" ]]; then
    notify-send "Bookmarks" "Could not resolve URL for selection" 2>/dev/null || true
    exit 1
fi

# Pick the browser: a per-tag override if one exists, otherwise the default.
open_cmd="${TAG_BROWSER[$selected_tag]:-$BROWSER_CMD}"

if [[ "$open_cmd" == "$BROWSER_CMD" ]]; then
    switch_to_workspace_for_tag "$selected_tag"
fi

"$open_cmd" "$selected_url" &
