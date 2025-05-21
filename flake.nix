{
  description = "Nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  } @inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    myLib = import ./myLib { inherit lib; };
  in {
    nixosConfigurations = {
      # laptop config
      aquamarine = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs myLib; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/aquamarine/configuration.nix
        ];
      };
    };

    nixosModules.default = ./nixos;
    homeManagerModules.default = ./home;
  };
}
