{ config, lib, pkgs, ... }:

pkgs.writeSheelScriptBin "emacs-projects" ''
   set -euo pipefail

   EMACS_APP_ID_PATTERN='(?i)^emacs$'

   WAIT_TIMEOUT=10

''
