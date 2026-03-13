{
  flake.modules.nixos.virt-manager =
    { pkgs, ... }:
    {
      programs.dconf.enable = true;
      programs.virt-manager.enable = true;

      environment.systemPackages = with pkgs; [
        virt-viewer
        virtiofsd
        spice
        spice-gtk
        spice-protocol
        virtio-win
        win-spice
        adwaita-icon-theme
        dnsmaq
      ];

      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            swtpm.enable = true;
            # Deprecated
            # ovmf.enable = true;
            # ovmf.packages = [ pkgs.OVMFFull.fd ];
            vhostUserPackages = with pkgs; [ virtiofsd ];
          };
        };
        spiceUSBRedirection.enable = true;
      };
      # services.spice-vdagentd.enable = true;
    };
}
