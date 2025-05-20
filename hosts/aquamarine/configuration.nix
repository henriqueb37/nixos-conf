{
  inputs,
  outputs,
  lib,
  config,
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
    };

    # users.users.henrique = {
    #   initialPassword = "password";
    #   isNormalUser = true;
    #   extraGroups = ["wheel" "networkmanager" "video" "audio" "input" "uinput"];
    #   shell = pkgs.zsh;
    # };

    hardware.uinput.enable = true;
    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    users.groups.uinput = { };

    services.syncthing.enable = true;

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
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;

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
      neovim
      obsidian
      discord
      goofcord
      yazi
      lua
      kitty
      tmux
      kanata
      hyprpaper
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
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "/home/henrique/.steam/root/compatibilitytools.d/";
      ZDOTDIR = "/home/henrique/.config/zsh/";
      EDITOR = "nvim";
    };

    system.stateVersion = "24.11";
  };
}
