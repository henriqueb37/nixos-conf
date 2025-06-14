{
  pkgs,
  config,
  ...
}: {
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/niri/config.kdl";
}
