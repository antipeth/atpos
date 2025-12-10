{
  host,
  pkgs,
  lib,
  ...
}: {
  home.file.".config/ironbar" = {
    force = true;
    recursive = true;
    source = ../../dotfiles/.config/zed;
  };
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
    extraPackages = with pkgs; [
      nixd
      nil
      rustfmt
      rust-analyzer
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
        edit_prediction_provider = "none";
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
        nixd = {
          binary = {
            path_lookup = true;
          };
          initialization_options = {
            diagnostics.suppress = ["sema-extra-with"];
            nixpkgs.expr = ''import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { }'';
            options = {
              nixos.expr = ''(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${host}.options'';
              home_manager.expr = ''(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${host}.options.home-manager.users.type.getSubOptions []'';
            };
            flake_parts.expr = ''let flake = builtins.getFlake ((builtins.toString ./.)); in flake.debug.options // flake.currentSystem.options'';
          };
        };
        nil = {
          binary = {
            path_lookup = true;
          };
          initialization_options = {
            diagnostics.ignored = ["unused_binding"];
            nix = {
              maxMemoryMB = 4096;
              flake = {
                autoArchive = true;
                autoEvalInputs = true;
                nixpkgsInputName = "nixpkgs";
              };
            };
          };
        };
      };
      languages = {
        Nix = {
          language_servers = [
            "!nil"
            "nixd"
          ];
          formatter = {
            external = {
              command = "alejandra";
              arguments = [
                "--quiet"
                "--"
              ];
            };
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
