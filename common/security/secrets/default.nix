{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.sops];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"]; # ssh key are assumed to exist
      # keyFile = "/nix/persist/var/lib/sops-nix/key.txt";
      keyFile = "/home/nyx/.config/sops/age/keys.txt";
      generateKey = true;
    };
    secrets = {
      my-password.neededForUsers = true;
    };
  };
}
