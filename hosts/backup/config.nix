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
in
  with lib; {
    imports =
      [
        ./hardware.nix
        ./users.nix
        # ./disk-extra1.nix
        # ./disk-extra2.nix
        # ./disk-extra3.nix

        ../../modules/service/ddm.nix
        ../../modules/service/disk.nix
        ../../modules/service/misc.nix
        ../../modules/service/ntp.nix
        ../../modules/service/polkit.nix
        ../../modules/service/power-management.nix
        ../../modules/service/stylix.nix
      ]
      ++ filesystem.listFilesRecursive ../../modules/system
      ++ filesystem.listFilesRecursive ../../modules/options
      ++ filesystem.listFilesRecursive ../../modules/driver;

    networking.hostId = "48ab1c58";
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
  }
