{
  host,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (import ../../hosts/${host}/env.nix) QEMU;
in {
  config = mkIf QEMU {
    programs.virt-manager.enable = true;
    services = {
      qemuGuest.enable = true;
      spice-vdagentd.enable = true;
      spice-webdavd.enable = true;
    };
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf.enable = true;
      };
    };
  };
}
