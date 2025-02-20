{ host, pkgs, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix)
    WM
    ;
in
{
  services = {
    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          user = "greeter";
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c ${WM} -t --user-menu";
        };
      };
    };
  };
}
