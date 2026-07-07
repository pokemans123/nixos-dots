{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.i3.enable = true;
    windowManager.qtile.enable = true;
    desktopManager.xfce.enable = true;
  };
  environment.systemPackages = with pkgs; [
    xwallpaper
    xclip
    maim
    i3status
    xfce4-pulseaudio-plugin
  ];
}
