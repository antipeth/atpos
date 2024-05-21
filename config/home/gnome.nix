{lib, ...}:
let inherit (import ../../options.nix) gnome; in
lib.mkIf (gnome== true) {
  services.xserver.desktopManager.gnome.enable = true;
}

