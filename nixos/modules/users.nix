{
  config,
  pkgs,
  ...
}:
{
  users.users = {
    caspera = {
      hashedPassword = "$y$j9T$8w6neZcY5Xw3K6iTIxQJr/$i7fv0qBQ9gW7VLiEEsiDUCVIfiJB/OBSYmj2vZ8GFE/";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "podman"
      ];
    };
  };
}
