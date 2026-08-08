{ config, lib, pkgs, ... }:

{
  services.caddy = {
    enable = true;

    virtualHosts."search.qazniak-dell" = {
      extraConfig = ''
        tls internal
        reverse_proxy 127.0.0.1:8888
      '';
    };

    virtualHosts."pihole.qazniak-dell" = {
      extraConfig = ''
        tls internal
        reverse_proxy 127.0.0.1:8081 {
        }
      '';
    };

    virtualHosts."passwords.qazniak-dell" = {
      extraConfig = ''
        tls internal
        reverse_proxy 127.0.0.1:8222 {
        }
      '';
    };

    virtualHosts."home.qazniak-dell" = {
      extraConfig = ''
        tls internal
        root * ${config.services.dashy.package}
        file_server
      '';
    };
  };
}
