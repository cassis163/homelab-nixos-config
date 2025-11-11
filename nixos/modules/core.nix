{
  inputs,
  lib,
  config,
  ...
}:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  nix = {
    settings = {
      experimental-features = lib.mkDefault "nix-command flakes";
    };

    channel.enable = lib.mkDefault false;

    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;

    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 14d";
    };

    optimise.automatic = lib.mkDefault true;
  };

  system.stateVersion = lib.mkDefault "25.05";

  boot.loader = {
    systemd-boot.enable = lib.mkDefault true;
    grub.enable = lib.mkDefault false;
    efi = {
      canTouchEfiVariables = lib.mkDefault true;
      efiSysMountPoint = lib.mkDefault "/boot";
    };
  };
}
