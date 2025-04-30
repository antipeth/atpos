{
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (import ./env.nix) QEMU;
in
with lib;
{
  dconf.settings = mkIf QEMU {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Import Program Configurations
  imports = lib.filesystem.listFilesRecursive ../../home;

  # Home Manager Settings
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    # Place Files Inside Home Directory
    file = {
      "Pictures/Wallpapers" = {
        source = ../../pic/wallpapers;
        recursive = true;
      };
      ".config" = {
        force = true;
        recursive = true;
        source = ../../dotfiles/.config;
      };
      ".config/wlogout/icons" = {
        source = ../../pic/wlogout;
        recursive = true;
      };
      ".config/face.jpg".source = ../../pic/face.jpg;
      ".face.icon".source = ../../pic/face.jpg;
    };

    # Scripts
    packages = [
      (import ../../scripts/task-waybar.nix { inherit pkgs; })
      (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
      (import ../../scripts/wallsetter.nix {
        inherit pkgs;
        inherit username;
      })
    ];
  };
  programs.home-manager.enable = true;
}
