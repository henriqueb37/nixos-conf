{
  flake.modules.homeManager.intellij =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.jetbrains.idea ];
    };
}
