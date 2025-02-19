{
  programs.alacritty = {
    enable = true;
    settings = {
      colors.draw_bold_text_with_bright_colors = true;
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      selection.save_to_clipboard = true;
      window = {
        class = {
          general = "alacritty";
          instance = "alacritty";
        };
        padding = {
          x = 10;
          y = 10;
        };
      };
    };
  };
}
