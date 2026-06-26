{
  description = "AstroImageJ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
 let
   supportedSystems = [ "x86_64-linux" ];
   forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
 in
 {
   packages = forAllSystems (system:
     let
       pkgs = nixpkgs.legacyPackages.${system};
     in {
       astroimagej = pkgs.callPackage ./astroimagej.nix {};
       default = self.packages.${system}.astroimagej;
     }
     );

 };


}
