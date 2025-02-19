{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "antipeth";
  gitEmail = "0pt@disroot.org";

  # Hyprland Settings
  extraMonitorSettings = "";

  # Waybar Settings
  clock24h = false;

  # Program Options
  browser = "brave"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "alacritty"; # Set Default System Terminal
  keyboardLayout = "us";
  Bluetooth = true;

  BootLoader = "systemd-boot";

  GPU-AMD = true;
  GPU-Nvidia = false;
  GPU-Intel = false;

  Install = true;
  KernelPackages = "linuxPackages_cachyos";
  KeyboardLayout = "us";
  Locale = "en_US.UTF-8";
  TimeZone = "Asia/Singapore";

  MonitorSettings = "monitor = , highres, auto, 2";
  ScaleLevel = "2";

  Transparent-Proxy = false;
  QEMU-VM-Use-Case = true;

  WM = "Hyprland";
}
