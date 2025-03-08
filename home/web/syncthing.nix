{
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        Nas = {
          id = "6NZ5BBU-VEZ3UBW-I5XGSHU-NJSJSND-ASBOOK4-SQ5GUXK-T3HKDWS-2UTTEQ6";
        };
        PostmarketOS = {
          id = "OP5TTKB-AI2JABB-6YBI2Q4-XHHFAQQ-QHO23VV-5QZBMXW-5MAM42F-BX74AQZ";
        };
      };
      folders = {
        "/home/atp/Sync" = {
          id = "default";
          devices = [
            "Nas"
            "PostmarketOS"
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
