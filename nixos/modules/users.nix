{ ... }:
{
  users.users = {
    caspera = {
      hashedPassword = "$y$j9T$8w6neZcY5Xw3K6iTIxQJr/$i7fv0qBQ9gW7VLiEEsiDUCVIfiJB/OBSYmj2vZ8GFE/";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFF3T+xZq949jvEQGszDu4s2QqYsOpYwq3Gcv6tpPKrt caspera@PERSONAL-LAPTOP-CA"
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
