{
  lib,
  config,
  ...
}: {
  options = {
    grub.efi.enable = lib.mkEnableOption {
      description = "Whether to enable efi config for grub.";
    };
  };

  config = {
    boot.loader = {
      efi = lib.mkIf config.grub.efi.enable {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        efiSupport = lib.mkIf config.grub.efi.enable true;
        device = "nodev";
        useOSProber = true;
      };
    };
  };
}
