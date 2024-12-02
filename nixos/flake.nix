{
  description = "Flakiest OS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
	      };
      };
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-cosmic, ... } @ inputs: let inherit (self) outputs; in {
    nixosConfigurations = {
      lenovo = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
	      modules = [
          {
            nix.settings = {
              substituters = [
                "https://cosmic.cachix.org/"
              ];
              trusted-public-keys = [
                "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
              ];
            };
          }
          nixos-cosmic.nixosModules.default
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

