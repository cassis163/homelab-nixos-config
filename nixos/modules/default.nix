let
  base = [
    ./core.nix
    ./networking.nix
    ./users.nix
    ./ssh.nix
  ];
in
{
  inherit
    base
    ;
}
