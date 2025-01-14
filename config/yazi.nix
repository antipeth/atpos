{ pkgs, config, ... }:
{
  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        edit = [
          {
            "run" = "hx '$@'";
            "block" = true;
            "for" = "unix";
          }
        ];
      };
      keymap = {
        manager.keymap = [
          {
            "on" = [
              "g"
              "s"
            ];
            "run" = "cd ~/System";
            "desc" = "cd to System";
          }
          {
            "on" = [
              "g"
              "p"
            ];
            "run" = "cd ~/Program";
            "desc" = "cd to Program";
          }
        ];
      };
    };
  };
}
