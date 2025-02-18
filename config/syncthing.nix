{
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        ImmortalWrt = {
          id = "MYLP3AF-ILYVKBE-5RCUISX-KY2CPYY-5VR4W5U-JMTYWWJ-WRN6ZT2-KFD3PAL";
        };
        Nas = {
          id = "6NZ5BBU-VEZ3UBW-I5XGSHU-NJSJSND-ASBOOK4-SQ5GUXK-T3HKDWS-2UTTEQ6";
        };
      };
      folders = {
        "/home/atp/Sync" = {
          id = "default";
          devices = [
            "ImmortalWrt"
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
