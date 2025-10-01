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
        ../../home/tui/btop.nix
        ../../home/gui/alacritty.nix
        ../../home/cli/atuin.nix
        ../../home/cli/bash.nix
        ../../home/cli/fd.nix
        ../../home/cli/nushell.nix
        ../../home/cli/starship.nix
        ../../home/cli/zoxide.nix
      ]
      ++ filesystem.listFilesRecursive ../../home/wayland;

    # Home Manager Settings
    home = {
      username = "${username}";
      homeDirectory = "/home/${username}";
      stateVersion = "25.11";

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
        ".config/face.jpg".source = ../../pic/face.png;
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
        ".face.icon".source = ../../pic/face.png;
      };
    };
    programs.home-manager.enable = true;
  }
