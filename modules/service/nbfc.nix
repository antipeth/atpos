{
  lib,
  pkgs,
  ...
}: let
  myUser = "atp"; #adjust this to your username
  command = "bin/nbfc_service --config-file '/home/${myUser}/.config/nbfc.json'";
in
  lib.mkIf false {
    environment.systemPackages = with pkgs; [
      nbfc-linux
    ];
    systemd.services.nbfc_service = {
      enable = true;
      description = "NoteBook FanControl service";
      serviceConfig.Type = "simple";
      path = [pkgs.kmod];

      # if you are on stable uncomment the next line
      #  script = "${inputs.nbfc-linux.packages.x86_64-linux.default}/${command}";
      # if you are on unstable uncomment the next line
      script = "${pkgs.nbfc-linux}/${command}";

      wantedBy = ["multi-user.target"];
    };
  }
