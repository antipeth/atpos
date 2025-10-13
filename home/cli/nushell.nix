_: {
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        fg = "job unfreeze";
      };
      extraConfig = ''
        let carapace_completer = {|spans|
            carapace $spans.0 nushell ...$spans | from json
        }
        $env.config = {
            show_banner: false,
            rm: {
                always_trash: false
            }
            table: {
                mode: markdown
                index_mode: always
                show_empty: true
                padding: { left: 1, right: 1 }
                trim: {
                    methodology: wrapping
                    wrapping_try_keep_words: true
                    truncating_suffix: "..."
                }
                header_on_separator: false
            }
            error_style: "fancy"
            display_errors: {
                exit_code: false
                termination_signal: true
            }
            datetime_format: {
                table: null
                normal: "%m/%d/%y %I:%M:%S%p"
            }
            filesize: {
                unit: "metric"
                show_unit: true
                precision: 5
            }
            float_precision: 5
            ls: {
                use_ls_colors: true
                clickable_links: true
            }
            highlight_resolved_externals: true
            explore: {
                status_bar_background: { fg: "#1D1F21", bg: "#C4C9C6" },
                command_bar_text: { fg: "#C4C9C6" },
                highlight: { fg: "black", bg: "yellow" },
                status: {
                    error: { fg: "white", bg: "red" },
                    warn: {}
                    info: {}
                },
                selected_cell: { bg: light_blue },
            }
            history: {
                max_size: 100_000
                sync_on_enter: true
                file_format: "plaintext"
                isolation: false
            }
            completions: {
                case_sensitive: false # case-sensitive completions
                quick: true    # set to false to prevent auto-selecting completions
                partial: true    # set to false to prevent partial filling of the prompt
                algorithm: "fuzzy"    # prefix or fuzzy
                sort: "smart"
                external: {
                      enable: true
                      max_results: 100
                      completer: $carapace_completer # check 'carapace_completer'
                }
                use_ls_colors: true
            }
            cursor_shape: {
                emacs: line
                vi_insert: block
                vi_normal: underscore
            }
            plugin_gc: {
                default: {
                    enabled: true
                    stop_after: 10sec
                }
                plugins: {
                }
            }
            hooks: {
                pre_prompt: [{ null }]
                pre_execution: [{ null }]
                env_change: {
                    PWD: [{|before, after|
                        if (which direnv | is-empty) {
                            return
                        }

                        direnv export json | from json | default {} | load-env
                    }]
                }
                display_output: "if (term size).columns >= 100 { table -e } else { table }"
                command_not_found: { null }
            }
        }
        $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
        )
      '';
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
