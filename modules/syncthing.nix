{ config, lib, pkgs, ... }:

let
  user = "pranav";
in
{
  services.syncthing = {
    enable = true;
    user = "${user}";
    dataDir = "/home/${user}";
    configDir = "/home/${user}/.config/syncthing";
    guiAddress = "0.0.0.0:8384";
  };

 environment.systemPackages = with pkgs.emacsPackages; [
   syncthing
  ];


  services.tailscale = {
   enable = true;
  };
}
