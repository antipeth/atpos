{
  boot = {
    kernelParams = [
      "zfs_force=1"
    ];
    zfs = {
      forceImportRoot = false;
      devNodes = "/dev/disk/by-id";
    };
  };
  # Where hostID can be generated with:
  # head -c4 /dev/urandom | od -A none -t x4
  networking.hostId = "2aff655b";
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "weekly";
      pools = [ "tank" ];
    };
    trim = {
      enable = true; # hdd no need
      interval = "weekly";
    };
    autoSnapshot.enable = true;
  };
}
