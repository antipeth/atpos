{ pkgs, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    appimage-run brightnessctl btop cmatrix cowsay curl eza fzf git gnumake helix htop
    libnotify libvirt lm_sensors lolcat lsd lshw material-icons meson neofetch neovim
    networkmanagerapplet nh ninja nodejs noto-fonts-color-emoji pkg-config playerctl
    polkit_gnome ripgrep socat symbola tlp toybox unrar unzip v4l-utils virt-viewer wget
    wl-clipboard yad yazi ydotool zellij
    ];

  programs = {
    # steam.gamescopeSession.enable = true;
    dconf.enable = true;
    seahorse.enable=true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
  };

  virtualisation.libvirtd.enable = true;
}
