{
  description = "Flake initator";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };
  };

  outputs = {nixpkgs, ...}: let forAllSystems = nixpkgs.lib.getAttrs [
    "x86_64-linux"
  ]; in {
    templates = {
      default = {
        description = "Standard build for lenovo";
        path = ./nixos;
      };
    };
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixos);
  };
}

