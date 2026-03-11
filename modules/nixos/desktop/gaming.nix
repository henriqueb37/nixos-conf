{
  flake.modules.nixos.gaming =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options = {
        myNixos.gaming.gamemode.enable = lib.mkOption {
          description = "Whether to enable gamemode.";
          default = true;
        };
        myNixos.gaming.gamescope.enable = lib.mkOption {
          description = "Whether to enable gamescope.";
          default = true;
        };
        myNixos.gaming.steam.enable = lib.mkOption {
          description = "Whether to enable steam.";
          default = true;
        };
        myNixos.gaming.heroic.enable = lib.mkOption {
          description = "Whether to enable heroic games launcher.";
          default = true;
        };
        myNixos.gaming.minecraft.enable = lib.mkOption {
          description = "Whether to enable Minecraft (Prism Launcher).";
          default = false;
        };
        myNixos.gaming.olympus.enable = lib.mkOption {
          description = "Whether to enable the Celeste mod loader installer.";
          default = false;
        };
      };

      config = {
        programs.gamemode.enable = lib.mkIf config.myNixos.gaming.gamemode.enable true;
        programs.gamescope.enable = lib.mkIf config.myNixos.gaming.gamescope.enable true;
        programs.steam.enable = lib.mkIf config.myNixos.gaming.steam.enable true;
        programs.steam.remotePlay.openFirewall = lib.mkIf config.myNixos.gaming.steam.enable true;
        programs.steam.gamescopeSession.enable = lib.mkIf (
          config.myNixos.gaming.steam.enable && config.myNixos.gaming.gamescope.enable
        ) true;
        environment = {
          sessionVariables = lib.mkIf config.myNixos.gaming.steam.enable {
            STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/henrique/.steam/root/compatibilitytools.d/";
          };
          systemPackages =
            with pkgs;
            [ ]
            ++ lib.optional config.myNixos.gaming.heroic.enable heroic
            ++ lib.optionals config.myNixos.gaming.minecraft.enable [
              jdk25
              prismlauncher
            ]
            ++ lib.optional config.myNixos.gaming.olympus.enable olympus;
        };
      };
    };
}
