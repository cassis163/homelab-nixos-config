{ ... }:
{
  users.users = {
    caspera = {
      hashedPassword = "$y$j9T$8w6neZcY5Xw3K6iTIxQJr/$i7fv0qBQ9gW7VLiEEsiDUCVIfiJB/OBSYmj2vZ8GFE/";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINwQQE8fUoPG8UPcF4zreGn1z+R0YOwjvGI2floeGDEs c.aangeenbrug@protonmail.com"
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
