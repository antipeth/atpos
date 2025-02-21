{ pkgs, ... }:
{
  xdg = {
    enable = true;
    portal = {
      enable = true;
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
