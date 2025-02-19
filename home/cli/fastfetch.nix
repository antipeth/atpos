{
  programs.fastfetch = {
    enable = true;

    settings = {
      display = {
        color = {
          keys = "35";
          output = "90";
        };
      };

      modules = [
        "break"
        {
          type = "custom";
          format = "╭────────────┬────────────Hardware────────────────╮";
        }
        {
          type = "host";
          key = " PC         │";
          format = "{2}";
        }
        {
          type = "board";
          key = "│ ╠ Board   │";
          format = "{1}";
        }
        {
          type = "cpu";
          key = "│ ╠ CPU     │";
          format = "{1}";
        }
        {
          type = "gpu";
          key = "│ ╠ GPU     │";
          format = "{1} {2}";
        }
        {
          type = "memory";
          key = "│ ╠ RAM     │";
        }
        {
          type = "disk";
          key = "│ ╠ Disk    │";
          format = "{1} / {2} ({3}) {9}";
        }
        {
          type = "display";
          key = "│ ╠󰍺 Display │";
          format = "{1}x{2}@{3}Hz in {12}-inch";
        }
        {
          type = "battery";
          key = "│ ╠ Battery │";
        }
        {
          type = "uptime";
          key = "│ ╚ Uptime  │";
          format = "{1} days {2} hours {3} minutes";
        }
        {
          type = "custom";
          format = "╰────────────┴────────────────────────────────────╯";
        }
        "break"
        {
          type = "custom";
          format = "╭────────────┬────────────Software───────────────────────╮";
        }
        {
          type = "os";
          key = " OS         │";
        }
        {
          type = "kernel";
          key = "│ ╠ Kernel  │";
          format = "{1} {2}";
        }
        {
          type = "packages";
          key = "│ ╠󰏖 Packages│";
        }
        {
          type = "shell";
          key = "│ ╠ Shell   │";
          format = "{6} {4}";
        }
        {
          type = "terminal";
          key = "│ ╠ Terminal│";
          format = "{5} {6}";
        }
        {
          type = "lm";
          key = "│ ╠󰍂 LM      │";
        }
        {
          type = "de";
          key = "│ ╠ DE      │";
          format = "{2}";
        }
        {
          type = "wm";
          key = "│ ╠󱂬 WM      │";
          format = "{2} {5}";
        }
        {
          type = "cursor";
          key = "│ ╠󱄨 Cursor  │";
        }
        {
          type = "terminalfont";
          key = "│ ╠󰬴 Font    │";
        }
        {
          type = "icons";
          key = "│ ╠ Icons   │";
          format = "{1} {2}";
        }
        {
          type = "title";
          key = "│ ╚ Hostname│";
          format = "{8}";
        }
        {
          type = "custom";
          format = "╰────────────┴───────────────────────────────────────────╯";
        }
        "break"
      ];
    };
  };
}
