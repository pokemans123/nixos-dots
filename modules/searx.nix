{ config, lib, pkgs, ... }:

{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    environmentFile = "/home/manager/.searxng.env";
    settings.server = {
      bind_address = "0.0.0.0";
    };
    settings.enabled_plugins = [
      "Basic Calculator"
      "Tor check plugin"
      "Tracker URL remover"
      "Open Acces DOI rewrite"
    ];
    settings.engines = lib.mapAttrsToList (name: value: { inherit name; } //value ){
     "duckduckgo".disabled  = false;
     "duckduckgo images".disabled  = false;
     "brave".disabled  = false;
     "github".disabled  = false;
     "youtube".disabled  = false;
     "ddg definitions".disabled = false;
     "material icons".disabled  = false;
     "currency".disabled = false;
     "piped".disabled = false;
     "wallhaven".disabled = false;
    };
  };
}
