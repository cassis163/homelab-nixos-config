{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.homelab = {
    domain = mkOption {
      type = types.str;
      default = "home.lab";
      description = "Primary internal domain used by homelab services.";
      example = "example.home";
    };

    localEthernetIp = mkOption {
      type = types.str;
      default = "192.168.11.119";
      description = "Local IP address that services bind to or publish.";
      example = "192.168.1.100";
    };

    localNetworkIp = mkOption {
      type = types.str;
      default = "192.168.11.121";
      description = "Local IP address that services bind to or publish.";
      example = "192.168.1.100";
    };
  };
}
