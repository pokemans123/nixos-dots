{ config, lib, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = with pkgs.kdePackages; [
    calendarsupport
    bomber
    ffmpegthumbs
    filelight
    ghostwriter
    kalgebra
    kamoso
    kauth
    kcalendarcore
    kdeconnect-kde
    kholidays
    killbots
    kmail
    qtstyleplugin-kvantum
  ];
}
