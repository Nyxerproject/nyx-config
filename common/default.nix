{inputs, ...}: {
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
    inputs.disko.nixosModules.disko
    inputs.chaotic.nixosModules.default

    ./nixvim
    ./nix
    ./localization.nix
    ./security
    ./scripts.nix
    ./tailscale.nix
    ./ssh.nix

    ./packages.nix
    ./development.nix
    ./theme
    ./homemanager
    ./networking
  ];
}
