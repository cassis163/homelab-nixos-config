{
  ...
}:
{
  networking = {
    networkmanager.enable = true;

    # Firewall, see https://nixos.wiki/wiki/Firewall
    firewall.enable = true;
    nftables.enable = true;
  };
}
