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
      vpn.enable = lib.mkForce true;
    };
  };
}
