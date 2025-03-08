{ pkgs, ... }:
{
  boot = {
    kernelParams = [
      "zfs_force=1"
    ];
    zfs = {
      package = pkgs.zfs_cachyos;
      forceImportRoot = false;
      devNodes = "/dev/disk/by-id";
    };
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
