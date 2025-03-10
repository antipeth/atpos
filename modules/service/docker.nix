{
  virtualisation.containers.enable = true;
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "zfs";
    };
  };
}
