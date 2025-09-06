{
  lib,
  pkgs,
  ...
}:
lib.mkIf false {
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    configPackages = [pkgs.hyprland];
  };
}
