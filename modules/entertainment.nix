{ pkgs, inputs, ... }:

let
  # spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  # imports = [
  #  inputs.spicetify-nix.homeManagerModules.spicetify
  # ];
  # programs.spicetify = {
  #   enable = true;
  #   enabledExtensions = with spicePkgs.extensions; [
  #     adblockify
  #     hidePodcasts
  #     shuffle
  #   ];
  #   theme = spicePkgs.themes.catppuccin;
  #   colorScheme = "mocha";
  # };
  programs.vesktop = {
    enable = true;
    settings = {
      tray = true;
      minimzeToTray = true;
    };
  };
  programs.freetube = {
    enable = true;
    settings = {
      baseTheme = "catppuccinMocha";
    };
  };


  home.packages = with pkgs; [
    ryubing
    pear-desktop
    inputs.ytm-player.packages.${system}.default
    unstable.yt-dlp
  ];
}
