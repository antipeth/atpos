{
  pkgs,
  lib,
  username,
  nixvim,
  ...
}:
{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  # Import Program Configurations
  imports = [
    nixvim.homeManagerModules.nixvim
    ../../nixvim
  ] ++ lib.filesystem.listFilesRecursive ../../home;

  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ../../pic/wallpapers;
    recursive = true;
  };
  home.file.".config/wlogout/icons" = {
    source = ../../pic/wlogout;
    recursive = true;
  };
  home.file.".face.icon".source = ../../pic/face.jpg;
  home.file.".config/face.jpg".source = ../../pic/face.jpg;
  home.file.".config/swappy/config".text = ''
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

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Scripts
  home.packages = [
    (import ../../scripts/task-waybar.nix { inherit pkgs; })
    (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ../../scripts/wallsetter.nix {
      inherit pkgs;
      inherit username;
    })
  ];

  programs = {
    home-manager.enable = true;
    fd = {
      enable = true;
      hidden = true;
    };
  };
}
