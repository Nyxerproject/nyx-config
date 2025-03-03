{lib, ...}: {
  imports = [./tailscale.nix ./ssh.nix];
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    firewall.enable = true;
  };
}
