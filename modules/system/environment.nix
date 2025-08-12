{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # archive
    p7zip
    gnutar
    unzipNLS
    xz
    zip
    zstd

    # core
    tuigreet
    just
    v4l-utils # For OBS virtual cam support

    # editor use in tty
    micro

    # networking tool
    curl
    wget

    # misc
    expect
    file
    gcc
    ghc
    gnumake
    jq
    libvirt
    lm_sensors
    libnotify
    meson
    ninja
    pkg-config
    zenith
  ];
  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    sniffnet.enable = true;
    ssh.startAgent = true;
  };
}
