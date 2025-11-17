{ config, lib, pkgs, modulesPath, constants,
... }:
{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "hv_vmbus" "hv_storvsc" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ ];
  boot.kernelParams = [ "video=hyperv_fb:800x600" ];
  boot.kernel.sysctl."vm.overcommit_memory" = "1";
  boot.extraModulePackages = [ ];

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/efi";
  };

  boot.loader.systemd-boot.enable = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0d17beb5-efd7-40f3-9012-911a037f15a2";
      fsType = "btrfs";
      options = [ "subvol=@rootfs,compress=zstd,noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/0d17beb5-efd7-40f3-9012-911a037f15a2";
      fsType = "btrfs";
      options = [ "subvol=@home,compress=zstd,noatime" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/0d17beb5-efd7-40f3-9012-911a037f15a2";
      fsType = "btrfs";
      options = [ "subvol=@var,compress=zstd,noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/0d17beb5-efd7-40f3-9012-911a037f15a2";
      fsType = "btrfs";
      options = [ "subvol=@nix,compress=zstd,noatime" ];
    };

  fileSystems."/efi" =
    { device = "/dev/disk/by-uuid/C7AE-B704";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault constants.system;
  virtualisation.hypervGuest.enable = true;
}
