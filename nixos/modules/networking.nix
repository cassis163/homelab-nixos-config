{
  ...
}:
{
  networking = {
    networkmanager.enable = true;

    useDHCP = false;

    # Configure your network interface
    interfaces.eth0 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.11.119";
        prefixLength = 24; # Subnet mask (24 = 255.255.255.0)
      }];
    };

    # Set the default gateway
    defaultGateway = "192.168.11.1";

    # Set DNS nameservers
    nameservers = [ "1.1.1.1" "8.8.8.8" ];

    # Firewall, see https://nixos.wiki/wiki/Firewall
    firewall.enable = true;
    nftables.enable = true;
  };
}
