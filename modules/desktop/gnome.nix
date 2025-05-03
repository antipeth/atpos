{
  host,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) DM;
in
  lib.mkIf (DM == "Gnome") {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        ## Remove XTerm
        excludePackages = [pkgs.xterm];
      };
      gnome.core-utilities.enable = false;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-backgrounds
      gnome-tour
      gnome-user-docs
    ];
    services.power-profiles-daemon.enable = lib.mkForce false;

    hardware.sensor.iio.enable = true; # Automatic screen rotation

    i18n.inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [pinyin];
    };
  }
