{ config, ... }:
{
  # See https://nixos.wiki/wiki/NFS

  systemd.tmpfiles.rules = [
    "d /export/nas 0755 root root -"
  ];

  services.nfs.server = {
    enable = true;
    exports = ''
      /export/nas 192.168.11.0/24(rw,sync,no_subtree_check,fsid=1001)
    '';
  };

  networking.firewall.allowedTCPPorts = [ 2049 ];
}
