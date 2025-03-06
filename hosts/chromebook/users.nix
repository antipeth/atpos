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
        # wm
        niri

        # archiver
        xarchiver

        # dev
        devbox

        # file manager
        nemo

        # lint
        # commitlint-rs

        # password manager
        # keepassxc

        # ssh client
        remmina

        # wallpaper
        swww

        # System tool
        brightnessctl
        dig
        duf
        ffmpeg
        # hyprpicker
        killall
        networkmanagerapplet
        pavucontrol
        playerctl
        swaynotificationcenter
        wl-clipboard
        wl-gammarelay-rs

        # Nix tools
        # deadnix
        # nix-output-monitor
        # nixfmt-rfc-style
        # sops
        # (
        #   let
        #     base = pkgs.appimageTools.defaultFhsEnvArgs;
        #   in
        #   pkgs.buildFHSEnv (
        #     base
        #     // {
        #       name = "fhs";
        #       targetPkgs =
        #         pkgs:
        #         (base.targetPkgs pkgs)
        #         ++ (with pkgs; [
        #           pkg-config
        #           ncurses
        #         ]);
        #       profile = "export FHS=1";
        #       runScript = "bash";
        #       extraOutputsToInstall = [ "dev" ];
        #     }
        #   )
        # )
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
