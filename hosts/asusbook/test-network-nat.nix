{
  networking.useNetworkd = true;
  systemd.network.enable = true;

  systemd.network.netdevs."10-microvm".netdevConfig = {
    Kind = "bridge";
    Name = "microvm";
  };
  systemd.network.networks."10-microvm" = {
    matchConfig.Name = "microvm";
    networkConfig = {
      DHCPServer = true;
      IPv6SendRA = true;
    };
    addresses = [
      {
        addressConfig.Address = "10.0.0.1/24";
      }
      {
        addressConfig.Address = "fd12:3456:789a::1/64";
      }
    ];
    ipv6Prefixes = [
      {
        ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64";
      }
    ];
  };

  # Allow inbound traffic for the DHCP server
  networking.firewall.allowedUDPPorts = [ 67 ];

  systemd.network.networks."11-microvm" = {
    matchConfig.Name = "vm-prometheus";
    # Attach to the bridge that was configured above
    networkConfig.Bridge = "microvm";
  };
  networking.nat = {
    enable = true;
    # NAT66 exists and works. But if you have a proper subnet in
    # 2000::/3 you should route that and remove this setting:
    enableIPv6 = true;

    # Change this to the interface with upstream Internet access
    externalInterface = "enp57s0";
    # The bridge where you want to provide Internet access
    internalInterfaces = [ "microvm" ];
  };

}
