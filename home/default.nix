{
  lib,
  myLib,
  config,
  ...
}: {
  imports = [] ++ (myLib.mkModulesOptional {
    dir = ./modules;
    origin = "myHomeManager";
  });

  options = {
    dotfileDir = lib.mkOption {
      type = lib.types.string;
      default = "${config.home.homeDirectory}/.dotfiles";
    };
  };

  config = {
    myHomeManager = {
      hyprland.enable = lib.mkDefault true;
      neovim.enable = lib.mkDefault true;
      kitty.enable = lib.mkDefault true;
      vpn.enable = lib.mkDefault false;
      niri.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
      syncthing.enable = lib.mkDefault false;
    };
  };
}
