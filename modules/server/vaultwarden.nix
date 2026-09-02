{ config, lib, pkgs, ... }:

let
  backupDir = "/var/local/vaultwarden/backup";
  syncDir = "/home/manager/passwords";
in
{
  services.vaultwarden = {
    enable = true;
    backupDir = "${backupDir}";

    environmentFile = "/var/lib/vaultwarden/vaultwarden.env";

    config = {
      domain = "https://passwords.qazniak-dell";
      SIGNUPS_ALLOWED = true;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
    };
  };

  systemd.services.vaultwarden-sync = {
    description= "Copy Vaultwarden backups into a syncable folder";
    after = [ "backup-vaultwarden.service" ];
    requires = [ "backup-vaultwarden.service" ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };

    script = ''
      set -euo pipefail

      mkdir -p "${syncDir}"

      cp -a -r "${backupDir}"/. "${syncDir}"/

      chown -R manager:syncthing "${syncDir}"

    '';
  };
}
