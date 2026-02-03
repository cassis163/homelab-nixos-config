{ ... }:
{
  services.openvpn.servers = {
    mullvadVPN = {
      config = ''config /root/nixos/openvpn/mullvad_ch_zrh.conf '';
      autoStart = true;
      updateResolvConf = true;
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
          Password_PBKDF2 = "@ByteArray(oxp+x8Qkkcw2RGEEugCI2w==:taGl0HG/Xtu0D7W6gO82xo1lNerZCaYLGxP83K4fZKTsk0CQrbC2/h8QqIIAaP1DzTzNQDfyQRCQVzbPVcplDA==)";
          AuthSubnetWhitelistEnabled = true;
          AuthSubnetWhitelist = "192.168.0.0/16,10.0.0.0/8";
        };
        General.Locale = "en";
      };
    };
  };
}
