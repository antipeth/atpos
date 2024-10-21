{
  pkgs,
  username,
  ...
}:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users.users = {
    "${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
      ];
      shell = pkgs.nushell;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
        anytype
        neovim
        devbox
        bitwarden
        keepassxc
        just
        joplin-desktop
        gcc
        peazip
        syncthingtray
        zellij
        floorp
        vesktop
        firefox-devedition-bin-unwrapped
        libreoffice
        nemo
      ];
    };
    # "newuser" = {
    #   homeMode = "755";
    #   isNormalUser = true;
    #   description = "New user account";
    #   extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    #   shell = pkgs.bash;
    #   ignoreShellProgramCheck = true;
    #   packages = with pkgs; [];
    # };
  };
}
