{
  lib,
  pkgs,
  ...
}:
lib.mkIf true {
  programs.kodi = {
    enable = true;
    package = pkgs.kodi-gbm.withPackages (exts:
      with exts; [
        # Gamepad driver
        joystick
        jellycon
      ]);
  };
}
