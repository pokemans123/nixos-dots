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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.tailscale = {
   enable = true;
  };

  users.users.manager = {
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

    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  programs.zsh.enable = true;

  hardware.bluetooth.enable = true;
  services.upower.enable = true;


  environment.systemPackages = with pkgs; [
    vim
    neovim
  ];
}
