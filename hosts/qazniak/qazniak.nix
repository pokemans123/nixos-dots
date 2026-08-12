{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 4;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "qazniak"; # Define your hostname.
  boot.resumeDevice = "/dev/nvme0n1p4";

  services.tor.enable = true;


  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-vaapi-driver
    ];
  };

  security.pki.certificateFiles = [
    /home/pranav/Downloads/root.crt
  ];
}
