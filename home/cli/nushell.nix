{
  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = ./.../config.nu;
      # for editing directly to config.nu
      extraConfig = ''
          let carapace_completer = {|spans|
          carapace $spans.0 nushell $spans | from json
          }
          $env.config = {
            show_banner: false,
            completions: {
            case_sensitive: false # case-sensitive completions
            quick: true    # set to false to prevent auto-selecting completions
            partial: true    # set to false to prevent partial filling of the prompt
            algorithm: "fuzzy"    # prefix or fuzzy
            external: {
            # set to false to prevent nushell looking into $env.PATH to find more suggestions
              enable: true
            # set to lower can improve completion performance at the cost of omitting some options
              max_results: 100
              completer: $carapace_completer # check 'carapace_completer'
            }
          }
        }
        $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
        )
        def --env y [...args] {
        	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
        	yazi ...$args --cwd-file $tmp
        	let cwd = (open $tmp)
        	if $cwd != "" and $cwd != $env.PWD {
        		cd $cwd
        	}
        	rm -fp $tmp
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
      '';
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
  };
}
