{
  flake.modules.nixos.virt-manager =
    { pkgs, ... }:
    {
      programs.dconf.enable = true;

      environment.systemPackages = with pkgs; [
        virt-manager
        virt-viewer
        virtiofsd
        spice
        spice-gtk
        spice-protocol
        virtio-win
        win-spice
        adwaita-icon-theme
      ];

      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            swtpm.enable = true;
            # Deprecated
            # ovmf.enable = true;
            # ovmf.packages = [ pkgs.OVMFFull.fd ];
          };
        };
        spiceUSBRedirection.enable = true;
      };
      services.spice-vdagentd.enable = true;
    };
}
