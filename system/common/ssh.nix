{
  services.openssh = {
    enable = true; # require public key authentication for better security
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
    #settings.PermitRootLogin = "yes";
  };
  users.users."nyx".openssh.authorizedKeys = {
    keys = [
      "sh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPe4SX4TqpeC4WSWKwv/k52oZL+7cT/Y8YOkmv3rlO5B nyx@nixos"
    ];
    #keyFile = [/etc/nixos/ssh/authorized_keys];
  };
}
