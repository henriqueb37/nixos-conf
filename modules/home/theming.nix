{
  flake.modules.homeManager.theming =
    { osConfig, lib, ... }:
    {
      stylix.targets = {
        qt.enable = true;
        qt.platform = "qtct";
        emacs.enable = false;
        neovim.enable = false;
      };
      xdg.configFile."stylix/palette.scss".text = lib.concatMapAttrsStringSep "\n" (
        name: value: "\$${name}: ${value};"
      ) osConfig.stylix.base16Scheme;
    };
}
