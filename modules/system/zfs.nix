{
  host,
  lib,
  pkgs,
  ...
}: let
  inherit
    (import ../../hosts/${host}/env.nix)
    KernelPackages
    ZFS-Support
    ;
in
  lib.mkIf ZFS-Support {
    boot = {
      kernelParams = [
        "zfs_force=1"
      ];
      zfs = {
        package = lib.mkIf (KernelPackages == "linuxPackages_cachyos") pkgs.zfs_cachyos;
        forceImportRoot = false;
        devNodes = "/dev/disk/by-id";
      };
      supportedFilesystems = ["zfs"];
    };
    # Where hostID can be generated with:
    # head -c4 /dev/urandom | od -A none -t x4
    services.zfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
      };
      trim = {
        enable = true; # hdd no need
        interval = "weekly";
      };
      autoSnapshot.enable = true;
    };
  }
