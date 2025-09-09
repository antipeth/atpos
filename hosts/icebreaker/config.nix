{lib, ...}: let
  inherit
    (import ./env.nix)
    Bluetooth
    Gamepad
    GPU-AMD
    GPU-Intel
    GPU-Nvidia
    KeyboardLayout
    ;
in {
  imports =
    [
      ./disko-config.nix
      ./hardware.nix
      ./users.nix
      # ./disk-extra1.nix
      ./disk-extra2.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../../modules;

  networking.hostId = "4f536e4a";
  # Extra Module Options
  drivers.amdgpu.enable = GPU-AMD;
  drivers.nvidia.enable = GPU-Nvidia;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "PCI:0:2:0";
    nvidiaBusID = "PCI:1:0:0";
  };
  drivers.intel = {
    enable = GPU-Intel;
    xeEnable = true;
    # Use lspci -nnd ::03xx to check
    intelPciID = "56a0";
  };
  drivers.bluetooth.enable = Bluetooth;
  drivers.gamepad.enable = Gamepad;
  users = {
    mutableUsers = true;
  };
  services.displayManager.enable = true;
  console.keyMap = KeyboardLayout;

  # boot.kernelParams = ["zfs.zfs_arc_max=4294967296"];
}
