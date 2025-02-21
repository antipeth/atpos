{
  # Services to start
  services = {
    libinput.enable = true;
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };

    ipp-usb.enable = true;
  };
}
