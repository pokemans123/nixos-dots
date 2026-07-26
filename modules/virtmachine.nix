{ config, lib, pkgs, ... }:
{
   programs.dconf.enable = true;
   programs.virt-manager.enable = true;

   users.users.pranav.extraGroups = [ "libvirtd" "kvm" ];

   environment.systemPackages = with pkgs; [
      virt-viewer
      spice
      spice-gtk
      spice-protocol
   ];

   virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
   };
   services.spice-vdagentd.enable = true;
}

