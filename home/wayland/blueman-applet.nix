{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) Bluetooth;
in
{
  services.blueman-applet.enable = Bluetooth;
}
