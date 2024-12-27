{inputs, ...}: {
  imports = [
    # common modules
    inputs.nixos-generators.nixosModules.all-formats
    inputs.disko.nixosModules.disko

    ./theme
    ./nixvim
    ./nix
    ./localization.nix
    ./security
    ./mullvad.nix
    ./packages.nix
    ./scripts.nix
    ./tailscale.nix
    ./ssh.nix
    ./development.nix
    ./homemanager
    ./networking
  ];
}
