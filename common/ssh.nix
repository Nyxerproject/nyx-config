{
  services.openssh = {
    enable = true; # require public key authentication for better security
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
    #settings.PermitRootLogin = "yes";
  };
  programs.ssh.startAgent = true;
  users.users."nyx".openssh.authorizedKeys = {
    keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPe4SX4TqpeC4WSWKwv/k52oZL+7cT/Y8YOkmv3rlO5B nyx@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK97A9B9GmNFaHYGCZfiMzud4RKSfZ9G8L184fl3+PbW nyx@nixos"
    ];
    #keyFile = [/etc/nixos/ssh/authorized_keys];
  };
}
