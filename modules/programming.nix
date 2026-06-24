{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };
  home.packages = with pkgs; [
    basedpyright
    python313
    jdt-language-server
    ruff
  ];
}
