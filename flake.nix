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
				./configuration.nix
				./hosts/qazniak/hardware-configuration.nix
				./hosts/qazniak/qazniak.nix
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
				./configuration.nix
				./hosts/qazniak-dell/hardware-configuration.nix
				./hosts/qazniak-dell/qazniak-dell.nix
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
