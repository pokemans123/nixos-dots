{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };
  home.packages = with pkgs; [
    basedpyright
    alejandra
    neovim
    texlab
    texliveFullWithDocs
    python313
    ripgrep
    gcc
    nil
    stylua
    lua-language-server
    bash-language-server
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
