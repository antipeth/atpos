{pkgs, ...}: {
  microvm = {
    hypervisor = "qemu";
    vcpu = 2;
    mem = 1024;
    interfaces = [
      {
        type = "tap";
        id = "vm-prometheus";
        mac = "02:22:de:ad:be:ea";
      }
    ];

    shares = [
      {
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
        tag = "ro-store";
        proto = "virtiofs";
      }
    ];

    volumes = [
      {
        image = "prometheus-var.img";
        mountPoint = "/var";
        size = 256;
      }
    ];
  };

  # Normal NixOS configuration past this point

  systemd.network.enable = true;

  systemd.network.networks."20-lan" = {
    matchConfig.Type = "ether";
    networkConfig = {
      Address = [
        "192.168.6.101/24"
      ];
      Gateway = "192.168.6.1";
      DNS = ["192.168.6.1"];
      IPv6AcceptRA = true;
      DHCP = "no";
      # DHCP = "yes";
      # Address = [
      #   "10.0.0.2/24"
      # ];
      # Gateway = "10.0.0.1";
      # DNS = [ "10.0.0.1" ];
      # IPv6AcceptRA = true;
      # DHCP = "no";
    };
  };

  networking = {
    hostName = "test-microvm";
    firewall.allowedTCPPorts = [
      9090
      222
    ];
    nftables.enable = true;
  };
  services.prometheus = {
    enable = true;
  };
  services.openssh = {
    enable = true;
    ports = [222];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
  users.users.root.password = "a027g0dn8a5s";

  environment.systemPackages = with pkgs; [fastfetch];
  system.stateVersion = "25.05";
}
