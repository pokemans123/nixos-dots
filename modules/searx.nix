{ config, lib, pkgs, ... }:

{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    environmentFile = "/home/manager/.searxng.env";
    settings.server = {
      bind_address = "0.0.0.0";
    };
  };
}
