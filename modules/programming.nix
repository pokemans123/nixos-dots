{ pkgs, config, nixpkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };
  programs.direnv = {
   enable = true;
   nix-direnv.enable = true;
   enableZshIntegration = true;
  };
  nixpkgs.config.android_sdk.accept_license = true;
  home.packages = with pkgs; [
    basedpyright
    cmake
    android-studio
    alejandra
    neovim
    texlab
    texliveFullWithDocs
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
    cmake
    pkg-config
    (pkgs.python313.withPackages (ps: [ ps.numpy ]))
  ];
}
