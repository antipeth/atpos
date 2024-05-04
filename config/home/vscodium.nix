{pkgs, lib, ...}:
let
  inherit (import ../../options.nix) vscodium;
in lib.mkIf (vscodium == true) {
  programs.vscode = {
    enable = false;
    package = pkgs.vscodium.fhs;
    extensions = with pkgs.vscode-extensions; [
       # ms-ceintl.vscode-language-pack-zh-hans
       formulahendry.code-runner
       # ms-vscode.cpptools
       vadimcn.vscode-lldb
       vscodevim.vim
       rust-lang.rust-analyzer
     ];
  };
}
