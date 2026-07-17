{ config, lib, pkgs, ... }:
{
   services.emacs = {
      enable = true;
      package = pkgs.emacs30;
      defaultEditor = true;
   };

   programs.emacs = {
      enable = true;
      package = pkgs.emacs30;
   };


   home.packages = with pkgs; [
      ripgrep
      ispell
      shellcheck
      pandoc
      nerd-fonts.symbols-only
      fd
      sqlite
      gcc
      coreutils
      emacsPackages.pdf-view-restore
      emacsPackages.vterm
      emacsPackages.emacs-everywhere
      ydotool
      wtype
      wl-clipboard
   ];

   xdg.configFile."doom" = {
     source = config.lib.file.mkOutOfStoreSymlink "/home/pranav/nixos-dots/modules/doom/";
   };
}
