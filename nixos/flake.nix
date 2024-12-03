{
  description = "Flakiest OS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
	};
      };
    };
    _1password-shell-plugins = {
      url = "github:1Password/shell-plugins";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: let inherit (self) outputs; in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
	modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "keloran@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
	extraSpecialArgs = {inherit inputs outputs;};	      
	modules = [	        
	  ./home-manager/home.nix
	];
      };
    };
  };
}

