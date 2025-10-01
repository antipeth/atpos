{
  host,
  lib,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) Platform;
in
  with lib; {
    powerManagement = mkIf (Platform == "desktop") {
      enable = true;
      cpuFreqGovernor = "performance";
    };
    services = mkIf (Platform == "laptop") {
      tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 80;

          START_CHARGE_THRESH_BAT0 = 40;
          STOP_CHARGE_THRESH_BAT0 = 80;
        };
      };
    };
  }
