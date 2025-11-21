{ config, ... }:
{
  # See https://nixos.wiki/wiki/NFS

  systemd.tmpfiles.rules = [
    "d /export/media 0755 root root -"
    "d /export/chess 0755 root root -"
  ];

  services.nfs.server = {
    enable = true;
    # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
    exports = ''
      /export         192.168.11.0/24(rw,fsid=0,no_subtree_check)

      /export/media   192.168.11.0/24(rw,nohide,insecure,no_subtree_check)

      /export/chess   192.168.11.0/24(rw,nohide,insecure,no_subtree_check) 192.168.11.253(rw,nohide,insecure,no_subtree_check)
    '';
  };

  networking.firewall = {
    allowedTCPPorts = [
      111
      2049
      4000
      4001
      4002
      20048
    ];
    allowedUDPPorts = [
      111
      2049
      4000
      4001
      4002
      20048
    ];
  };
}
