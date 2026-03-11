{ self, inputs, ... }:
{
  flake.modules.nixos.users =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      options =
        let
          inherit (lib) mkOption types;
        in
        {
          myNixos.users = mkOption {
            type = types.attrsOf (
              types.submodule {
                options = {
                  homeConfig = mkOption {
                    type = types.path;
                    default = { };
                  };
                  userSettings = mkOption {
                    type = types.attrs;
                    default = { };
                  };
                };
              }
            );
          };
        };
      config = {
        users.users = builtins.mapAttrs (
          name: user:
          (lib.recursiveUpdate {
            initialPassword = "password";
            isNormalUser = true;
            extraGroups = [
              "wheel"
              "networkmanager"
              "video"
              "audio"
              "input"
              "uinput"
              "libvirtd"
            ];
            shell = pkgs.zsh;
          } user.userSettings)
        ) (config.myNixos.users);

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit self inputs;
          };
          backupFileExtension = "backup";
          users = builtins.mapAttrs (
            name: user:
            { ... }:
            {
              imports = [
                (
                  { lib, config, ... }:
                  {
                    options.dotfileDir = lib.mkOption {
                      description = "Directory where all dotfiles are located.";
                      default = "${config.home.homeDirectory}/.dotfiles";
                    };
                  }
                )
                (import user.homeConfig)
                # outputs.homeManagerModules.default
              ];
            }
          ) (config.myNixos.users);
        };
      };
    };
}
