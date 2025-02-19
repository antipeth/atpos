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
      shell = pkgs.bash;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
        claws-mail
        devbox
        keepassxc
        just
        gcc
        xarchiver
        motrix
        nemo
        remmina
        pragtical
        materialgram
        wl-gammarelay-rs
        nix-output-monitor
        legcord
        fractal-next
        nmap
        nixd
        nil
        (
          let
            base = pkgs.appimageTools.defaultFhsEnvArgs;
          in
          pkgs.buildFHSEnv (
            base
            // {
              name = "fhs";
              targetPkgs =
                pkgs:
                (base.targetPkgs pkgs)
                ++ (with pkgs; [
                  pkg-config
                  ncurses

                ]);
              profile = "export FHS=1";
              runScript = "bash";
              extraOutputsToInstall = [ "dev" ];
            }
          )
        )
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
