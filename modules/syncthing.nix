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
  };

 environment.systemPackages = with pkgs.emacsPackages; [
   syncthing
  ];
}
