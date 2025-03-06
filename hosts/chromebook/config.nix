{ lib, ... }:
let
  inherit (import ./variables.nix)
    Bluetooth
    GPU-AMD
    GPU-Intel
    GPU-Nvidia
    KeyboardLayout
    ;
in
{
  imports = [
    ./hardware.nix
    ./users.nix
  ] ++ lib.filesystem.listFilesRecursive ../../modules;

  networking.hostId = "ced6733c";
  # Extra Module Options
  drivers.amdgpu.enable = GPU-AMD;
  drivers.nvidia.enable = GPU-Nvidia;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };
  drivers.intel.enable = GPU-Intel;
  drivers.bluetooth.enable = Bluetooth;
  users = {
    mutableUsers = true;
  };
  services.displayManager.enable = true;
  console.keyMap = KeyboardLayout;
}
