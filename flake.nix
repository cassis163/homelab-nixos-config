{
  description = "cassis163's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    hardware.url = "github:cassis163/nixos-hardware/add-minix-neo-z150-0db";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      hardware,
      disko,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      defaultSystem = "x86_64-linux";

      mkHost = hostPath:
        lib.nixosSystem {
          system = defaultSystem;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            disko.nixosModules.disko
            ./disko-config.nix
            hostPath
          ];
        };
    in
    {
      nixosConfigurations = {
        homelab = mkHost ./nixos/host;
      };
    };
}
