{ pkgs, config, lib, ... }:

{
  virtualisation.docker.enable = true;
  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;
  sound.enable = true;
  security.rtkit.enable = false;
  programs.thunar.enable = false;
  services.gvfs.enable = false;
  services.tumbler.enable = false;
  services.gnome.gnome-keyring.enable=false;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  services.tlp.enable = true;
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
