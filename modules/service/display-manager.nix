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
        vt = 1;
        settings = {
          default_session = {
            user = "greeter";
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c ${WM} -t --user-menu";
          };
        };
      };
    };
  }
