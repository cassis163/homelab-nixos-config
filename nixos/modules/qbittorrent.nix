{ config, ... }:
{
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
}
