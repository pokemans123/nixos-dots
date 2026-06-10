{
	description = "Nixos-btw";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";	

		};


	};

	outputs = { self, nixpkgs, home-manager, ...}: {
		nixosConfigurations.qazniak = nixpkgs.lib.nixosSystem {
			
			system = "x86_64-linux";
			modules = [ 
				./hosts/qazniak/configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.pranav = import ./home.nix;	
						backupFileExtension = "backup";


					};


				}


			];



		};

		nixosConfigurations.qazniak-dell = nixpkgs.lib.nixosSystem {
			
			system = "x86_64-linux";
			modules = [ 
				./hosts/qazniak-dell/configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.pranav = import ./home.nix;	
						backupFileExtension = "backup";


					};


				}


			];



		};
	};


}
