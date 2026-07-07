{ config, pkgs, ... }:
{
   programs.emacs = {
      enable = true;
      package = pkgs.emacs30;
   };

   home.file.".config/doom" = {
     source = ./doom;
     recursive = true;
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
   ];
}
