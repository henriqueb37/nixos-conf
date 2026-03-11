{
  flake.modules.nixos.deskutils =
  { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      kanata-with-cmd
      dunst
      wofi
      ags
      playerctl
      brightnessctl
      swww
      pavucontrol
      kitty
      vlc
    ];
  };
}
