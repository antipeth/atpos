{
  host,
  lib,
  pkgs,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix) WM;
in
with lib;
mkIf (WM == "niri") {
  services.gnome-keyring.enable = true;
  xdg.portal = {
    configPackages = [
      #   pkgs.xdg-desktop-portal
      #   pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    extraPortals = [
      # pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
  home = {
    packages = with pkgs; [
      niri
    ];
  };
}
