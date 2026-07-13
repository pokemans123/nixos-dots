{ config, inputs, pkgs, ... }:
let
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  dotfiles = "${config.home.homeDirectory}/nixos-dots/config";
  configs = {
    nvim = "nvim";
    niri = "niri";
    hypr = "hypr";
    i3 = "i3";
    kitty = "kitty";
    rofi = "rofi";
    fastfetch = "fastfetch";
    tmux = "tmux";
    qtile = "qtile";
    alacritty = "alacritty";
  };
in

{
  imports = [
    ./modules/filebrowser.nix
    ./modules/programming.nix
    ./modules/entertainment.nix
    ./modules/emacs.nix
  ];
  home.username = "pranav";
  home.homeDirectory = "/home/pranav";
  programs.git = {
    enable = true;
    extraConfig = {
     credential.helper = "store";
    };
  };
  home.stateVersion = "26.05";
  # services.polkit-gnome.enable = true;
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
  home.sessionVariables = {
    DOOMDIR = "$HOME/nixos-dots/modules/doom";
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
      qmacs = "DOOMDIR=~/nixos-dots/modules/doom emacsclient -c -a 'emacs'";
      restart-emacs = "pkill emacs; sleep 2; emacs --daemon";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
            nrs() {
      	 sudo nixos-rebuild switch --flake ~/nixos-dots#"$1"
            }
            fastfetch -c ~/.config/fastfetch/config13.jsonc
	    nitch
	    export PATH="$HOME/.config/emacs/bin:$PATH"

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


  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = symlink "${dotfiles}/${subpath}";
    recursive = true;

  }) configs;
  home.packages = with pkgs; [
    libreoffice-fresh
    xournalpp
    fastfetch
    nitch
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
