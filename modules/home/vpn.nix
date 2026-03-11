{
  flake.modules.homeManager.vpn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        protonvpn-gui
        # protonvpn-cli
        wireguard-tools
      ];
    };
}
