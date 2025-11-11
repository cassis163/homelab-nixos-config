let
  base = [
    ./core.nix
    ./networking.nix
    ./users.nix
  ];
in
{
  inherit
    base
    ;
}
