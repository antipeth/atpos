{
  config,
  host,
  lib,
  pkgs,
  ...
}: let
  inherit
    (import ../../hosts/${host}/env.nix)
    BootLoader
    KernelPackages
    Locale
    TimeZone
    ZFS-Support
    ;
in {
  boot = {
    bcache.enable = false;
    consoleLogLevel = 2; # Only errors and warnings are displayed
    extraModprobeConfig = "blacklist mei mei_hdcp mei_me mei_pxp iTCO_wdt sp5100_tco";
    initrd = {
      compressor = "zstd";
      compressorArgs = [
        "-T0"
        "-19"
        "--long"
      ];
      systemd.enable = true;
      verbose = false;
    };
    # Kernel
    kernelPackages = pkgs.${KernelPackages};
    kernelParams = [
      "audit=0"
      "console=tty0"
      "erst_disable"
      "nmi_watchdog=0"
      "noatime"
      "nowatchdog"
    ];
    # This is for OBS Virtual Cam Support
    kernelModules = ["v4l2loopback"];
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
      "kernel.core_pattern" = "|/bin/false";
    };
    # Bootloader.
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = lib.mkIf (BootLoader == "systemd-boot") {
        configurationLimit = 50;
        editor = false;
        enable = true;
      };
      grub = lib.mkIf (lib.strings.hasInfix "grub" BootLoader) {
        configurationLimit = 50;
        device = "nodev";
        efiInstallAsRemovable = true;
        efiSupport = true;
        enable = true;
        mirroredBoots = lib.mkIf (BootLoader == "grub-mirror") [
          {
            devices = ["nodev"];
            path = "/boot";
          }
          {
            devices = ["nodev"];
            path = "/boot-mirror";
          }
        ];
        zfsSupport = ZFS-Support;
      };
      timeout = 3;
    };
    supportedFilesystems = [
      "nfs"
      # "zfs"
    ];
    plymouth.enable = true;
    tmp.cleanOnBoot = true;
  };

  # Enable networking
  networking = {
    hostName = host;
    firewall.enable = false;
  };

  # Set your time zone.
  time = {
    hardwareClockInLocalTime = false;
    timeZone = TimeZone;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = Locale;
    extraLocaleSettings = {
      LC_ADDRESS = Locale;
      LC_IDENTIFICATION = Locale;
      LC_MEASUREMENT = Locale;
      LC_MONETARY = Locale;
      LC_NAME = Locale;
      LC_NUMERIC = Locale;
      LC_PAPER = Locale;
      LC_TELEPHONE = Locale;
      LC_TIME = Locale;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  system.stateVersion = "25.05";
}
