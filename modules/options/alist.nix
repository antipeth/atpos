{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.alist;
  inherit (lib)
    types
    mkIf
    mkOption
    mkEnableOption
    ;
in
{
  options.services.alist = {
    enable = mkEnableOption "Alist";

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/alist";
      description = "Directory used to store alist files.";
    };
    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to open the immich port in the firewall";
    };
    user = mkOption {
      type = types.str;
      default = "alist";
      description = "The user alist should run as.";
    };
    group = mkOption {
      type = types.str;
      default = "alist";
      description = "The group alist should run as.";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.alist-server = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      description = "alist";
      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = ''${pkgs.alist}/bin/alist server --data ${cfg.dataDir}'';
        ExecStop = ''on-failure'';
        StateDirectory = "alist";
        SyslogIdentifier = "alist";
        RuntimeDirectory = "alist";
      };
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ 5244 ];

    users.users = mkIf (cfg.user == "alist") {
      alist = {
        name = "alist";
        group = cfg.group;
        isSystemUser = true;
      };
    };
    users.groups = mkIf (cfg.group == "alist") { alist = { }; };

    environment.systemPackages = [ pkgs.alist ];
  };
}
