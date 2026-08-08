{ config, lib, pkgs, ... }:

{
  services.dashy = {
    enable = true;

    settings = {
      pageInfo = {
        title = "My HomeLab";
        description = "Homelab Dashboard";
        navLinks = [
          { title = "My NixOS Repo"; path = "https://github.com/pokemans123/nixos-dots"; }
          { title = "My Github"; path = "https://github.com/pokemans123"; }
        ];
      };

      appConfig = {
        theme = "dracula";
      };

      sections = [
        {
          name = "Networking";
          items = [
            {
              title = "Pi-hole";
              description = "Ad-blocker and DNS recorder";
              url = "https://pihole.qazniak-dell";
            }
          ];
        }

        {
          name = "Utilities";
          items = [
            {
              title = "SearXNG";
              description = "Custom search engine";
              url = "https://search.qazniak-dell";
              icon = "hl-searxng";
            }
            {
              title = "Vaultwarden";
              icon = "hl-bitwarden";
              description = "Local hosted password manager";
              url = "https://passwords.qazniak-dell";
            }
          ];
        }
      ];
    };
  };
}
