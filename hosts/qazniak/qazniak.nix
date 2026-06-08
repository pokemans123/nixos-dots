{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 4;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "qazniak"; # Define your hostname.
}
