{ config, lib, pkgs, ... }:

{
  services.dashy = {
    enable = true;

    settings = {
      appConfig = {
        theme = "thebe";
      };

      pageInfo  = {
        description  = "My Homelab";

        navLinks = [
          {
            path = "https://search.qazniak-dell";
            title = "SearXNG";
          }

          {
            path = "https://pihole.qazniak-dell";
            title = "PiHole";
          }

          {
            path = "https://console.tailscale.com";
            title = "Tailscale";
          }
        ];
      };

    };
  };
}
