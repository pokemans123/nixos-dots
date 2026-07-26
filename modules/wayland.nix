{ config, inputs, lib, pkgs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.niri = {
    enable = true;
    package = inputs.niri-nix.packages.${pkgs.stdenv.hostPlatform.system}.niri;
  };

  programs.mangowc = {
    enable = true;
    package = unstable.mango;
  };

  environment.systemPackages= with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
    hyprcursor
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    rose-pine-hyprcursor
    (import ../config/screenshot.nix { inherit pkgs; })
  ];
}
