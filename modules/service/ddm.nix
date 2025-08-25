{
  host,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) WM;
in
  lib.mkIf (WM == "niri" || WM == "Hyprland") {
    services = {
      greetd = {
        enable = true;
        settings = {
          default_session = {
            user = "greeter";
            command = "${pkgs.tuigreet}/bin/tuigreet -c ${WM} -t --user-menu";
          };
        };
      };
    };
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  }
