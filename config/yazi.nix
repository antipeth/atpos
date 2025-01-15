{ pkgs, config, ... }:
{
  programs.yazi = {
    enable = true;
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "g" "s"];
          run = "cd ~/System";
          desc = "cd to System";
        }
        {
          on = [ "g" "p"];
          run = "cd ~/Program";
          desc = "cd to Program";
        }
      ];
    };
  };
}
