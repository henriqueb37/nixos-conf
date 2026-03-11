{ inputs, self, ... }:
{
  flake.nixosConfigurations.aquamarine = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit self inputs; };
    modules = [
      inputs.stylix.nixosModules.stylix
      inputs.home-manager.nixosModules.home-manager
      self.modules.nixos.hostAquamarine
    ];
  };

  flake.modules.nixos.hostAquamarine =
    { lib, pkgs, ... }:
    {
      imports = (
        with self.modules.nixos;
        [
          audio
          bluetooth
          cli
          deskutils
          flatpak
          fonts
          gaming
          grub
          kde
          niri
          power
          stylix
          users
        ]
      );

      config = {
        myNixos = {
          users = {
            henrique = {
              homeConfig = ./_home;
            };
          };

          gaming = {
            minecraft.enable = lib.mkForce true;
            olympus.enable = lib.mkForce true;
          };
        };

        # nixpkgs.overlays = [
        #   (import (fetchTarball {
        #     # Pinned Emacs version
        #     url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        #     sha256 = "sha256:1i68icdikbf42xw2ikb8ic1cndbnc65n1qrmbl0mnqzcqmqxgrg0";
        #   }))
        # ];

        nix.settings.substituters = [
          "https://nix-community.cachix.org"
        ];

        nix.settings.trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        hardware.opentabletdriver.enable = true;

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
        networking.networkmanager.plugins = with pkgs; [ networkmanager-openvpn ];
        networking.firewall.checkReversePath = false;

        # services.dnsmasq.enable = true;
        # networking.firewall.allowedUDPPorts = [ 67 68 ];

        time.timeZone = "America/Bahia";

        i18n.defaultLocale = "pt_BR.UTF-8";
        console = {
          font = "Lat2-Terminus16";
          # keyMap = "us";
          useXkbConfig = true;
        };

        # Touchpad support
        services.libinput.enable = true;

        programs.zsh.enable = true;
        programs.firefox.enable = true;

        # services.mysql = {
        #   enable = true;
        #   package = pkgs.mysql80;
        # };

        environment.systemPackages = with pkgs; [
          obsidian
          lua
          easyeffects
          jupyter-all
          logisim-evolution
          krita
          rnote
          blockbench
          thunderbird
          aseprite
          libreoffice-qt-fresh
          rars
        ];

        environment.sessionVariables = {
          ZDOTDIR = "/home/henrique/.config/zsh/";
          VISUAL = "nvim";
          EDITOR = "nvim";
        };

        system.stateVersion = "24.11";
      };
    };
}
