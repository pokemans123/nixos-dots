{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };
  home.packages = with pkgs; [
    basedpyright
    alejandra
    python313
    ripgrep
    gcc
    nil
    stylua
    tmux
    vscodium
    zed-editor
    nixpkgs-fmt
    nodejs
    cargo
    jdt-language-server
    ruff
  ];
}
