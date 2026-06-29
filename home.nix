{ config, inputs, pkgs, ... }:
let
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  dotfiles = "${config.home.homeDirectory}/nixos-dots/config";
in

{
  imports = [
    ./modules/filebrowser.nix
    ./modules/programming.nix
    ./modules/entertainment.nix
  ];
  home.username = "pranav";
  home.homeDirectory = "/home/pranav";
  programs.git.enable = true;
  home.stateVersion = "26.05";
  # services.polkit-gnome.enable = true;
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
      ];
      theme = "minimal";
    };
    shellAliases = {
      btw = "echo I use nixos, btw";
      ls = "lsd";
      xd = "XD";
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
  programs.keepassxc = {
    enable = true;
    settings = {
      FdoSecrets.Enabled = true;
      Browser = {
        Enabled = true;
        AlwaysAllowAccess = true;
        AlwaysAllowUpdate = true;
        HttpAuthPermission = true;
      };
    };
  };
  programs.onlyoffice = {
    enable = true;
    settings = {
      UITheme = "theme-contrast-dark";
      titlebar = "custom";
      maximized = false;
    };
  };


  xdg.configFile."hypr" = {
    source = symlink "${dotfiles}/hypr/";
    recursive = true;
  };

  xdg.configFile."rofi" = {
    source = symlink "${dotfiles}/rofi/";
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
  xdg.configFile."tmux" = {
    source = symlink "${dotfiles}/tmux/";
    recursive = true;
  };
  home.packages = with pkgs; [
    libreoffice-fresh
    xournalpp
    fastfetch
    rofi
    nwg-look
    candy-icons
    pywalfox-native
    tor-browser
    gparted
    _7zip-zstd
    yazi
    adw-gtk3
    lsd
    bat
    gtk2
    localsend
    gocryptfs
    thunderbird
    inputs.astroimagej.packages.${pkgs.system}.astroimagej
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })
  ];
}
