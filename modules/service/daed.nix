{
  host,
  lib,
  ...
}:
with lib; let
  inherit (import ../../hosts/${host}/env.nix) Transparent-Proxy;
in
  mkIf Transparent-Proxy {
    services.daed = {
      enable = true;
    };
  }
