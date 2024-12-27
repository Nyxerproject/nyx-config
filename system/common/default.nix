{inputs, ...}: {
  imports = [
    # common modules
    inputs.nixos-generators.nixosModules.all-formats

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
