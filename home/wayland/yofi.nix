{
  host,
  lib,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) WM;
in
  lib.mkIf (WM == "Hyprland" || WM == "niri") {
    programs.yofi = {
      enable = true;
    };
  }
