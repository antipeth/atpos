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
      # ./test-network-nat.nix
      # ./test-network-tap.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../../modules;

  networking.hostId = "fc570939";
  # Extra Module Options
  drivers.amdgpu.enable = GPU-AMD;
  drivers.nvidia.enable = GPU-Nvidia;
  drivers.nvidia-prime = {
    enable = true;
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
}
