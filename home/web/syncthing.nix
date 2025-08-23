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
      settings = {
        devices = {
          homelab = {
            id = "5H7XA3F-R5WFPON-DV57OGC-M6RA3FF-UHZBT3M-TYD4MNH-YR3KZGW-TDE5RQZ";
          };
        };
        folders = {
          "/home/atp/Sync" = {
            id = "default";
            devices = [
              "homelab"
            ];
            versioning.type = "trashcan";
          };
        };
        options = {
          globalAnnounceEnabled = false;
          localAnnounceEnabled = true;
          relaysEnabled = false;
        };
      };
    };
  }
