{
  disko.devices.disk.main = {
    device = "/dev/vda";
    type = "disk";
    content.type = "gpt";

    content.partitions.bios = {
      name = "BIOS";
      size = "2M";
      type = "EF02";
      priority = 1;
    };

    content.partitions.esp = {
      name = "ESP";
      size = "510M";
      type = "EF00";
      priority = 2;

      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
        mountOptions = [ "fmask=0077,dmask=0077" ];
      };
    };

    content.partitions.persistence = {
      name = "PERSISTENCE";
      size = "100%";
      priority = 3;

      content = {
        type = "btrfs";
        extraArgs = [ "-f" ];

        subvolumes."@nix" = {
          mountpoint = "/nix";
          mountOptions = [ "compress=zstd,noatime" ];
        };

        subvolumes."@rootfs" = {
          mountpoint = "/nix/persistence";
          mountOptions = [ "compress=zstd,noatime" ];
        };

        subvolumes."@home" = {
          mountpoint = "/nix/persistence/home";
          mountOptions = [ "compress=zstd,noatime" ];
        };

        subvolumes."@var" = {
          mountpoint = "/nix/persistence/var";
          mountOptions = [ "compress=zstd,noatime" ];
        };
      };
    };
  };

  disko.devices.nodev."/" = {
    fsType = "tmpfs";
    mountOptions = [ "mode=755,noatime" ];
  };

  # Disko can't configure extra mount options properly. Some critical effects
  # are applied only if these options are set in `fileSystems.<name>`.
  fileSystems."/nix" = {
    neededForBoot = true;
  };

  fileSystems."/nix/persistence" = {
    depends = [ "/nix" ];
    neededForBoot = true;
  };

  fileSystems."/nix/persistence/home" = {
    depends = [ "/nix/persistence" ];
  };

  fileSystems."/nix/persistence/var" = {
    depends = [ "/nix/persistence" ];
    neededForBoot = true;
  };
}
