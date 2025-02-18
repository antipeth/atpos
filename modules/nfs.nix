{
  fileSystems.test = {
    device = "server:/homelab";
    fsType = "nfs";
    mountPoint = "/home/atp/nas";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };
}
