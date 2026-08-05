{
  description = "Nixos-btw";
  inputs = {

    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astroimagej = {
      url = "github:pokemans123/astroimagej-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    niri-nix = {
      url = "github:niri-wm/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows="nixpkgs-unstable";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:

    {
      nixosConfigurations.qazniak = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";

        specialArgs = {
          inherit inputs nixpkgs-unstable;
        };

        modules = [
          ./configuration.nix
          ./modules/xorg.nix
          ./hosts/qazniak/hardware-configuration.nix
          ./hosts/qazniak/qazniak.nix
	        ./modules/virtmachine.nix
          ./modules/wayland.nix
          ./modules/sdr.nix
          ./modules/syncthing.nix
          ./modules/secrets.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.pranav = import ./home.nix;
              extraSpecialArgs = {
                inherit inputs;
              };

              backupFileExtension = "backup";
            };
          }
        ];
      };

      nixosConfigurations.qazniak-dell = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./configuration.nix
          ./hosts/qazniak-dell/hardware-configuration.nix
          ./hosts/qazniak-dell/qazniak-dell.nix
        ];
      };
    };
}
