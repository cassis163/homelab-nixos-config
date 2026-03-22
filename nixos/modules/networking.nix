{
  ...
}:
{
  networking = {
    networkmanager.enable = true;

    useDHCP = false;

    # Firewall, see https://nixos.wiki/wiki/Firewall
    firewall.enable = true;
    nftables.enable = true;
  };
}
