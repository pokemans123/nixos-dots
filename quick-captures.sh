#!/usr/bin/env bash
set -euo pipefail

lock="/tmp/emacsclient-captures.lock"
exec 9>"$lock"
flock -n 9 || exit 0

file="$HOME/org/captures.org"

# Ask if a graphical frame exists. --alternate-editor="" auto-starts the
# daemon if it isn't running yet (in which case there'll be no frame).
frame_exists=$(emacsclient --alternate-editor="" -e \
  '(seq-some (function display-graphic-p) (frame-list))' 2>/dev/null || echo nil)

if [ "$frame_exists" = "t" ]; then
  # A frame already exists — raise it, focus it, open the file there
  emacsclient -n -e "
    (let ((f (seq-find (function display-graphic-p) (frame-list))))
      (raise-frame f)
      (select-frame-set-input-focus f)
      (with-selected-frame f (find-file \"$file\")))"
else
  # No frame yet (daemon may have just started) — create one and open the file
  emacsclient -c "$file"
fi
