{pkgs, ...}: {
  programs.vscode = {
    enable = false;
    package = pkgs.vscodium-fhs;
    profiles.default.extensions = with pkgs; [
      vscode-extensions.alefragnani.project-manager
      vscode-extensions.antfu.icons-carbon
      vscode-extensions.antfu.slidev
      # vscode-extensions.arrterian.nix-env-selector
      vscode-extensions.astro-build.astro-vscode
      vscode-extensions.biomejs.biome
      vscode-extensions.bradlc.vscode-tailwindcss
      vscode-extensions.christian-kohler.path-intellisense
      vscode-extensions.continue.continue
      vscode-extensions.davidanson.vscode-markdownlint
      vscode-extensions.dbaeumer.vscode-eslint
      vscode-extensions.denoland.vscode-deno
      vscode-extensions.esbenp.prettier-vscode
      # vscode-extensions.formulahendry.code-runner
      # vscode-extensions.github.copilot
      # vscode-extensions.github.copilot-chat
      # vscode-extensions.github.vscode-github-actions
      # # vscode-extensions.gleam.gleam
      # vscode-extensions.golang.go
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.lokalise.i18n-ally
      # vscode-extensions.mkhl.direnv
      vscode-extensions.moshfeu.compare-folders
      vscode-extensions.ms-ceintl.vscode-language-pack-zh-hans
      # vscode-extensions.ms-python.debugpy
      # vscode-extensions.ms-python.python
      # vscode-extensions.ms-python.vscode-pylance
      # vscode-extensions.ms-vscode.cpptools-extension-pack
      # vscode-extensions.ms-vscode.hexeditor
      vscode-extensions.naumovs.color-highlight
      vscode-extensions.pkief.material-icon-theme
      # vscode-extensions.pylyzer.pylyzer
      # vscode-extensions.redhat.java
      # vscode-extensions.rust-lang.rust-analyzer
      # vscode-extensions.shd101wyy.markdown-preview-enhanced
      # vscode-extensions.streetsidesoftware.code-spell-checker
      vscode-extensions.tamasfe.even-better-toml
      vscode-extensions.unifiedjs.vscode-mdx
      vscode-extensions.usernamehw.errorlens
      # vscode-extensions.vadimcn.vscode-lldb
      # vscode-extensions.vscjava.vscode-java-pack
      vscode-extensions.vue.volar
      vscode-extensions.vue.vscode-typescript-vue-plugin
      vscode-extensions.wakatime.vscode-wakatime
      vscode-extensions.yoavbls.pretty-ts-errors
      vscode-extensions.yzane.markdown-pdf
      vscode-extensions.yzhang.markdown-all-in-one
    ];
    # userSettings = {
    #   prettier.documentSelectors = [ "**/*.astro" ];
    #   "[astro]" = {
    #     editor.defaultFormatter = "esbenp.prettier-vscode";
    #   };
    # };
  };
}
