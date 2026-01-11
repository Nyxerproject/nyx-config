{ lib, ... }:
{
  imports = [
    ./tailscale.nix
    ./ssh.nix
  ];
  networking = {
    wireless.iwd.enable = true;
    wireless.enable = false;
    # networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    firewall.enable = true;
  };
  security.pki.certificateFiles = [ (./. + "/dogstar.crt") ];
}
