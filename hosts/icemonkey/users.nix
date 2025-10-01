{
  pkgs,
  username,
  ...
}: let
  inherit (import ./env.nix) gitUsername;
in {
  users.users = {
    "${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "nixbuild"
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
        # libreoffice-qt6
        jellyflix
        aria2
        rclone

        # ai
        aider-chat

        # video compression tools
        # handbrake

        # phone flash
        android-tools
        edl
        payload-dumper-go

        # browser
        firefox-devedition
        floorp-bin

        # editor
        # code-cursor
        # windsurf
        vscode-fhs

        # file transform
        localsend

        # media editor
        # losslesscut-bin
        gimp3

        # media player
        # jellyfin-media-player
        tsukimi
        mpv

        # wm
        # niri

        # mail
        # claws-mail

        # tailscale
        # tailscale

        # archiver
        peazip

        # communication
        legcord
        materialgram

        # dev
        devbox

        # file manager
        nemo

        # lint
        # commitlint-rs

        # git cli tools
        onefetch

        # chat
        # mumble

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
        apacheHttpd
        brightnessctl
        dig
        duf
        ffmpeg
        hyprpicker
        iperf3
        just
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
        zenith
        zoxide

        # Nix tools
        alejandra
        deadnix
        expect
        nix-output-monitor
        sops
        (
          let
            base = pkgs.appimageTools.defaultFhsEnvArgs;
          in
            pkgs.buildFHSEnv (
              base
              // {
                name = "fhs";
                targetPkgs = pkgs:
                  (base.targetPkgs pkgs)
                  ++ (with pkgs; [
                    pkg-config
                    ncurses
                    rustc
                    cargo
                    graphene
                  ]);
                profile = "export FHS=1";
                runScript = "bash";
                extraOutputsToInstall = ["dev"];
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
