{ ... }:
{
  containers.torrent = {
    ephemeral = false;
    autoStart = true;
    privateNetwork = false;

    bindMounts = {
      "/root/nixos/openvpn".isReadOnly = true;
      "/export/media".isReadOnly = false;
    };

    config =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        system.stateVersion = "25.05";

        services.openvpn.servers = {
          mullvadVPN = {
            config = ''config /root/nixos/openvpn/mullvad.conf '';
          };
        };

        # Downloading Torrents (partially based on https://www.samkwort.com/qbittorrent_nixos_module)
        services.qbittorrent = {
          enable = true;
          openFirewall = true;
          webuiPort = 8081;
          user = "caspera";
          serverConfig = {
            LegalNotice.Accepted = true;
            Preferences = {
              WebUI = {
                Username = "admin";
                Password_PBKDF2 = "@ByteArray(9dcC1wlkH1YfFuG9sVp+2Q==:CbX/eqZVqFMy4sOD6Xd26TizQa+8LA1cQzsUTHUFkNcWnKf29hELmlYZFIYADQ9grqKIVu10kjedasPQ82lEwA==)";
              };
              General.Locale = "en";
            };
          };
        };

        # Indexing torrents
        services.bitmagnet = {
          enable = true;
          openFirewall = true;
          user = "caspera";
          settings = {
            port = "8082";
          };
        };
      };
  };
}
