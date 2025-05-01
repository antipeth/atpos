{
  lib,
  nixvim,
  pkgs,
  username,
  ...
}: let
  inherit (import ./env.nix) QEMU;
in
  with lib; {
    dconf.settings = mkIf QEMU {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };

    # Import Program Configurations
    imports =
      [
        nixvim.homeManagerModules.nixvim
        ../../nixvim
      ]
      ++ lib.filesystem.listFilesRecursive ../../home;

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
        ".config/swappy/config".text = ''
          [Default]
          save_dir=/home/${username}/Pictures/Screenshots
          save_filename_format=swappy-%Y%m%d-%H%M%S.png
          show_panel=false
          line_size=5
          text_size=20
          text_font=Ubuntu
          paint_mode=brush
          early_exit=true
          fill_shape=false
        '';
        ".face.icon".source = ../../pic/face.jpg;
      };

      # Scripts
      packages = [
        (import ../../scripts/task-waybar.nix {inherit pkgs;})
        (import ../../scripts/nvidia-offload.nix {inherit pkgs;})
        (import ../../scripts/wallsetter.nix {
          inherit pkgs;
          inherit username;
        })
      ];
    };
    programs.home-manager.enable = true;
  }
