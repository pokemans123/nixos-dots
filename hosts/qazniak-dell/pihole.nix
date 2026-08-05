{ config, lib, pkgs, ... }:

{

  services.pihole-ftl = {
    enable = false;
    dns.upstream = [ "9.9.9.9" "1.1.1.1" ];
    lists = [
      {
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "hagezi blocklist";
      }
    ];
  };

  services.pihole-web = {
    enable = false;
    ports = [ "443s" ];
  };

}
