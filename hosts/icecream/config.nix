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
      ./nas-hosts.nix
      ./users.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../../modules;

  networking.hostId = "2896c4e1";
  # Extra Module Options
  drivers.amdgpu.enable = GPU-AMD;
  drivers.nvidia.enable = GPU-Nvidia;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "PCI:0:2:0";
    nvidiaBusID = "PCI:1:0:0";
  };
  drivers.intel.enable = GPU-Intel;
  drivers.bluetooth.enable = Bluetooth;
  drivers.gamepad.enable = Gamepad;
  users = {
    mutableUsers = true;
  };
  services.displayManager.enable = true;
  console.keyMap = KeyboardLayout;

  boot.kernelParams = ["zfs.zfs_arc_max=4294967296"];
}
