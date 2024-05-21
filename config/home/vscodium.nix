{pkgs, lib, ...}:
let
  inherit (import ../../options.nix) vscodium;
in lib.mkIf (vscodium == true) {
  programs.vscode = {
    enable = true;
    package = 
    ( pkgs.vscodium.override
      {
          # https://wiki.archlinux.org/title/Wayland#Electron
        commandLineArgs = [
          "--ozone-platform-hint=auto"
          "--ozone-platform=wayland"
          # make it use GTK_IM_MODULE if it runs with Gtk4, so fcitx5 can work with it.
          # (only supported by chromium/chrome at this time, not electron)
          "--gtk-version=4"
          # make it use text-input-v1, which works for kwin 5.27 and weston
          "--enable-wayland-ime"

          # TODO: fix https://github.com/microsoft/vscode/issues/187436
          # still not works...
          "--password-store=basic" # use gnome-keyring as password store
        ];     
      });
    # extensions = with pkgs.vscode-extensions; [
       # ms-ceintl.vscode-language-pack-zh-hans
       # formulahendry.code-runner
       # ms-vscode.cpptools
       #vadimcn.vscode-lldb
       #vscodevim.vim
       #rust-lang.rust-analyzer
     # ];
  };
}
