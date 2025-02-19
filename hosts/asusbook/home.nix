{
  host,
  lib,
  nixvim,
  pkgs,
  username,
  ...
}:
with lib;
let
  inherit (import ../../hosts/${host}/./variables.nix) QEMU;
in
{
  dconf.settings = mkIf QEMU {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Import Program Configurations
  imports = [
    nixvim.homeManagerModules.nixvim
    ../../nixvim
  ] ++ lib.filesystem.listFilesRecursive ../../home;

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
      (import ../../scripts/task-waybar.nix { inherit pkgs; })
      (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
      (import ../../scripts/wallsetter.nix {
        inherit pkgs;
        inherit username;
      })
    ];
    sessionVariables = {
      EDITOR = "nvim";
      _JAVA_AWT_WM_NONREPARENTING = 1;
      AWT_TOOLKIT = "MToolkit";
      CLUTTER_BACKEND = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      GDK_BACKEND = "wayland";
      GTK_USE_PORTAL = 1;
      MOZ_ENABLE_WAYLAND = 1;
      NIXOS_OZONE_WL = 1;
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      QT_QPA_PLATFORM = "wayland";
      SDL_HINT_VIDEODRIVER = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "niri";

      QT_IM_MODULE = "fcitx";
      SDL_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
  };
  programs.home-manager.enable = true;
}
