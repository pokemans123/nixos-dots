# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  security.doas = {
    enable = true;
    wheelNeedsPassword = true;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.tumbler.enable = true;
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

  programs.git.enable = true;

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
  nixpkgs.config = {
    allowUnfree = true;
    # permittedInsecurePackages = [
    #   "electron-40.10.5"
    # ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  services.displayManager.ly.enable = true;

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true;


  # Enable CUPS to print documents.
  services.avahi = {
   enable = true;
   nssmdns4 = true;
  };
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
  hardware.uinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  services.gvfs.enable = true;
  programs.zsh = {
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

    addressbook.subscriptions = [
      "http://inr.i2p/export/alive-hosts.txt"
      "http://i2p-projekt.i2p/hosts.txt"
      "http://stats.i2p/cgi-bin/newhosts.txt"
    ];
    enableIPv4 = true;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    slurp
    jq
    nixd
    git
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
    tumbler
    brightnessctl
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    gamescope
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    cmake
    gnumake
    clang
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.intone-mono
    nerd-fonts.monofur
    nerd-fonts.anonymice
    nerd-fonts.iosevka
    nerd-fonts.daddy-time-mono
    nerd-fonts.sauce-code-pro
    redhat-official-fonts
    corefonts
    vista-fonts
  ];

  system.stateVersion = "26.05"; # Did you read the comment?

}
