{lib, ...}:
lib.mkIf true {
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
}
