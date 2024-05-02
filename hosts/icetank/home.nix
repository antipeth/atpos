{ config, pkgs, inputs, username, ... }:

{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";


  # Import Program Configurations
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config/home
  ];

  # Define Settings For Xresources
  xresources.properties = {
    "Xcursor.size" = 24;
  };

  # Install & Configure Git
  programs.git = {
    enable = true;
    # userName = "${gitUsername}";
    # userEmail = "${gitEmail}";
  };

  # Create XDG Dirs
  # xdg = {
  #   userDirs = {
  #       enable = true;
  #       createDirectories = true;
  #   };
  # };
# 
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = ["qemu:///system"];
  #     uris = ["qemu:///system"];
  #   };
  # };

  programs.home-manager.enable = true;
}
