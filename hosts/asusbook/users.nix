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
        code-cursor
        windsurf
        localsend
        libreoffice-qt6
        gimp3
        conda
        rustc
        cargo
        firefox-devedition
        spotify
        iperf3
        hyprpicker
        podman-compose
        tsukimi
        floorp

        # phone flash
        android-tools
        edl
        payload-dumper-go

        # libs
        # alsa-utils
        # pkg-config
        # vulkan-loader
        # vulkan-headers

        # cmake
        vscode-fhs
        # flex
        # bison

        # game emulator
        # retroarch-full
        # retroarch-assets
        # retroarch-joypad-autoconfig
        # libretro.beetle-saturn

        # video editor
        losslesscut-bin

        # media player
        jellyfin-media-player

        # crysto
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
        alejandra
        deadnix
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
