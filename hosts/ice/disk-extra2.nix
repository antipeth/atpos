_: {
  fileSystems = {
    "/run/media/atp/hdd3" = {
      device = "/dev/disk/by-id/ata-HGST_HSH721414ALE6M4_VFGEDBUD";
      fsType = "f2fs";
      options = [
        # Continute when it failed
        "nofail"
        # Enable compress
        "compress_algorithm=zstd:6"
        "compress_chksum"
        # Enable better garbage collector
        "gc_merge"
        # Do not synchronously update access or modification times
        "lazytime"
      ];
    };
    "/run/media/atp/Ventoy" = {
      device = "/dev/disk/by-id/ata-Predator_SSD_GM7000_2TB_PSBG53171002234-part1";
      fsType = "ntfs";
      options = [
        # Continute when it failed
        "nofail"
      ];
    };
  };
  systemd.tmpfiles.rules = [
    "d /run/media/atp/hdd3 0755 atp users - -"
    "d /run/media/atp/Ventoy 0755 atp users - -"
  ];
}
