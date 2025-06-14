{
  pkgs,
  ...
}: {
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  environment = {
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "/home/henrique/.steam/root/compatibilitytools.d/";
    };
    systemPackages = with pkgs; [
      heroic
    ];
  };
}
