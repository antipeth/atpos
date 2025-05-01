{pkgs, ...}: {
  fonts.fontconfig = {
    defaultFonts = {
      emoji = ["Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font Mono"];
      sansSerif = ["Sarasa Gothic SC"];
      serif = ["Sarasa Gothic SC"];
    };
    enable = true;
  };
  gtk = {
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  qt = {
    enable = true;
  };
  home.packages = with pkgs; [
    libsForQt5.qt5ct
    qt6ct
    sarasa-gothic
  ];
  # Styling Options
  stylix.targets = {
    hyprland.enable = false;
    rofi.enable = false;
    waybar.enable = false;
    nixvim.enable = false;
  };
}
