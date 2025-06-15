{
  lib,
  config,
  ...
}: {
  options = {
    myNixOS.grub.efi.enable = lib.mkOption {
      description = "Whether to enable efi config for grub.";
      default = true;
    };
  };

  config = {
    boot.loader = {
      efi = lib.mkIf config.myNixOS.grub.efi.enable {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        efiSupport = lib.mkIf config.myNixOS.grub.efi.enable true;
        device = "nodev";
        useOSProber = true;
      };
    };
  };
}
