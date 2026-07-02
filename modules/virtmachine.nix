{ config, lib, pkgs, ... }:
{
   programs.dconf.enable = true;

   users.users.pranav.extraGroups = [ "libvirtd" ];

   environment.systemPackages = with pkgs; [
      virt-maanger
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
	    ovmf.enable = true;
	    ovmf.packages = [ pkgs.OVMFFull.fd ];
	 };
      };
      spiceUSBRedirection.enable = true;
   };
   services.spice-vdagentd.enable = true;
}

