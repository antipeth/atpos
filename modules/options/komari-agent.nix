{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.komari-agent;
  inherit
    (lib)
    types
    mkIf
    mkOption
    mkEnableOption
    ;
in {
  options.services.komari-agent = {
    enable = mkEnableOption "komari-agent";
    endpoint = mkOption {
      type = types.str;
      default = "http://127.0.0.1:25774";
      description = "The komari-agent connect server url";
    };
    token = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "The komari-agent api token";
    };
    disableAutoUpdate = mkOption {
      type = types.bool;
      default = false;
      description = "Disable automatic updates";
    };
    disableWebSsh = mkOption {
      type = types.bool;
      default = false;
      description = "Disable remote control(web ssh and rce)";
    };
    extraFlags = mkOption {
      type = types.str;
      default = "";
      description = "Extra commandline options for komari-agent";
    };
    user = mkOption {
      type = types.str;
      default = "komari-agent";
      description = "The user komari-agent should run as.";
    };
    group = mkOption {
      type = types.str;
      default = "komari-agent";
      description = "The group komari-agent should run as.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.endpoint != null;
        message = "services.komari-agent: either endpoint must be specified";
      }
      {
        assertion = cfg.token != null;
        message = "services.komari-agent: either token must be specified";
      }
    ];

    nixpkgs.overlays = [
      (_final: prev: {
        komari-agent = prev.callPackage ../../pkgs/komari-agent/default.nix {};
      })
    ];

    systemd.services.komari-agent = {
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      description = "komari-agent";
      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = ''
          ${pkgs.komari-agent}/bin/komari-agent \
          -e ${cfg.endpoint} \
          ${lib.optionalString (cfg.token != null) "-t ${cfg.token} "} \
          ${lib.optionalString cfg.disableAutoUpdate "--disable-auto-update"} \
          ${lib.optionalString cfg.disableWebSsh "--disable-web-ssh"} \
          ${cfg.extraFlags}
        '';
        ExecStop = "on-failure";
        StateDirectory = "komari-agent";
        SyslogIdentifier = "komari-agent";
        RuntimeDirectory = "komari-agent";
      };
    };

    users.users = mkIf (cfg.user == "komari-agent") {
      komari-agent = {
        name = "komari-agent";
        group = cfg.group;
        isSystemUser = true;
      };
    };
    users.groups = mkIf (cfg.group == "komari-agent") {komari-agent = {};};
  };
}
