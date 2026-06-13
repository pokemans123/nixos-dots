{
	description = "Nixos-btw";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";	

		};

		zen-browser = {
		  url = "github:youwen5/zen-browser-flake";
		  inputs.nixpkgs.follows = "nixpkgs";
		};

		noctalia = {
		  url = "github:noctalia-dev/noctalia";
		  inputs.nixpkgs.follows = "nixpkgs";
		};

	};
	outputs = inputs@{ self, nixpkgs, home-manager, ...}: {
		nixosConfigurations.qazniak = nixpkgs.lib.nixosSystem {
			
			system = "x86_64-linux";

			specialArgs = {
			   inherit inputs;
			};

			modules = [ 
				./configuration.nix
				./hosts/qazniak/hardware-configuration.nix
				./hosts/qazniak/qazniak.nix
				home-manager.nixosModules.home-manager {
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
				home-manager.nixosModules.home-manager {
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
	};
}
