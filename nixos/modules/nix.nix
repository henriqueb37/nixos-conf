{
  inputs,
  lib,
  config,
  ...
}: {
  nixpkgs = {
    overlays = [
      (final: _: {
         stable = import inputs.nixpkgs-stable {
         inherit (final.stdenv.hostPlatform) system;
         inherit (final) config;
         };
       })
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
      auto-optimise-store = true;
    };
    channel.enable = false;

    optimise.automatic = true;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

  };
}

