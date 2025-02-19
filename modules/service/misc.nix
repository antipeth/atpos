{
  # Services to start
  services = {
    libinput.enable = true;
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };

    ipp-usb.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
