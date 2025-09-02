_: {
  fileSystems."/run/media/atp/hdd3" = {
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
  systemd.tmpfiles.rules = [
    "d /run/media/atp/hdd3 0755 atp users - -"
  ];
}
