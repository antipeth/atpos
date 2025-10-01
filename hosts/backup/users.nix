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
        rclone
        localsend
        micro
        nemo
        swww

        # System tool
        brightnessctl
        dig
        duf
        expect
        ffmpeg
        just
        killall
        networkmanagerapplet
        pavucontrol
        playerctl
        swaynotificationcenter
        wl-clipboard
        wl-gammarelay-rs
      ];
    };
  };
}
