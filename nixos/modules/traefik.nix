{ lib, config, ... }:
let
  domain = "home.lab";
  localIp = "192.168.11.119";
in
{
  networking.firewall.allowedTCPPorts = [ 80 ];

  services.traefik = {
    enable = true;

    staticConfigOptions = {
      api.dashboard = true;
      api.insecure = true;

      log = {
        level = "DEBUG";
        filePath = "/var/lib/traefik/traefik.log";
      };

      accessLog = {
        filePath = "/var/lib/traefik/access.log";
      };

      entryPoints = {
        local = {
          address = "${localIp}:80";
        };
      };
    };

    # Dashboard
    dynamicConfigOptions.http = {
      routers = {
        dashboard = {
          rule = lib.mkDefault "Host(`traefik.${domain}`)";
          service = "api@internal";
          entryPoints = [ "local" ];
        };
        adguard = {
          rule = lib.mkDefault "Host(`adguard.${domain}`)";
          service = "adguard";
          entryPoints = [ "local" ];
        };
      };

      services = {
        adguard = {
          loadBalancer = {
            servers = [ { url = "http://localhost:3000"; } ];
          };
        };
      };
    };
  };
}
