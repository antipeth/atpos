{
  pkgs,
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
    ../../config/nixvim

    ../../config/alacritty.nix
    ../../config/atuin.nix
    ../../config/bash.nix
    ../../config/bat.nix
    ../../config/brave.nix
    ../../config/btop.nix
    ../../config/fastfetch.nix
    ../../config/floorp.nix
    ../../config/firefox.nix
    ../../config/fuzzel.nix
    ../../config/git.nix
    ../../config/helix.nix
    ../../config/hyprland.nix
    ../../config/joplin.nix
    ../../config/kitty.nix
    ../../config/nushell.nix
    ../../config/starship.nix
    ../../config/swaync.nix
    ../../config/syncthing.nix
    ../../config/vscode.nix
    ../../config/waybar.nix
    ../../config/wlogout.nix
    ../../config/yazi.nix
    ../../config/zed-editor.nix
    ../../config/zellij.nix

  ];

  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ../../config/pic/wallpapers;
    recursive = true;
  };
  home.file.".config/wlogout/icons" = {
    source = ../../config/pic/wlogout;
    recursive = true;
  };
  home.file.".face.icon".source = ../../config/pic/face.jpg;
  home.file.".config/face.jpg".source = ../../config/pic/face.jpg;
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

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Styling Options
  stylix.targets = {
    hyprland.enable = false;
    rofi.enable = false;
    waybar.enable = false;
    nixvim.enable = false;
  };
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
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
