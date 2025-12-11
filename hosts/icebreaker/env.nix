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

  # Driver options
  Bluetooth = true;
  Gamepad = false;
  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = true;

  # DesktopManager
  DM = "none"; # options: Gnome or none

  # Window Manager
  WM = "niri"; # options: Hyprland, niri or none
  BAR = "waybar"; # options: waybar or ironbar

  # System
  BootLoader = "systemd-boot"; # options: systemd-boot, grub, grub-mirror
  KernelPackages = "linuxPackages_zen"; # see https://search.nixos.org/options?show=boot.kernelPackages https://www.nyx.chaotic.cx/#using-sched-ext-schedulers
  QEMU = true;
  Transparent-Proxy = false;
  ZFS-Support = true;
  Syncthing = true;
  Terminal = "alacritty"; # options: alacritty or kitty
  Office = "none"; # options: onlyoffice or none
  Platform = "desktop"; # option: desktop or laptop
}
