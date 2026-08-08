{ config, inputs, lib, pkgs, ... }:

{
  services.flatpak.enable = true;

  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

}
