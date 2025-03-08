{ host, ... }:
let
  inherit (import ../../hosts/${host}/env.nix) Bluetooth;
in
{
  services.blueman-applet.enable = Bluetooth;
}
