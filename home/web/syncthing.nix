{
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        Nas = {
          id = "6NZ5BBU-VEZ3UBW-I5XGSHU-NJSJSND-ASBOOK4-SQ5GUXK-T3HKDWS-2UTTEQ6";
        };
      };
      folders = {
        "/home/atp/Sync" = {
          id = "default";
          devices = [
            "Nas"
          ];
          versioning.type = "trashcan";
        };
      };
      options = {
        globalAnnounceEnabled = false;
        localAnnounceEnabled = true;
        relaysEnabled = false;
      };
    };
  };
}
