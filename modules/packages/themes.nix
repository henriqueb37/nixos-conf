{
  perSystem =
    { pkgs, ... }:
    {
      packages.win10sur-icon-theme = (pkgs.callPackage ./_win10sur-icon-theme.nix { });
    };
}
