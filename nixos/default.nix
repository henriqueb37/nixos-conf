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
      hyprland.enable = lib.mkDefault false;
      kde.enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
      users.enable = lib.mkDefault true;
      gaming.enable = lib.mkDefault false;
      niri.enable = lib.mkDefault true;
      fonts.enable = lib.mkDefault true;
      modelsim-deps.enable = lib.mkDefault false;
      flatpak.enable = lib.mkDefault true;
    };
  };
}
