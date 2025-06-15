{
  outputs,
  lib,
  ...
}: {
  imports = [
    outputs.homeManagerModules.default
  ];

  config = {
    home.stateVersion = "24.11";
    myHomeManager = {
      hyprland.enable = lib.mkForce false;
      niri.enable = lib.mkForce false;
    };
  };
}
