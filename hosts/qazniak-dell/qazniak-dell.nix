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

  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.syncthing = {
    enable = true;
  };


  services.tailscale = {
   enable = true;
  };

  users.users.pranav = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "networkmanager"
      "video"
      "storage"
      "lpadmin"
      "render"
      "uinput"
    ];

    hardware.uinput.enable = true;
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  hardware.bluetooth.enable = true;
  services.upower.enable = true;


  environment.systemPackages = with pkgs; [
    vim
    neovim
  ];
}
