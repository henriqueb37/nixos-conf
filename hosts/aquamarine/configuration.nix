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
        henrique = {
          userConfig = ./home.nix;
        };
      };

      gaming.enable = lib.mkForce true;
      virt-manager.enable = lib.mkForce true;
    };

    hardware.uinput.enable = true;
    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';
    boot.supportedFilesystems = [ "ntfs" ];

    users.groups.uinput = { };

    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];

    networking.hostName = "aquamarine";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Bahia";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      # keyMap = "us";
      useXkbConfig = true;
    };

    # Touchpad support
    services.libinput.enable = true;

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
      obsidian
      discord
      goofcord
      yazi
      lua
      kitty
      tmux
      kanata
      dunst
      wofi
      vlc
      playerctl
      yt-dlp
      pavucontrol
      protonup
      heroic
    ];

    environment.sessionVariables = {
      ZDOTDIR = "/home/henrique/.config/zsh/";
      EDITOR = "nvim";
    };

    system.stateVersion = "24.11";
  };
}
