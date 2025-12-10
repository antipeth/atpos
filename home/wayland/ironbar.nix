{
  host,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) WM BAR;
in
  lib.mkIf ((WM == "Hyprland" || WM == "niri") && BAR == "ironbar") {
    home = {
      packages = with pkgs; [
        ironbar
      ];
      file.".config/ironbar" = {
        force = true;
        recursive = true;
        source = ../../dotfiles/.config/ironbar;
      };
    };
  }
