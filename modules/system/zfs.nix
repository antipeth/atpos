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
  with lib;
    mkIf ZFS-Support {
      boot = {
        kernelParams = [
          "zfs_force=1"
        ];
        zfs = {
          package = pkgs.zfs_unstable;
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
      systemd.services = {
        zfs-share.enable = mkForce false;
        zfs-zed.enable = mkForce false;
      };
    }
