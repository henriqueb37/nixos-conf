{
  pkgs,
  inputs,
  config,
  lib,
  myLib,
  ...
}: {
  options = {
    myNixOS.home-users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          userConfig = lib.mkOption {
            default = ./../hosts/aquamarine/home.nix;
          };
          userSettings = lib.mkOption {
            default = {};
            example = "{}";
          };
        };
      });
      default = {};
    };
  };

  config = {
    users.users = builtins.mapAttrs (
      name: user:
        {
          initialPassword = "password";
          isNormalUser = true;
          extraGroups = ["wheel" "networkmanager" "video" "audio" "input" "uinput"];
          shell = pkgs.zsh;
        }
        // user.userSettings
    ) (config.myNixOS.home-users);

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs myLib;
        outputs = inputs.self.outputs;
      };
      backupFileExtension = "backup";
      users =
        builtins.mapAttrs (name: user: {...}: {
          imports = [
            (import user.userConfig)
            # outputs.homeManagerModules.default
          ];
        })
        (config.myNixOS.home-users);
    };
  };
}
