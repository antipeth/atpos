{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.drivers.gamepad;
in
{
  options.drivers.gamepad = {
    enable = mkEnableOption "Enable Bluetooth Support";
  };

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = [
      "usbhid"
      "joydev"
      "xpad"
    ];
    hardware = {
      xpadneo.enable = true;
      xone.enable = true;
    };
    services.joycond.enable = true;
    environment.systemPackages = with pkgs; [

    ];
  };
}
