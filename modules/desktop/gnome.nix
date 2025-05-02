{
  host,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) DM;
in
  lib.mkIf (DM == "Gnome") {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        ## Remove XTerm
        excludePackages = [pkgs.xterm];
      };
      gnome.core-utilities.enable = false;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-backgrounds
      gnome-tour
      gnome-user-docs
    ];
    services.power-profiles-daemon.enable = lib.mkForce false;

    hardware.sensor.iio.enable = true; # Automatic screen rotation

    nixpkgs.overlays = [
      # GNOME 47: triple-buffering-v4-47
      (final: prev: {
        mutter = prev.mutter.overrideAttrs (oldAttrs: {
          # GNOME dynamic triple buffering (huge performance improvement)
          # See https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1441
          # Also https://gitlab.gnome.org/vanvugt/mutter/-/tree/triple-buffering-v4-47
          src = final.fetchFromGitLab {
            domain = "gitlab.gnome.org";
            owner = "vanvugt";
            repo = "mutter";
            rev = "triple-buffering-v4-47";
            hash = "sha256-Jlhzt2Cc44epkBcz3PA6I5aTnVEqMsHBOE8aEmvANWw=";
          };

          # GNOME 47 requires the gvdb subproject which is not included in the triple-buffering branch
          # This copies the necessary gvdb files from the official GNOME repository
          preConfigure = let
            gvdb = final.fetchFromGitLab {
              domain = "gitlab.gnome.org";
              owner = "GNOME";
              repo = "gvdb";
              rev = "2b42fc75f09dbe1cd1057580b5782b08f2dcb400";
              hash = "sha256-CIdEwRbtxWCwgTb5HYHrixXi+G+qeE1APRaUeka3NWk=";
            };
          in ''
            cp -a "${gvdb}" ./subprojects/gvdb
          '';
        });
      })
    ];
  }
