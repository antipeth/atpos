{ lib, ... }:
let
  inherit (import ./env.nix)
    Bluetooth
    GPU-AMD
    GPU-Intel
    GPU-Nvidia
    KeyboardLayout
    ;
in
{
  imports = [
    ./disko-config.nix
    ./hardware.nix
    # ./nas-hosts.nix
    ./users.nix
  ] ++ lib.filesystem.listFilesRecursive ../../modules;

  networking.hostId = "fc570939";
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
