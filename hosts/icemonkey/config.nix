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
      # ./disk-extra3.nix
      ./disko-config.nix
      ./hardware.nix
      ./users.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../../modules;

  networking.hostId = "8890cbcb";
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

  boot.kernelParams = ["zfs.zfs_arc_max=6442450944"];
}
