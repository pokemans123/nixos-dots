{ config, pkgs, ... }:
let
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  dotfiles = "${config.home.homeDirectory}/nixos-dots/config";
in


{
  home.username = "pranav";
  home.homeDirectory = "/home/pranav";
  programs.git.enable = true;
  home.stateVersion = "26.05";
  services.polkit-gnome.enable = true;
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      btw = "echo I use nixos, btw";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
            nrs() {
      	 sudo nixos-rebuild switch --flake ~/nixos-dots#"$1"
            }
            fastfetch -c ~/.config/fastfetch/config13.jsonc

    '';

  };
  programs.vesktop = {
    enable = true;
    settings = {
      tray = true;
      minimzeToTray = true;
    };
  };

  xdg.configFile."hypr" = {
    source = symlink "${dotfiles}/hypr/";
    recursive = true;
  };

  xdg.configFile."niri" = {
    source = symlink "${dotfiles}/niri/";
    recursive = true;
  };
  xdg.configFile."nvim" = {
    source = symlink "${dotfiles}/nvim/";
    recursive = true;
  };
  xdg.configFile."kitty" = {
    source = symlink "${dotfiles}/kitty/";
    recursive = true;
  };
  xdg.configFile."fastfetch" = {
    source = symlink "${dotfiles}/fastfetch/";
    recursive = true;
  };
  xdg.configFile."i3" = {
    source = symlink "${dotfiles}/i3/";
    recursive = true;
  };
  xdg.configFile."oxwm" = {
    source = symlink "${dotfiles}/oxwm/";
    recursive = true;
  };
  home.packages = with pkgs; [
    hyprland
    niri
    neovim
    xournalpp
    ripgrep
    gcc
    fastfetch
    nil
    nixpkgs-fmt
    nodejs
    cargo
    keepassxc
    rofi
    thunar
    (import ./config/screenshot.nix { inherit pkgs; })
    thunar-volman
    nwg-look
    stylua
    candy-icons
    ryubing
    alejandra
    pywalfox-native
    tor-browser
    gparted
    _7zip-zstd
    yazi
    adw-gtk3
    (pkgs.writeShellApplication
      {
        name = "ns";
        runtimeInputs = with pkgs; [
          fzf
          nix-search-tv
        ];
        text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
      })
  ];


}
