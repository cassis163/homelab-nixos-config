let
  base = [
    ./homelab.nix
    ./core.nix
    ./networking.nix
    ./users.nix
    ./ssh.nix
  ];
  services = [
    ./adguard.nix
    ./nas.nix
    ./torrent.nix
    ./traefik.nix
  ];
in
{
  inherit
    base
    services
    ;
}
