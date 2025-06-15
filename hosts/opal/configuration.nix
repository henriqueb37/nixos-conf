{
  outputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    outputs.nixosModules.default
  ];

  config = {
    myNixOS = {
      home-users = {
        ette = {
          userConfig = ./home.nix;
        };
      };
      niri.enable = lib.mkForce false;
      hyprland.enable = lib.mkForce false;
      kde.enable = lib.mkForce false;
      bluetooth.enable = lib.mkForce false;

      grub.efi.enable = false;
    };

    # hardware.graphics.enable = true;

    networking.hostName = "opal";

    time.timeZone = "America/Bahia";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      # keyMap = "us";
      useXkbConfig = true;
    };

    # Touchpad support
    # services.libinput.enable = true;

    programs.zsh.enable = true;
    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
      wget
      tree
      fd
      ripgrep
      fzf
      git
      wl-clipboard
      fastfetch
      vim
      yazi
      lua
      kitty
      tmux
    ];

    environment.sessionVariables = {
      EDITOR = "nvim";
    };

    system.stateVersion = "24.11";
  };
}
