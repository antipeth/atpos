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

  # Driver options
  Bluetooth = true;
  Gamepad = true;
  GPU-AMD = false;
  GPU-Nvidia = true;
  GPU-Intel = true;

  # DesktopManager
  DM = "none"; # options: Gnome or none

  # Window Manager
  WM = "Hyprland"; # options: Hyprland, niri or none
  # System
  BootLoader = "systemd-boot"; # options: systemd-boot, grub, grub-mirror
  KernelPackages = "linuxPackages_cachyos"; # see https://search.nixos.org/options?show=boot.kernelPackages https://www.nyx.chaotic.cx/#using-sched-ext-schedulers
  QEMU = true;
  Transparent-Proxy = false;
  ZFS-Support = true;
  Syncthing = true;
  Terminal = "alacritty"; # options: alacritty or kitty
  Office = "none"; # options: onlyoffice or none
}
