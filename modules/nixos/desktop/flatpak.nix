{
  flake.modules.nixos.flatpak =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options = {
        myNixos.flatpak.builder.enable = lib.mkOption {
          description = "Whether to enable the flatpak builder";
          default = false;
        };
      };

      config = {
        services.flatpak.enable = true;
        systemd.services.flatpak-repo = {
          wantedBy = [ "multi-user.target" ];
          path = [ pkgs.flatpak ];
          script = ''
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
          '';
        };
        environment.systemPackages =
          [ ] ++ lib.optional config.myNixos.flatpak.builder.enable pkgs.flatpakbuilder;
      };
    };
}
