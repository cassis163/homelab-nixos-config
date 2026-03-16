let
  base = [
    ./homelab.nix
    ./core.nix
    ./networking.nix
    ./users.nix
    ./ssh.nix
  ];
  services = [
    ./nas.nix
    ./jellyfin.nix
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
