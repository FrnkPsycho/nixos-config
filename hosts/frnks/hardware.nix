# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "vfio-pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-amd" ];
  # boot.kernelParams = [ "amd_iommu=on" "pcie_aspm=off"];
  boot.extraModulePackages = [];
  boot.loader.timeout = 3;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0672c852-7d2c-4408-9f6f-1d870cb7fedc";
      fsType = "btrfs";
      options = [ "subvol=root" "space_cache=v2" "compress-force=zstd" "noatime" "discard=async"  ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/0672c852-7d2c-4408-9f6f-1d870cb7fedc";
      fsType = "btrfs";
      options = [ "subvol=nix" "space_cache=v2" "compress-force=zstd" "noatime" "discard=async"];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/0672c852-7d2c-4408-9f6f-1d870cb7fedc";
      fsType = "btrfs";
      options = [ "subvol=home" "space_cache=v2" "compress-force=zstd" "noatime" "discard=async" ];
    };

  fileSystems."/sub" = 
    {
      device = "/dev/disk/by-uuid/7b5a7582-f4e2-4489-a896-29dae03886ff";
      fsType = "btrfs";
      options = [ "space_cache=v2" "compress-force=zstd" "noatime" "discard=async" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3012-5FA2";
      fsType = "vfat";
    };

  swapDevices = [ { 
      device = "/swap/swapfile"; 
      size = 16*1024;
  } ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  #systemd.tmpfiles.rules = [
  #    "f /dev/shm/looking-glass 0660 frnks qemu-libvirtd -"
  #];

  hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        open = false;
        nvidiaPersistenced = true;
        modesetting.enable = true;
        powerManagement.enable = true;
        nvidiaSettings = true;
        #forceFullCompositionPipeline = true;
      };

      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = [ pkgs.mesa.drivers ];  
      };

      cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      openrazer.enable = true;
      bluetooth.enable = true;
      pulseaudio.enable = false;
      
  };

  services.autorandr = {
    enable = false;
    profiles = {
      both = {
        config = {
          "DP-4" = {
            enable = true;
            mode = "1920x1080";
            primary = false;
            position = "0x2160";
            scale = {
              x = 2;
              y = 2;
            };
          };
          "HDMI-0" = {
            enable = true;
            mode = "3840x2160";
            primary = true;
            position = "0x0";
          };
        };
        fingerprint = {
          "DP-4" = "00ffffffffffff0006af955800000000241e0104b522137803ee95a3544c99260f505400000001010101010101010101010101010101349e80a07038644010103e0058c1100000180000000f0000000000000000000000000020000000fd003ca5c3c329010a202020202020000000fe004231353648414e31322e48200a0056";
          "HDMI-0" = "00ffffffffffff0025e3ffff0000000007200103803f24782ed6b5ac51469e250e5054a54b00d1c0b30001018180010181c08140a9c0786900a0f0705a803020350078682100001a000000fd00304b28843c000a202020202020000000fc0032384431550020202020202020000000ff00303030303030303030303030300160020329f24a01020304901112131f5f23097f07830100006a030c0010003842200000e305e301e20f016a5e00a0a0a029503020350055502100001a023a801871382d40582c450055502100001e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014";
        };
      };

      laptop-only = {
        config = {
          "DP-4" = {
            enable = true;
            mode = "1920x1080";
            primary = true;
            position = "0x0";
          };
        };
        fingerprint = {
          "DP-4" = "00ffffffffffff0006af955800000000241e0104b522137803ee95a3544c99260f505400000001010101010101010101010101010101349e80a07038644010103e0058c1100000180000000f0000000000000000000000000020000000fd003ca5c3c329010a202020202020000000fe004231353648414e31322e48200a0056";
        };
      };

      external-only = {
        config = {
          "HDMI-0" = {
            enable = true;
            mode = "3840x2160";
            primary = true;
            position = "0x0";
          };
        };
        fingerprint = {
          "HDMI-0" = "00ffffffffffff0025e3ffff0000000007200103803f24782ed6b5ac51469e250e5054a54b00d1c0b30001018180010181c08140a9c0786900a0f0705a803020350078682100001a000000fd00304b28843c000a202020202020000000fc0032384431550020202020202020000000ff00303030303030303030303030300160020329f24a01020304901112131f5f23097f07830100006a030c0010003842200000e305e301e20f016a5e00a0a0a029503020350055502100001a023a801871382d40582c450055502100001e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014";
        };
      };
    }; 
  };
}
