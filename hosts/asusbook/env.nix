{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "antipeth";
  gitEmail = "0pt@disroot.org";

  # TimeZone / Locale
  TimeZone = "Asia/Singapore";
  Locale = "en_US.UTF-8";

  # Waybar Settings
  clock24h = false;

  # Hyprland Settings
  extraMonitorSettings = "";
  KeyboardLayout = "us";
  ScaleLevel = "2";
  MonitorSettings = "monitor = , highres, auto, 2";

  # Program Options
  browser = "brave"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "alacritty"; # Set Default System Terminal

  # Driver options
  Bluetooth = true;
  GPU-AMD = false;
  GPU-Nvidia = false;
  GPU-Intel = true;

  # Window Manager
  WM = "niri"; # options: Hyprland or niri
  # System
  BootLoader = "systemd-boot"; # options: systemd-boot, grub, grub-mirror
  KernelPackages = "linuxPackages_cachyos"; # see https://search.nixos.org/options?show=boot.kernelPackages https://www.nyx.chaotic.cx/#using-sched-ext-schedulers
  QEMU = true;
  Transparent-Proxy = false;
  ZFS-Support = true;
}
