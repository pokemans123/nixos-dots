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
      emacsPackages.ghostel
      emacsPackages.org-fragtog
      emacsPackages.emacs-everywhere
      emacsPackages.org-roam
      emacsPackages.org-roam-ui
      emacsPackages.mu4e
      mu
      isync
      ydotool
      wtype
      wl-clipboard
   ];

   programs.mbsync = {
     enable = true;
   };


   programs.password-store.enable  = true;

   accounts.email = {
     maildirBasePath = "Mail";

     accounts.gmail = {
       primary = true;
       address = "pranavarunkumar2010@gmail.com";
       userName = "pranavarunkumar2010@gmail.com";
       realName = "Pranav Arunkumar";
       passwordCommand = "pass show gmail/app-password";

       imap = {
         host = "imap.gmail.com";
         tls.useStartTls = false;
       };

       maildir.path = "gmail";

       mbsync = {
         enable = true;
         create = "both";
         expunge = "both";
         subFolders = "Verbatim";
         patterns = [ "*" "![Gmail]*" "\"[Gmail]/Sent Mail\"" "\"[Gmail]/All Mail\"" "\"[Gmail]/Trash\"" ];

       };
       mu.enable = true;
     };
   };

   xdg.configFile."doom" = {
     source = config.lib.file.mkOutOfStoreSymlink "/home/pranav/nixos-dots/modules/doom/";
   };
}
