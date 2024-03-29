{ config, pkgs, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    tmp.cleanOnBoot = true;

    loader = {
      grub = {
        enable = true;
        device = "nodev";
        #useOSProber = true;
        theme = pkgs.nixos-grub2-theme;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ext4" "ntfs" ];
  };

  # auto generated ===
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7a6b378e-3d27-4a79-bbc5-9edb607155c2";
      fsType = "btrfs";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/c8b5d1bb-0eb4-4a00-a0cf-e716939224cd";
      fsType = "btrfs";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/CB38-1CA8";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/cf042a35-161f-4ae8-b871-f5e4044dc997"; }
    ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = "x86_64-linux";
}
