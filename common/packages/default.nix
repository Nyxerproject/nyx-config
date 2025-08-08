{pkgs, ...}: {
  imports = [./scripts.nix ./cli];
  environment.systemPackages = with pkgs; [];
}
