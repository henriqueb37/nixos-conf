{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    myNixOS.gaming.gamemode.enable = lib.mkOption {
      description = "Whether to enable gamemode.";
      default = true;
    };
    myNixOS.gaming.gamescope.enable = lib.mkOption {
      description = "Whether to enable gamescope.";
      default = true;
    };
    myNixOS.gaming.steam.enable = lib.mkOption {
      description = "Whether to enable steam.";
      default = true;
    };
    myNixOS.gaming.heroic.enable = lib.mkOption {
      description = "Whether to enable heroic games launcher.";
      default = true;
    };
    myNixOS.gaming.minecraft.enable = lib.mkOption {
      description = "Whether to enable heroic games launcher.";
      default = false;
    };
  };

  config.programs.gamemode.enable = lib.mkIf config.myNixOS.gaming.gamemode.enable true;
  config.programs.gamescope.enable = lib.mkIf config.myNixOS.gaming.gamescope.enable true;
  config.programs.steam.enable = lib.mkIf config.myNixOS.gaming.steam.enable true;
  config.programs.steam.gamescopeSession.enable = lib.mkIf (config.myNixOS.gaming.steam.enable && config.myNixOS.gaming.gamescope.enable) true;
  config.environment = {
    sessionVariables = lib.mkIf config.myNixOS.gaming.steam.enable {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "/home/henrique/.steam/root/compatibilitytools.d/";
    };
    systemPackages = with pkgs; [] ++
      lib.optional config.myNixOS.gaming.heroic.enable heroic ++
      lib.optional config.myNixOS.gaming.minecraft.enable prismlauncher;
  };
}
