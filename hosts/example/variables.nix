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
  BAR = "waybar"; # options: waybar or ironbar

  # Other
  BootLoader = "systemd-boot";
  QEMU = true;
  Transparent-Proxy = false;
}
