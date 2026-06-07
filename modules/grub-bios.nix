{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

   boot.loader.grub = {
      enable = true;
      device = lib.mkDefault "/dev/sda";
      efiSupport = false;
      useOSProber = false;
      configurationLimit = 4;
   };

  boot.kernelPackages = pkgs.linuxPackages_lts;

}
