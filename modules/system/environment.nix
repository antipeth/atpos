{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # archive
    p7zip
    gnutar
    unzipNLS
    xz
    zip
    zstd

    # core
    greetd.tuigreet
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

    killall
    eza
    git
    cmatrix
    lolcat
    lxqt.lxqt-policykit
    v4l-utils
    ydotool
    duf
    ncdu
    wl-clipboard
    pciutils
    ffmpeg
    socat
    cowsay
    ripgrep
    lshw
    hyprpicker
    brightnessctl
    virt-viewer
    swappy
    appimage-run
    networkmanagerapplet
    yad
    inxi
    playerctl
    nh
    nixfmt-rfc-style
    swww
    grim
    slurp
    swaynotificationcenter
    imv
    mpv
    gimp
    pavucontrol
    tree
    zoxide
  ];
  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    ssh.startAgent = true;
    virt-manager.enable = true;
  };
}
