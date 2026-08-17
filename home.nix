{ config, inputs, pkgs, ... }:
let
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  dotfiles = "${config.home.homeDirectory}/nixos-dots/config";
  configs = {
    nvim = "nvim";
    # niri = "niri";
    hypr = "hypr";
    i3 = "i3";
    kitty = "kitty";
    rofi = "rofi";
    fastfetch = "fastfetch";
    # qtile = "qtile";
    mango = "mango";
    foot = "foot";
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

  services.gnome-keyring.enable = true;

  home.stateVersion = "26.05";
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
      restart-emacs = "pkill emacs; sleep 2; emacs --daemon";
      qmacs = "emacsclient -c -a 'emacs'";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
            nrs() {
      	 doas nixos-rebuild switch --flake ~/nixos-dots#"$1"
            }
            define() {
                     curl dict://dict.org/d:"$1"
            }
            fastfetch -c ~/.config/fastfetch/config13.jsonc
	    nitch
	    export PATH="$HOME/.config/emacs/bin:$PATH"
    '';

  };
home.file.".config/net.imput.helium/NativeMessagingHosts/org.keepassxc.keepassxc_browser.json".source =
  "${pkgs.keepassxc}/lib/mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json";

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
    gcr
    xournalpp
    fastfetch
    nitch
    rofi
    keepassxc
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
    gocryptfs
    localsend
    btop
    inputs.astroimagej.packages.${pkgs.system}.astroimagej
    inputs.helium.packages.${pkgs.system}.default
    rquickshare
    scrcpy
    android-tools
    usbutils
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
