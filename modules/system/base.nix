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
    KeyboardLayout
    Locale
    TimeZone
    ZFS-Support
    ;
in
  with lib; {
    boot = {
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
      kernelModules = [
        # "asus-ec-sensors"
        "v4l2loopback" # This is for OBS Virtual Cam Support
      ];
      extraModulePackages = [
        # config.boot.kernelPackages.asus-ec-sensors
        config.boot.kernelPackages.v4l2loopback
      ];
      # Needed For Some Steam Games
      kernel.sysctl = {
        "vm.max_map_count" = 2147483642; # Needed For Some Steam Games
        "kernel.core_pattern" = "|/bin/false"; # Disable automatic core dumps
      };
      # Bootloader.
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = mkIf (BootLoader == "systemd-boot") {
          configurationLimit = 50;
          editor = false;
          enable = true;
        };
        grub = mkIf (strings.hasInfix "grub" BootLoader) {
          configurationLimit = 50;
          device = "nodev";
          efiInstallAsRemovable = true;
          efiSupport = true;
          enable = true;
          mirroredBoots = mkIf (BootLoader == "grub-mirror") [
            {
              devices = ["nodev"];
              path = "/boot";
            }
            {
              devices = ["nodev"];
              path = "/boot-mirror";
            }
          ];
          theme = mkForce "${pkgs.minimal-grub-theme}";
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

    console = {
      earlySetup = true;
      keyMap = KeyboardLayout;
    };

    # Enable networking
    networking = {
      hostName = host;
      firewall.enable = false;
    };

    security = {
      rtkit.enable = true;
      sudo.enable = false;
      sudo-rs = {
        enable = true;
        execWheelOnly = true;
      };
      pam.services = {
        hyprlock = {};
        login.kwallet.enable = mkForce false;
      };
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

    system = {
      rebuild.enableNg = true;
      stateVersion = "26.05";
    };
  }
