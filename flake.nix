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
        decription = "Standard build for lenovo";
        path = "./lenovo";
      };
    };
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixos);
  };
}

