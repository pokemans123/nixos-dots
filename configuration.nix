# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, inputs, lib, pkgs, ... }:

{



  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          "f23+leftshift+leftmeta" = "rightcontrol";
        };
      };
    };
  };

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.oxwm.enable = true;
    windowManager.i3.enable = true;
  };
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.displayManager.ly.enable = true;

  services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true;



  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pranav = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager" "video" "storage" "lpadmin" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  services.gvfs.enable = true;
  programs.firefox.enable = true;
  programs.zsh = {
    enable = true;
  };
  programs.hyprland.enable = true;

  programs.niri = {
    package = pkgs.niri;
    enable = true;
  };

  services.i2pd = {
    enable = true;
    address = "127.0.0.1";
    proto = {
      http.enable = true;
      socksProxy.enable = true;
      httpProxy.enable = true;
      sam.enable = true;
      i2cp = {
        enable = true;
        address = "127.0.0.1";
        port = 7654;
      };
    };
    enableIPv4 = true;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    nixd
    git
    xwayland-satellite
    ntfs3g
    wget
    kitty
    bluez
    bluez-tools
    gvfs
    wine64
    qbittorrent
    xd
    winetricks
    playerctl
    brightnessctl
    pkgs.android-studio
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  nixpkgs.config.android_sdk.accept_license = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.intone-mono
    nerd-fonts.monofur
    nerd-fonts.anonymice
    redhat-official-fonts
    corefonts
    vista-fonts
  ];

  system.stateVersion = "26.05"; # Did you read the comment?

}

