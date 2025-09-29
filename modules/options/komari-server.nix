{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.komari-server;
  inherit
    (lib)
    types
    mkIf
    mkOption
    mkEnableOption
    ;
in {
  options.services.komari-server = {
    enable = mkEnableOption "komari-server";

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to open the default port in the firewall";
    };
    host = mkOption {
      type = types.str;
      default = "0.0.0.0";
      description = "The address for komari-server to listen";
    };
    port = mkOption {
      type = types.str;
      default = "25774";
      description = "The port for komari-server to listen";
    };
    user = mkOption {
      type = types.str;
      default = "komari-server";
      description = "The user komari-server should run as.";
    };
    group = mkOption {
      type = types.str;
      default = "komari-server";
      description = "The group komari-server should run as.";
    };
    username = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "The komari-server admin name.";
    };
    password = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "The komari-server admin password.";
    };
    environmentFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "The path to a file containing the komari-server environment variables.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = (cfg.username != null) -> (cfg.password != null);
        message = "services.komari-server: if username is set, password must also be set";
      }
      {
        assertion = (cfg.password != null) -> (cfg.username != null);
        message = "services.komari-server: if password is set, username must also be set";
      }
      {
        assertion = !((cfg.username != null || cfg.password != null) && (cfg.environmentFile != null));
        message = "services.komari-server: username/password and environmentFile are mutually exclusive";
      }
      {
        assertion = (cfg.username != null && cfg.password != null) || (cfg.environmentFile != null);
        message = "services.komari-server: either username/password pair or environmentFile must be specified";
      }
    ];

    nixpkgs.overlays = [
      (_final: prev: {
        komari-server = prev.callPackage ../../pkgs/komari-server/default.nix {};
      })
    ];

    systemd.services.komari-server = {
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      description = "komari-server";
      serviceConfig = {
        Environment =
          (lib.optional (cfg.username != null) "ADMIN_USERNAME=${cfg.username}")
          ++ (lib.optional (cfg.password != null) "ADMIN_PASSWORD=${cfg.password}");
        EnvironmentFile =
          lib.optional (cfg.environmentFile != null) cfg.environmentFile;

        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${pkgs.komari-server}/bin/komari server -l ${cfg.host}:${cfg.port}";
        ExecStop = "on-failure";
        StateDirectory = "komari-server";
        SyslogIdentifier = "komari-server";
        RuntimeDirectory = "komari-server";
        WorkingDirectory = "/var/lib/komari-server";
      };
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall ["${cfg.port}"];

    users.users = mkIf (cfg.user == "komari-server") {
      komari-server = {
        name = "komari-server";
        group = cfg.group;
        isSystemUser = true;
      };
    };
    users.groups = mkIf (cfg.group == "komari-server") {komari-server = {};};
  };
}
