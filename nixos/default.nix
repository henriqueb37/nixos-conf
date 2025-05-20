{
  lib,
  myLib,
  ...
}: {
  imports = [] ++ myLib.mkModulesOptional {
    dir = ./modules;
    origin = "myNixOS";
  };
  
  config = {
    myNixOS = {
      audio.enable = lib.mkDefault true;
      bluetooth.enable = lib.mkDefault true;
      grub.enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault true;
      kde.enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
      users.enable = lib.mkDefault true;
    };
  };
}
