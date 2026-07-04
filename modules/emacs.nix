{ config, pkgs, ... }:
{
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
   ];
}
