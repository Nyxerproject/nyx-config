{
  imports = [
    ./configuration.nix
    ../../users/nyx.nix

    ./boot
    ./secrets
    ./properties
    # ./services
    ./packages
  ];
}
