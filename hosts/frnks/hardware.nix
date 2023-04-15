# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [];
  boot.loader.timeout = 3;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/64765921-abaf-4401-be91-6b9db3a2217c";
      fsType = "btrfs";
      options = [ "subvol=root" "space_cache=v2" "compress-force=zstd" "noatime" "discard=async"  ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/64765921-abaf-4401-be91-6b9db3a2217c";
      fsType = "btrfs";
      options = [ "subvol=nix" "space_cache=v2" "compress-force=zstd" "noatime" "discard=async"];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/64765921-abaf-4401-be91-6b9db3a2217c";
      fsType = "btrfs";
      options = [ "subvol=home" "space_cache=v2" "compress-force=zstd" "noatime" "discard=async" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3012-5FA2";
      fsType = "vfat";
    };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # hardware.video.hidpi.enable = true;
  hardware.openrazer.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
}
