{
  pkgs,
  ...
}:
let
  inherit (import ./variables.nix) keyboardLayout;
in
{
  imports = [
    ./disko-config.nix
    ./hardware.nix
    ./users.nix
    ../../modules/driver/amd-drivers.nix
    ../../modules/driver/intel-drivers.nix
    ../../modules/local-hardware-clock.nix
    # ../../modules/nfs.nix
    ../../modules/driver/nvidia-drivers.nix
    ../../modules/driver/nvidia-prime-drivers.nix

    ../../modules/service/disk.nix
    ../../modules/service/dm.nix
    ../../modules/service/misc.nix
    ../../modules/service/power-management.nix
    ../../modules/service/remote-filesystem.nix

    ../../modules/system/base.nix
    ../../modules/system/environment.nix
    ../../modules/system/network.nix
    ../../modules/system/nix.nix
    ../../modules/vm-guest-services.nix
    ../../modules/zfs.nix
  ];
  # Styling Options
  stylix = {
    enable = true;
    image = ../../config/pic/wallpapers/blackhole.jpg;
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 20;
        terminal = 20;
        desktop = 20;
        popups = 20;
      };
    };
  };
  # Extra Module Options
  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = false;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };
  drivers.intel.enable = true;
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  users = {
    mutableUsers = true;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      material-icons
    ];
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
    disabledDefaultBackends = [ "escl" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Extra Logitech Support
  hardware.logitech.wireless.enable = false;
  hardware.logitech.wireless.enableGraphical = false;

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Virtualization / Containers
  # virtualisation.libvirtd.enable = false;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf.enable = true;
    };
  };
  virtualisation.podman = {
    enable = false;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
