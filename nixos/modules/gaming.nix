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
  };

  config.programs.gamemode.enable = lib.mkIf config.myNixOS.gaming.gamemode.enable true;
  config.programs.gamescope.enable = lib.mkIf config.myNixOS.gaming.gamescope.enable true;
  config.programs.steam.enable = lib.mkIf config.myNixOS.gaming.steam.enable true;
  config.programs.steam.gamescopeSession.enable = lib.mkIf (config.myNixOS.gaming.steam.enable && config.myNixOS.gaming.gamescope.enable) true;
  environment = {
    sessionVariables = lib.mkIf config.myNixOS.gaming.steam.enable {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "/home/henrique/.steam/root/compatibilitytools.d/";
    };
    systemPackages = lib.mkIf config.myNixOS.gaming.heroic.enable (with pkgs; [
        heroic
    ]);
  };
}
