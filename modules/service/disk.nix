{
  services = {
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    smartd = {
      enable = true;
      autodetect = true;
    };
  };
}
