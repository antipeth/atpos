_: {
  virtualisation.virtualbox.host = {
    enable = false;
    addNetworkInterface = false;
    enableKvm = true;
  };
  users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];
}
