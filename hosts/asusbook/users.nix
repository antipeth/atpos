{
  pkgs,
  username,
  ...
}:

let
  inherit (import ./env.nix) gitUsername;
in
{
  users.users = {
    "${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "docker"
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
      ];
      shell = pkgs.nushell;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
        # tests
        godot_4
        ventoy-full
        apacheHttpd

        # wm
        niri

        # mail
        claws-mail

        # tailscale
        tailscale

        # archiver
        xarchiver

        # communication
        legcord
        materialgram

        # dev
        devbox

        # file manager
        nemo

        # lint
        commitlint-rs

        # office tools
        onlyoffice-bin

        # git cli tools
        onefetch

        # chat
        mumble

        # password manager
        keepassxc

        # ssh client
        remmina

        # wallpaper
        swww

        # Screenshots
        swappy
        grim
        slurp

        # monitor
        nvtopPackages.full

        # System tool
        brightnessctl
        dig
        duf
        ffmpeg
        hyprpicker
        killall
        lshw
        networkmanagerapplet
        nmap
        openssl
        pavucontrol
        playerctl
        swaynotificationcenter
        wl-clipboard
        wl-gammarelay-rs

        # Nix tools
        deadnix
        nix-output-monitor
        nixfmt-rfc-style
        sops
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
