{ config, pkgs, ... }:

{
  imports = [
    ./amd-gpu.nix
    # ./appimages.nix
    ./boot.nix
    ./distrobox.nix
    ./hwclock.nix
    ./intel-amd.nix
    ./intel-gpu.nix
    ./intel-nvidia.nix
    ./kernel.nix
    ./logitech.nix
    ./nfs.nix
    ./ntp.nix
    ./nvidia.nix
    # ./python.nix
    ./services.nix
    ./syncthing.nix
    ./vm.nix
  ];
}
