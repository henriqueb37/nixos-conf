{
  inputs,
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
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
      ];
      extraConfig = ''
        source = ~/.config/hypr/hyprconf.conf
      '';
    };

    # I don't wanna have to rebuild every time i change something
    xdg.configFile."hypr/hyprconf.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/hypr/hyprland.conf";

    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
