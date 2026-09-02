{ config, lib, pkgs, ... }:

{
  services.vaultwarden = {
    enable = true;
    backupDir = "/home/manager/passwords";

    environmentFile = "/var/lib/vaultwarden/vaultwarden.env";

    config = {
      domain = "https://passwords.qazniak-dell";
      SIGNUPS_ALLOWED = true;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
    };
  };
}
