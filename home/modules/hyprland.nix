{
  pkgs,
  config,
  ...
}: {
  config = {
    home.packages = with pkgs; [ hyprpaper grim slurp ];
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      plugins = [
        pkgs.hyprlandPlugins.hyprscrolling
      ];
      extraConfig = ''
        source = ~/.config/hypr/hyprconf.conf
      '';
    };

    # I don't wanna have to rebuild every time i change something
    home.file.".config/hypr/hyprconf.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/henrique/.dotfiles/.config/hypr/hyprland.conf";

    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
