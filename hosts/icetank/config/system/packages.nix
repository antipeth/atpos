{ pkgs, config, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    wget curl git neofetch lm_sensors unzip unrar ydotool pkg-config  gnumake symbola
    brightnessctl yazi toybox ripgrep  neovim zellij helix networkmanagerapplet nh nodejs
    
    # hugo go nodejs virt-viewer libvirt htop btop wl-clipboard noto-fonts-color-emoji material-icons
    # tlp polkit_gnome libnotify cmatrix lolcat v4l-utils socat cowsay lsd eza meson ninja swappy
    # appimage-run yad  playerctl
  ];

  programs = {
    # steam.gamescopeSession.enable = true;
    # dconf.enable = true;
    # seahorse.enable=true;
    # hyprland = {
    #   enable = true;
    #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    #   xwayland.enable = true;
    # };
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = false;
      enableSSHSupport = false;
    };
    # virt-manager.enable = false;
  };

  virtualisation.libvirtd.enable = false;
}
