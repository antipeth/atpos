{
  # Bootloader
#  boot.loader.grub.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader = {
  #   efi = {
  #     canTouchEfiVariables = true;
  #   };
  #   grub = {
  #     enable = true;
  #     efiSupport = true;
  #     device = "nodev";
  #     useOSProber=true;
  #   };
  # };
  boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; };
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%";

  # This is for OBS Virtual Cam Support - v4l2loopback setup
  # boot.kernelModules = [ "v4l2loopback" ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
}
