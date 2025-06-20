# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" "uinput" ];
  boot.kernelParams = [ "amdgpu" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7f469ddf-3bab-4d11-9ac3-5c0c8f4fb8f4";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd:1" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/7f469ddf-3bab-4d11-9ac3-5c0c8f4fb8f4";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd:1" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/7f469ddf-3bab-4d11-9ac3-5c0c8f4fb8f4";
      fsType = "btrfs";
      options = [ "subvol=swap" "compress=zstd:1" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/db5a726b-8c69-4aa8-97cc-8c67ed63cbda";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/484E-0A47";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/mnt/windows" =
    { device = "/dev/disk/by-uuid/74CC5E8CCC5E490E";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
