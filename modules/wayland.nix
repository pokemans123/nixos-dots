{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.mangowm.nixosModules.mango
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # programs.niri = {
  #   enable = true;
  #   package = inputs.niri-nix.packages.${pkgs.stdenv.hostPlatform.system}.niri;
  # };

  programs.mango.enable = true;




  environment.systemPackages= with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
    hyprcursor
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    rose-pine-hyprcursor
    (import ../config/scripts/screenshot.nix { inherit pkgs; })
  ];
}
