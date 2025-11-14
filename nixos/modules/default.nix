let
  base = [
    ./core.nix
    ./networking.nix
    ./users.nix
    ./ssh.nix
  ];
  services = [
    ./adguard.nix
    ./nas.nix
    ./qbittorrent.nix
    ./traefik.nix
  ];
in
{
  inherit
    base
    services
    ;
}
