{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.komari-agent-rs;
  inherit
    (lib)
    types
    mkIf
    mkOption
    mkEnableOption
    ;
in {
  options.services.komari-agent-rs = {
    enable = mkEnableOption "komari-agent-rs";
    endpoint = mkOption {
      type = types.str;
      default = "http://127.0.0.1:25774";
      description = "The komari-agent-rs connect server url";
    };
    token = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "The komari-agent-rs api token";
    };
    extraFlags = mkOption {
      type = types.str;
      default = "";
      description = "Extra commandline options for komari-agent-rs";
    };
    user = mkOption {
      type = types.str;
      default = "komari-agent-rs";
      description = "The user komari-agent-rs should run as.";
    };
    group = mkOption {
      type = types.str;
      default = "komari-agent-rs";
      description = "The group komari-agent-rs should run as.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.endpoint != null;
        message = "services.komari-agent-rs: either endpoint must be specified";
      }
      {
        assertion = cfg.token != null;
        message = "services.komari-agent-rs: either token must be specified";
      }
    ];

    nixpkgs.overlays = [
      (_final: prev: {
        komari-agent-rs = prev.callPackage ../../pkgs/komari-agent-rs/default.nix {};
      })
    ];

    systemd.services.komari-agent-rs = {
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      description = "komari-agent-rs";
      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = ''
          ${pkgs.komari-agent-rs}/bin/komari-agent-rs \
          --http-server ${cfg.endpoint} \
          ${lib.optionalString (cfg.token != null) "-t ${cfg.token} "} \
          ${cfg.extraFlags}
        '';
        ExecStop = "on-failure";
        StateDirectory = "komari-agent-rs";
        SyslogIdentifier = "komari-agent-rs";
        RuntimeDirectory = "komari-agent-rs";
      };
    };

    users.users = mkIf (cfg.user == "komari-agent-rs") {
      komari-agent-rs = {
        name = "komari-agent-rs";
        group = cfg.group;
        isSystemUser = true;
      };
    };
    users.groups = mkIf (cfg.group == "komari-agent-rs") {komari-agent-rs = {};};
  };
}
