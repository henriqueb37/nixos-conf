{ self, inputs, ... }:
{
  flake.nixosConfigurations.opal = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit self inputs; };
    modules = [
      inputs.home-manager.nixosModules.home-manager
      self.modules.nixos.hostOpal
    ];
  };

  flake.modules.nixos.hostOpal =
    { pkgs, ... }:
    {
      imports = (
        with self.modules.nixos;
        [
          audio
          cli
          fonts
          grub
          nix
          power
          users
        ]
      );
      config = {
        myNixos = {
          users = {
            ette = {
              homeConfig = ./_home;
            };
          };
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
          wl-clipboard
          lua
          kitty
        ];

        environment.sessionVariables = {
          EDITOR = "nvim";
        };
      };
    };
}
