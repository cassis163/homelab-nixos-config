{ lib, config, ... }:
let
  inherit (config.homelab) domain localNetworkIp;
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
          address = "${localNetworkIp}:80";
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
        qbittorrent = {
          rule = lib.mkDefault "Host(`qbittorrent.${domain}`)";
          service = "qbittorrent";
          entryPoints = [ "local" ];
        };
        bitmagnet = {
          rule = lib.mkDefault "Host(`bitmagnet.${domain}`)";
          service = "bitmagnet";
          entryPoints = [ "local" ];
        };
        jellyfin = {
          rule = lib.mkDefault "Host(`jellyfin.${domain}`)";
          service = "jellyfin";
          entryPoints = [ "local" ];
        };
      };

      services = {
        qbittorrent = {
          loadBalancer = {
            servers = [ { url = "http://localhost:8081"; } ];
          };
        };
        bitmagnet = {
          loadBalancer = {
            servers = [ { url = "http://localhost:8082"; } ];
          };
        };
        jellyfin = {
          loadBalancer = {
            servers = [ { url = "http://localhost:8096"; } ];
          };
        };
      };
    };
  };
}
