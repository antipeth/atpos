{
  virtualisation.containers.enable = false;
  virtualisation = {
    docker = {
      enable = false;
      storageDriver = "zfs";
    };
  };
}
