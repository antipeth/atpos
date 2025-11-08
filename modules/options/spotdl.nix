{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.spotdl;
  inherit
    (lib)
    types
    mkIf
    mkOption
    mkEnableOption
    ;
in {
  options.services.spotdl = {
    enable = mkEnableOption "spotdl";
    host = mkOption {
      type = types.string;
      default = "127.0.0.1";
      description = "";
    };
    port = mkOption {
      type = types.port;
      default = "8800";
      description = "";
    };
    # dataDir = mkOption {
    #   type = types.nullOr types.path;
    #   default = "/var/lib/spotdl/";
    #   description = "Directory used to store openlist files.";
    # };
    # format = mkOption {
    #   type = types.nullOr types.string;
    #   default = "{title} - {artists}.{output-ext}";
    #   description = "";
    # };
    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to open the spotdl port in the firewall";
    };
    forceUpdateGui = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to open the spotdl port in the firewall";
    };
    extraFlags = mkOption {
      type = types.str;
      default = "";
      description = "";
    };
    user = mkOption {
      type = types.str;
      default = "spotdl";
      description = "The user spotdl should run as.";
    };
    group = mkOption {
      type = types.str;
      default = "spotdl";
      description = "The group spotdl should run as.";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.spotdl = {
      wantedBy = ["multi-user.target"];
      after = ["network.target" "nss-lookup.target"];
      description = "spotdl";
      serviceConfig = {
        Type = "simple";
        Environment = "HOME=/var/lib/spotdl";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = ''
          ${pkgs.spotdl}/bin/spotdl web \
          ${lib.optionalString cfg.forceUpdateGui "--force-update-gui"} \
          ${cfg.extraFlags}
        '';
        ExecStop = ''on-failure'';
        StartLimitBurst = 3;
        RestartSec = "5s";
        StateDirectory = "spotdl";
        SyslogIdentifier = "spotdl";
        RuntimeDirectory = "spotdl";
      };
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [cfg.port];

    users.users = mkIf (cfg.user == "spotdl") {
      spotdl = {
        name = "spotdl";
        group = cfg.group;
        isSystemUser = true;
      };
    };
    users.groups = mkIf (cfg.group == "spotdl") {spotdl = {};};
  };
}
