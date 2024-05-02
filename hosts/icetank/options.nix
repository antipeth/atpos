# PLEASE READ THE WIKI FOR DETERMINING
# WHAT TO PUT HERE AS OPTIONS. 
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options

let
  # THINGS YOU NEED TO CHANGE
  username = "icetank";
  hostname = "icetank";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/icetankos";
  # waybarStyle = "slickbar-num"; # simplebar, slickbar, slickbar-num, or default
in {
  # User Variables
  username = "${username}";
  hostname = "${hostname}";
  flakeDir = "${flakeDir}";
  flakePrev = "${userHome}/.antipethos-previous";
  flakeBackup = "${userHome}/.antipethos-backup";
 
  # System Settings
  clock24h = false;
  theLocale = "zh_CN.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "";
  theKBDVariant = "";
  theLCVariables = "zh_CN.UTF-8";
  theTimezone = "Asia/Shanghai";
  theShell = "bash"; # Possible options: bash, zsh
  theKernel = "zen"; # Possible options: default, latest, lqx, xanmod, zen
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "intel";
  gpuType = "intel";

  # Nvidia Hybrid Devices
  # ONLY NEEDED FOR HYBRID
  # SYSTEMS! 
  intel-bus-id = "PCI:0:2:0";
  nvidia-bus-id = "PCI:1:0:0";

  # Enable / Setup NFS
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = false;

  # Enable Flatpak & Larger Programs
  distrobox = false;
  flatpak = false;
  kdenlive = false;
  blender = false;

  # Enable Support For
  # Logitech Devices
  logitech = true;

  # Enable Python & PyCharm
  python = false;
  
  # Enable SyncThing
  syncthing = false;

}
