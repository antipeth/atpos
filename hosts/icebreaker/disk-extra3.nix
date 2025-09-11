_: {
  systemd.tmpfiles.rules = [
    "d /run/media/atp/ssd1 0755 atp users - -"
  ];
  disko.devices = {
    disk = {
      ssd1 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-INTEL_MEMPEK1J016GAD_PHBT83810CZZ016N";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "ssd1";
              };
            };
          };
        };
      };
    };
    zpool = {
      ssd1 = {
        type = "zpool";
        rootFsOptions = {
          # https://wiki.archlinux.org/title/Install_Arch_Linux_on_ZFS
          acltype = "posixacl";
          atime = "off";
          compression = "lz4";
          mountpoint = "none";
          xattr = "sa";
        };
        options.ashift = "12";

        datasets = {
          ssd1 = {
            type = "zfs_fs";
            mountpoint = "/run/media/atp/ssd1";
            # Used by services.zfs.autoSnapshot options.
            options = {
              "com.sun:auto-snapshot" = "true";
              mountpoint = "legacy";
            };
          };
        };
      };
    };
  };
}
