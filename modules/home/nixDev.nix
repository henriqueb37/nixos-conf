{
  flake.modules.homeManager.nixDev =
    { pkgs, config, ... }:
    {
      xdg.configFile."rassumfrassum/nixdnil.py".source =
        config.lib.file.mkOutOfStoreSymlink "${config.dotfileDir}/.config/rassumfrassum/nixdnil.py";
      home.packages = with pkgs; [
        nixd
        # nil
        nixfmt
        nix-inspect

        rassumfrassum
      ];

    };
}
