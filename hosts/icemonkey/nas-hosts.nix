_: {
  services.unbound.settings.server = {
    local-zone = "'0pt.lab.' redirect";
    local-data = [
      "'0pt.lab. IN A 192.168.6.173'"
    ];
  };
}
