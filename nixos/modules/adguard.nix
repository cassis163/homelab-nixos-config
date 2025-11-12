{ config, ... }:
{
  # Set up according to docs: https://wiki.nixos.org/wiki/Adguard_Home

  services.adguardhome = {
    enable = true;
    settings = {
      http = {
        # You can select any ip and port, just make sure to open firewalls where needed
        address = "127.0.0.1:3000";
      };
      dns = {
        upstream_dns = [
          # Quad9 DNS: https://adguard-dns.io/kb/general/dns-providers/#quad9-dns

          # DNSCrypt upstreams
          # sdns://AQMAAAAAAAAADDkuOS45Ljk6ODQ0MyBnyEe4yHWM0SAkVUO-dWdG3zTfHYTAC4xHA2jfgh2GPhkyLmRuc2NyeXB0LWNlcnQucXVhZDkubmV0
          # sdns://AQMAAAAAAAAAElsyNjIwOmZlOjpmZV06ODQ0MyBnyEe4yHWM0SAkVUO-dWdG3zTfHYTAC4xHA2jfgh2GPhkyLmRuc2NyeXB0LWNlcnQucXVhZDkubmV0

          # DNS over TLS upstream
          "tls://dns.quad9.net"
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
          filterNumbers =
            # Exclude 'No Google' filter number 37
            builtins.filter (n: n != 37) (builtins.genList (n: n + 1) 71);
        in
        map (num: {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_${toString num}.txt";
        }) filterNumbers;
    };
  };

  networking.firewall.allowedTCPPorts = [
    53
    3000
    8089
  ]; # DNS and dashboard
  networking.firewall.allowedUDPPorts = [ 53 ]; # DNS UDP

}
