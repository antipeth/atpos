{
  lib,
  pkgs,
  ...
}:
lib.mkIf false {
  virtualisation.virtualbox.host = {
    enable = true;
    addNetworkInterface = false;
    enableKvm = true;
  };
  users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];
}
