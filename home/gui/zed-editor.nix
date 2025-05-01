{
  pkgs,
  lib,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;
    extensions = [
      "astro"
      "docker-compose"
      "git-firefly"
      "html"
      "nix"
      "nu"
      "toml"
      "wakatime"
      "vue"
      "terraform"
    ];
    extraPackages = [
      pkgs.nixd
      pkgs.nil
    ];

    ## this is integrated Lazygit into Zed
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          alt-g = [
            "task::Spawn"
            {"task_name" = "start lazygit";}
          ];
        };
      }
    ];
    ## everything inside of these brackets are Zed options.
    userSettings = {
      features = {
        copilot = false;
        inline_completion_provider = "none";
      };
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };
      autosave = "on_focus_change";
      auto_update = false;
      base_keymap = "VSCode";
      load_direnv = "shell_hook";
      tabs = {
        file_icons = false;
        git_status = false;
      };
      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };
      hour_format = "hour24";
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
            activate_script = "default";
          };
        };
        env = {
          TERM = "alacritty";
        };
        font_family = "FiraCode Nerd Font";
        font_features = null;
        font_size = null;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };
      vim_mode = false;
      show_whitespaces = "all";
    };
  };
}
