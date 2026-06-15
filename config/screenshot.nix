{ pkgs }:

pkgs.writeShellScriptBin "screenshot" ''
   DIR="$HOME/Pictures/Screenshots"
   mkdir -p "$DIR"
   TEMP="/tmp/screenshot-$(date '+%Y%m%d-%H%M%S').png"
   FILE="$DIR/$(date '+%Y%m%d-%H%M%S').png"

   ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" "$TEMP"

   ${pkgs.satty}/bin/satty --filename "$TEMP" --output-filename "$FILE" --copy-command ${pkgs.wl-clipboard}/bin/wl-copy

   rm "$TEMP"


''
