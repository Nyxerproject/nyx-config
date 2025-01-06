{
  services.openssh = {
    enable = true; # require public key authentication for better security
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key"; # TODO: move to persistent
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
    #settings.PermitRootLogin = "yes";
  };
  programs.ssh.startAgent = true;
  users.users."nyx".openssh.authorizedKeys = {
    keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPe4SX4TqpeC4WSWKwv/k52oZL+7cT/Y8YOkmv3rlO5B nyx@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK97A9B9GmNFaHYGCZfiMzud4RKSfZ9G8L184fl3+PbW nyx@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICubDSSytI0oeAPdlruWgV9lD2lovabGbp5BVYs/HHql root@top"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2jS22HmJlyqLYzcUVT96j9wXQmlb99UFW5BPMMQwVW root@down"
    ];
    # keyFile = [];
  }; # TODO: move to home-manager?
}
