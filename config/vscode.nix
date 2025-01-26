{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.astro-build.astro-vscode
      pkgs.vscode-extensions.continue.continue
      pkgs.vscode-extensions.dbaeumer.vscode-eslint
      pkgs.vscode-extensions.ms-vscode.cpptools-extension-pack
      pkgs.vscode-extensions.ms-vscode-remote.vscode-remote-extensionpack
      pkgs.vscode-extensions.vue.volar
      pkgs.vscode-extensions.vue.vscode-typescript-vue-plugin
      pkgs.vscode-extensions.wakatime.vscode-wakatime
    ];
  };
}
