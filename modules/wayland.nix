{ config, inputs, lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.niri = {
    enable = true;
    package = inputs.niri-nix.packages.${pkgs.stdenv.hostPlatform.system}.niri;
  };
  environment.systemPackages= with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
    hyprcursor
    rose-pine-hyprcursor
    (import ../config/screenshot.nix { inherit pkgs; })
  ];
}
