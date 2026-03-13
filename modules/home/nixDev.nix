{
  flake.modules.homeManager.nixDev =
    { pkgs, config, ... }:
    {
      home.packages = [ pkgs.rassumfrassum ];
      xdg.configFile."rassumfrassum/nixdnil.py".source =
        config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/rassumfrassum/nixdnil.py";
    };
}
