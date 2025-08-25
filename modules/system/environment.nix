{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Archive
    p7zip
    gnutar
    unzipNLS
    xz
    zip
    zstd

    # networking tool
    curl
    wget

    # misc
    libvirt
    lm_sensors
    libnotify
    v4l-utils # For OBS virtual cam support
  ];
  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    git = {
      enable = true;
      package = pkgs.gitMinimal;
    };
    mtr.enable = true;
    sniffnet.enable = true;
    ssh.startAgent = true;
  };
}
