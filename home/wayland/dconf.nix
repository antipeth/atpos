{
  host,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) DM;
in
  lib.mkIf (DM == "Gnome") {
    home.packages = with pkgs.gnomeExtensions; [
      screen-rotate
    ];
    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false; # enables user extensions
          enabled-extensions = with pkgs.gnomeExtensions; [
            screen-rotate.extensionUuid
          ];
        };
      };
    };
  }
