{ config, lib, pkgs, ... }:

{
  services.pihole-ftl = {
    enable = true;

    openFirewallDNS = true;

    settings = {
      dns = {
        listeningMode = "ALL";
        upstreams = [ "9.9.9.9" "1.1.1.1" ];
      };
    };
    # dns.upstreams = [ "9.9.9.9" "1.1.1.1" ];
    lists = [    # Lists can be added via URL
      {
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "hagezi blocklist";
      }
      {
        url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/refs/heads/main/lists/tracking.txt";
        type = "block";
        enabled = true;
        description = "tracker blocklist";
      }
      {
        url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
        type = "block";
        enabled = true;
        description = "Steven Black";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ "8080" ];
  };
}
