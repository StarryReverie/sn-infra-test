{
  # FIXME: After the next time deploying the system from scratch, remove
  # hard-coded `/dev/disk/by-uuid/<uuid>` to leverage disk labels.
  disko.devices.disk.main = {
    device = "/dev/disk/by-id/nvme-WD_BLACK_SN770_1TB_24104E805306";
    type = "disk";
    content.type = "gpt";

    content.partitions.esp = {
      name = "ESP";
      size = "512M";
      type = "EF00";

      content = {
        type = "filesystem";
        format = "vfat";
        device = "/dev/disk/by-uuid/6E4C-A5ED";
        mountpoint = "/efi";
        mountOptions = [
          "fmask=0077"
          "dmask=0077"
        ];
      };
    };

    content.partitions.persistence = {
      name = "PERSISTENCE";
      size = "100%";

      content = {
        type = "btrfs";
        device = "/dev/disk/by-uuid/256963eb-3128-441d-aa10-00be2b96b61f";
        extraArgs = [ "-f" ];

        subvolumes."@nix" = {
          mountpoint = "/nix";
          mountOptions = [
            "compress=zstd"
            "noatime"
            "x-initrd.mount"
          ];
        };

        subvolumes."@rootfs" = {
          mountpoint = "/nix/persistence";
          mountOptions = [
            "compress=zstd"
            "noatime"
            "x-initrd.mount"
            "x-systemd.requires-mounts-for=/sysroot/nix"
          ];
        };

        subvolumes."@home" = {
          mountpoint = "/nix/persistence/home";
          mountOptions = [
            "compress=zstd"
            "noatime"
            "x-systemd.requires-mounts-for=/nix/persistence"
          ];
        };

        subvolumes."@var" = {
          mountpoint = "/nix/persistence/var";
          mountOptions = [
            "compress=zstd"
            "noatime"
            "x-initrd.mount"
            "x-systemd.requires-mounts-for=/sysroot/nix/persistence"
          ];
        };
      };
    };
  };

  disko.devices.nodev."/" = {
    fsType = "tmpfs";
    mountOptions = [
      "mode=755"
      "noatime"
    ];
  };
}
