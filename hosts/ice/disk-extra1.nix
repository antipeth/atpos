_: {
  disko.devices = {
    disk = {
      hdd1 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-TOSHIBA_HDWD110_20DA4RTFS";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };
      hdd2 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-TOSHIBA_HDWD110_7943SJWFS";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };
    };
    zpool = {
      tank = {
        type = "zpool";
        mode = "mirror";
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
          share = {
            type = "zfs_fs";
            mountpoint = "/share";
            # Used by services.zfs.autoSnapshot options.
            options = {
              "com.sun:auto-snapshot" = "true";
              mountpoint = "legacy";
            };
          };
          media = {
            type = "zfs_fs";
            mountpoint = "/media";
            options = {
              "com.sun:auto-snapshot" = "true";
              mountpoint = "legacy";
            };
          };
          backup = {
            type = "zfs_fs";
            mountpoint = "/backup";
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
