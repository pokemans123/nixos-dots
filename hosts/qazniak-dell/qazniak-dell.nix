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

  boot.kernelPackages = pkgs.linuxPackages;
  networking.hostName = "qazniak-dell"; # Define your hostname.

  services.syncthing = {
    enable = true;
  };

  services.tailscale = {
   enable = true;
  };

  services.pihole-ftl = {
    enable = false;
    dns.upstream = [ "9.9.9.9" "1.1.1.1" ];
    lists = [
      {
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "hagezi blocklist";
      }
    ];
  };

  services.pihole-web = {
    enable = false;
    ports = [ "443s" ];
  };
}
