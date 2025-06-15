{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    gaming.gamemode.enable = lib.mkEnableOption {
      gaming.description.enable = "Whether to enable gamemode.";
      gaming.default.enable = true;
    };
    gaming.gamescope.enable = lib.mkEnableOption {
      gaming.description.enable = "Whether to enable gamescope.";
      gaming.default.enable = true;
    };
    gaming.steam.enable = lib.mkEnableOption {
      gaming.description.enable = "Whether to enable steam.";
      gaming.default.enable = true;
    };
    gaming.heroic.enable = lib.mkEnableOption {
      gaming.description.enable = "Whether to enable heroic games launcher.";
      gaming.default.enable = true;
    };
  };

  config.programs.gamemode.enable = lib.mkIf config.gaming.gamemode.enable true;
  config.programs.gamescope.enable = lib.mkIf config.gaming.gamescope.enable true;
  config.programs.steam.enable = lib.mkIf config.gaming.steam.enable true;
  config.programs.steam.gamescopeSession.enable = lib.mkIf config.gaming.steam.enable && config.gaming.gamescope.enable true;
  environment = {
    sessionVariables = lib.mkIf config.gaming.steam.enable {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "/home/henrique/.steam/root/compatibilitytools.d/";
    };
    systemPackages = lib.mkIf config.gaming.heroic.enable (with pkgs; [
        heroic
    ]);
  };
}
