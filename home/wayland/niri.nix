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
  home.packages = with pkgs; [
    niri
  ];
  programs.hyprlock = {
    enable = true;
  };
}
