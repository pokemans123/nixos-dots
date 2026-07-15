{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      soapysdr-with-plugins  = prev.soapysdr.override {
        extraPackages = [ prev.soapysdrplay ];
      };
    })
  ];

  services.sdrplayApi = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    soapysdr-with-plugins
    (pkgs.writeShellScriptBin "sdrangel" ''
      exec ${pkgs.sdrangel}/bin/sdrangel --soapy "$@"
    '')
  ];

}
