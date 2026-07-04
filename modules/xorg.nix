{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.oxwm.enable = true;
    windowManager.i3.enable = true;
    desktopManager.xfce.enable = true;
  };

  pkgs = with pkgs; [
    xwallpaper
    xclip
    maim
  ];
}
