{ self, ...}:
{
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      config.stylix = {
        enable = true;
        polarity = "dark";
        base16Scheme = {
          scheme = "moonfly";
          base00 = "#080808";
          base01 = "#1c1c1c";
          base02 = "#323437";
          base03 = "#585858";
          base04 = "#808080";
          base05 = "#c6c6c6";
          base06 = "#e4e4e4";
          base07 = "#eeeeee";
          base08 = "#ff5d5d";
          base09 = "#e65e72";
          base0A = "#36c692";
          base0B = "#c6c684";
          base0C = "#79dac8";
          base0D = "#74b2ff";
          base0E = "#cf87e8";
          base0F = "#b2b2b2";
        };
        fonts = {
          sizes.applications = 11;
        };
        icons = {
          enable = true;
          package = self.packages.${pkgs.system}.win10sur-icon-theme.override { themeVariants = [ "purple" ]; };
          dark = "Win10Sur-purple-dark";
        };
      };
    };
}
