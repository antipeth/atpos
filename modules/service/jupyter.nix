{
  services.jupyter = {
    enable = true;
    command = "jupyter notebook";
    ip = "127.0.0.1";
    port = 8888;
    user = "atp";
    group = "users";
  };
}
