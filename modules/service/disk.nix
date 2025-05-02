{
  services = {
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    smartd = {
      enable = false;
      autodetect = true;
    };
  };
}
