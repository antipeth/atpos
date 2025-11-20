{
  host,
  lib,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) Syncthing;
in
  lib.mkIf Syncthing {
    services.syncthing = {
      enable = true;
    };
  }
