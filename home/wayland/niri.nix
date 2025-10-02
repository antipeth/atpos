{
  host,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) WM;
in
  with lib;
    mkIf (WM == "niri") {
      systemd.user.targets.niri-session = {
        Unit = {
          Description = "niri compositor session";
          Documentation = "man:systemd.special(7)";
        };
        Target = {
          After = "graphical-session-pre.target";
          BindsTo = "graphical-session.target";
          Wants = "graphical-session-pre.target";
          DefaultDependencies = false;
        };
      };
      systemd.user.services.xdg-desktop-portal-gnome = {
        Unit = {
          Description = "Portal service (GNOME implementation)";
        };
        Service = {
          Type = "dbus";
          BusName = "org.freedesktop.impl.portal.desktop.gnome";
          ExecStart = "${pkgs.xdg-desktop-portal-gnome}/libexec/xdg-desktop-portal-gnome";
        };
      };
      home.packages = with pkgs; [
        niri
        xwayland-satellite
      ];
      xdg.portal = {
        config = {
          common = {
            default = [
              "gnome"
              "gtk"
            ];
          };
        };
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
      };
    }
