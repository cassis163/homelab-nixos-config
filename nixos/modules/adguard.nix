{ config, ... }:
let
  inherit (config.homelab) domain localNetworkIp;
in
{
  # Set up according to docs: https://wiki.nixos.org/wiki/Adguard_Home

  services.adguardhome = {
    enable = true;

    settings = {
      users = [
        {
          name = "admin";
          password = "$2y$10$zQWrY88SvXN3mOIcEuiPxeRRPgDsOYZRsdtE3Gcg84R04Mh/8kyfm";
        }
      ];
      http = {
        # You can select any ip and port, just make sure to open firewalls where needed
        address = "127.0.0.1:3000";
      };
      dns = {
        upstream_dns = [
          # Quad9 DNS: https://adguard-dns.io/kb/general/dns-providers/#quad9-dns

          "https://dns.quad9.net/dns-query"
        ];

        rewrites = [
          {
            domain = "adguard.${domain}";
            answer = localNetworkIp;
          }
          {
            domain = "traefik.${domain}";
            answer = localNetworkIp;
          }
          {
            domain = "qbittorrent.${domain}";
            answer = localNetworkIp;
          }
        ];
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;

        parental_enabled = false; # Parental control-based DNS requests filtering.
        safe_search = {
          enabled = false; # Enforcing "Safe search" option for search engines, when possible.
        };
      };
      # The following notation uses map
      # to not have to manually create {enabled = true; url = "";} for every filter
      # This is, however, fully optional
      # NOTE: This list goes up to 71 as of November 12th 2025
      filters =
        let
          excludedFilters = [
            37 # 'No Google' filter (Google, Perplexity AI, etc.)
            70 # 'mynixos.com^' filter
            56 # Unbased top level domain filter (homelabs.guru)
          ];
          filterNumbers = builtins.filter (n: !(builtins.elem n excludedFilters)) (
            builtins.genList (n: n + 1) 71
          );
        in
        map (num: {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_${toString num}.txt";
        }) filterNumbers;

      whitelist_filters = [
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/cassis163/adguard-home-allowlist/refs/heads/main/allowlist.txt";
        }
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    53
    3000
    8089
  ]; # DNS and dashboard
  networking.firewall.allowedUDPPorts = [ 53 ]; # DNS UDP

}
