{ pkgs, config, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    wget curl git cmatrix lolcat neofetch htop btop 
    polkit_gnome lm_sensors unzip unrar libnotify eza
    v4l-utils ydotool wl-clipboard socat cowsay lsd lshw
    pkg-config meson gnumake ninja symbola
    noto-fonts-color-emoji material-icons brightnessctl yazi
    toybox  swappy ripgrep appimage-run neovim zellij helix
    networkmanagerapplet yad playerctl nh fzf docker docker-compose
    tlp nodejs
    # hugo go nodejs virt-viewer libvirt  
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
      enable = false;
      enableSSHSupport = false;
    };
    virt-manager.enable = false;
  };

  virtualisation.libvirtd.enable = false;
}
