{
  lib,
  myLib,
  ...
}: {
  imports = [] ++ (myLib.mkModulesOptional {
    dir = ./modules;
    origin = "myHomeManager";
  });

  config = {
    myHomeManager = {
      hyprland.enable = lib.mkDefault true;
      neovim.enable = lib.mkDefault true;
      kitty.enable = lib.mkDefault true;
      vpn.enable = lib.mkDefault false;
    };
  };
}
