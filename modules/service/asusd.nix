{lib, ...}:
lib.mkIf false {
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
}
