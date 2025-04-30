{ host, lib, ... }:
let
  inherit (import ../../hosts/${host}/env.nix) Office;
in
lib.mkIf (Office == "onlyoffice") {
  programs.onlyoffice = {
    enable = true;
  };
}
