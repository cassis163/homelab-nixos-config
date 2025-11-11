{ inputs, pkgs, ... }:
let
  moduleSets = import ../modules;
in
{
  networking.hostName = "ca-homelab";

  imports =
    moduleSets.base
    ++ [
      inputs.hardware.nixosModules.minix-z150-0db
      ./hardware-configuration.nix
    ];

}
