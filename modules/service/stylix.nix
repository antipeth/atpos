{ config, pkgs, ... }:
{
  # Styling Options
  stylix = {
    enable = true;
    image = ../../pic/wallpapers/blackhole.jpg;
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        name = "Sarasa Gothic SC";
        package = pkgs.sarasa-gothic;
      };
      serif = config.stylix.fonts.sansSerif;
      sizes = {
        applications = 16;
        terminal = 16;
        desktop = 16;
        popups = 16;
      };
    };
  };
}
