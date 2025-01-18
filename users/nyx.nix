{config, ...}: {
  users.users.nyx = {
    isNormalUser = true;
    description = "nyx";
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$y$j9T$d2moNWhXMPaPXQQlBS9J7/$uQKwf.Y0xRKzbaOZCFybnrUeqB3HAnUiuzL17wA7/P3";
    #hashedPassword = config.sops.secrets.my-password.path;
  };
}
