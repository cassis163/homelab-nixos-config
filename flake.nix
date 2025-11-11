{
  description = "cassis163's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:cassis163/nixos-hardware/add-minix-neo-z150-0db";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      hardware,
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
