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
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  qt = {
    enable = true;
    style.name = "kvantum";
  };
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6ct
    sarasa-gothic
  ];
  # Styling Options
  stylix.targets = {
    hyprland.enable = false;
    waybar.enable = false;
    nixvim.enable = false;
  };
}
