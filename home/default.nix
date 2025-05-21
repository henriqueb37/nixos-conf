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
    };
  };
}
