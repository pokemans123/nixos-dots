{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      shuffle
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
{
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
  home.Packages = with pkgs; [
    spotify
    ryubing
  ];
}
