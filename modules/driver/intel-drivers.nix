{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.intel;
in {
  options.drivers.intel = {
    enable = mkEnableOption "Enable Intel Graphics Drivers";
    xeEnable = mkEnableOption "Use Intel Xe Graphics Drivers Instead Of i915";
    intelPciID = mkOption {
      type = types.str;
      default = "9a49";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };

    # OpenGL
    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        vpl-gpu-rt
      ];
    };

    boot.kernelParams = mkIf cfg.xeEnable ["i915.force_probe=!${cfg.intelPciID}" "xe.force_probe=${cfg.intelPciID}"];
  };
}
