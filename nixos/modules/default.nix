let
  base = [
    ./core.nix
    ./networking.nix
    ./users.nix
    ./ssh.nix
  ];
  services = [
    ./adguard.nix
  ];
in
{
  inherit
    base
    services
    ;
}
