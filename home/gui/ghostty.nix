{
  host,
  lib,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) Terminal;
in
  lib.mkIf (Terminal == "alacritty") {
    programs.ghostty = {
      enable = true;
    };
  }
