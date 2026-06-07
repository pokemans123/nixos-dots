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
  programs.zsh = {
    enable = true;
    shellAliases = {
      btw = "echo I use nixos, btw";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dots#qazniak";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

  };
  xdg.configFile."hypr" = {
    source = symlink "${dotfiles}/hypr/";
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
  home.packages = with pkgs; [
    hyprland
    neovim
    ripgrep
    gcc
    fastfetch
    nil
    nixpkgs-fmt
    nodejs
    cargo
    thunar
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
