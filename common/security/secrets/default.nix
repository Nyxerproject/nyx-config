{pkgs, ...}: {
  environment.systemPackages = [pkgs.sops];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"]; # ssh key are assumed to exist
      # keyFile = "/nix/persist/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      home-assistant-secrets = {
        restartUnits = ["home-assistant.service"];
        format = "yaml";
        # owner = "hass";
        # path = "/var/lib/hass/secrets.yaml";
      };
      my-password.neededForUsers = true;
    };
  };
}
